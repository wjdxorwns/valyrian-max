package com.ict.project.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.common.Paging;
import com.ict.project.service.NoticeService;
import com.ict.project.vo.board.BoardVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

    @Autowired
    private NoticeService noticeService;

    // 공지사항 목록 페이지
    @GetMapping
    public ModelAndView noticePageGo(@RequestParam(defaultValue = "1") int nowPage, HttpSession session) {
        String deptName = (String) session.getAttribute("user.dept_name");
        logger.info("Accessing /notice, dept_name: {}", deptName);
        ModelAndView mv = new ModelAndView("MainPage/notice");

        Paging paging = new Paging();
        paging.setNowPage(nowPage);

        int totalRecord = noticeService.getTotalNoticeCount();
        paging.setTotalRecord(totalRecord);
        paging.setTotalPage((int) Math.ceil((double) totalRecord / paging.getNumPerPage()));
        paging.setTotalBlock((int) Math.ceil((double) paging.getTotalPage() / paging.getPagePerBlock()));
        paging.setNowBlock((int) Math.ceil((double) nowPage / paging.getPagePerBlock()));
        paging.setBeginBlock((paging.getNowBlock() - 1) * paging.getPagePerBlock() + 1);
        paging.setEndBlock(Math.min(paging.getBeginBlock() + paging.getPagePerBlock() - 1, paging.getTotalPage()));
        paging.setOffset((nowPage - 1) * paging.getNumPerPage());

        List<BoardVO> noticeList = noticeService.getNoticeList(paging);
        mv.addObject("noticeList", noticeList);
        mv.addObject("paging", paging);

        return mv;
    }

    // 공지사항 등록 페이지
    @GetMapping("/write")
    public ModelAndView noticeRegistrationPageGo(HttpSession session) {
        String deptName = (String) session.getAttribute("user.dept_name");
        logger.info("Accessing /notice/write, dept_name: {}", deptName);
        return new ModelAndView("MainPage/noticeRegistration");
    }

    // 공지사항 등록
    @PostMapping("/register")
    public String register(BoardVO boardVO, @RequestParam("image") MultipartFile file, HttpSession session) {
        String deptName = (String) session.getAttribute("user.dept_name");
        logger.info("Registering notice, dept_name: {}, emp_idx: {}", deptName, session.getAttribute("user.emp_idx"));
        
        String empIdx = (String) session.getAttribute("user.emp_idx");
        if (empIdx == null) {
            logger.warn("Redirecting to /login due to missing emp_idx");
            return "redirect:/login";
        }
        boardVO.setEmp_idx(empIdx);
        try {
            noticeService.registerNotice(boardVO, file, session.getServletContext().getRealPath("/Uploads"));
            logger.info("Notice registered successfully, board_id: {}", boardVO.getBoard_id());
        } catch (Exception e) {
            logger.error("Failed to register notice: {}", e.getMessage(), e);
            return "redirect:/notice/write?error=registration_failed";
        }
        return "redirect:/notice";
    }

    // 공지사항 상세 페이지
    @GetMapping("/detail")
    public ModelAndView detail(@RequestParam("id") int boardId, HttpSession session) {
        String deptName = (String) session.getAttribute("user.dept_name");
        logger.info("Accessing /notice/detail?id={}, dept_name: {}", boardId, deptName);
        ModelAndView mv = new ModelAndView("MainPage/noticeDetail");
        BoardVO notice = noticeService.getNoticeDetail(boardId);
        if (notice != null) {
            noticeService.increaseViewCount(boardId);
            mv.addObject("board", notice);
        } else {
            logger.warn("Notice not found, board_id: {}", boardId);
            mv.setViewName("redirect:/notice");
        }
        return mv;
    }

    // 공지사항 수정 페이지
    @GetMapping("/edit")
    public ModelAndView editPageGo(@RequestParam("id") int boardId, HttpSession session) {
        String deptName = (String) session.getAttribute("user.dept_name");
        logger.info("Accessing /notice/edit?id={}, dept_name: {}", boardId, deptName);
        
        ModelAndView mv = new ModelAndView("MainPage/noticeEdit");
        BoardVO notice = noticeService.getNoticeDetail(boardId);
        if (notice != null) {
            mv.addObject("board", notice);
        } else {
            logger.warn("Notice not found, board_id: {}", boardId);
            mv.setViewName("redirect:/notice");
        }
        return mv;
    }

    // 공지사항 수정
    @PostMapping("/update")
    public String update(BoardVO boardVO, 
                         @RequestParam(value = "image", required = false) MultipartFile file, 
                         @RequestParam(value = "keepImage", required = false) Boolean keepImage, 
                         HttpSession session) {
        try {
            logger.info("Update request received for board_id: {}", boardVO.getBoard_id());

            // 이미지가 없거나 유지하려는 경우 처리
            if (file == null || file.isEmpty()) {
                if (keepImage == null || !keepImage) {
                    boardVO.setF_name(null); // 기존 이미지를 제거
                    logger.info("Existing image will be removed.");
                } else {
                    logger.info("Existing image will be kept.");
                }
            } else {
                // 새 이미지가 업로드된 경우 처리
                String uploadPath = session.getServletContext().getRealPath("/Uploads");
                logger.info("Upload path resolved: {}", uploadPath);

                // 파일 저장
                String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
                File dest = new File(uploadPath, fileName);
                file.transferTo(dest);
                boardVO.setF_name(fileName); // 새 파일명 설정
                logger.info("File uploaded successfully: {}", fileName);
            }

            // 공지사항 업데이트: 누락된 매개변수를 포함하여 호출
            String uploadPath = session.getServletContext().getRealPath("/Uploads");
            noticeService.updateNotice(boardVO, file, uploadPath);

            logger.info("Notice updated successfully, board_id: {}", boardVO.getBoard_id());
        } catch (Exception e) {
            logger.error("Failed to update notice: {}", e.getMessage(), e);
            return "redirect:/notice/edit?id=" + boardVO.getBoard_id() + "&error=update_failed";
        }
        return "redirect:/notice";
    }

    // 공지사항 삭제
    @GetMapping("/delete")
    public String delete(@RequestParam("id") int boardId, HttpSession session) {
        try {
            String deptName = (String) session.getAttribute("user.dept_name");
            if (!"슈퍼관리자".equals(deptName)) {
                return "redirect:/notice?error=unauthorized";
            }
            noticeService.deleteNotice(boardId);
            logger.info("Notice deleted successfully, board_id: {}", boardId);
        } catch (Exception e) {
            logger.error("Failed to delete notice: {}", e.getMessage(), e);
            return "redirect:/notice?error=delete_failed";
        }
        return "redirect:/notice";
    }
}