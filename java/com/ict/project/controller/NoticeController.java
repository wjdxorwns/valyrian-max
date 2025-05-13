package com.ict.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.File;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.common.Paging;
import com.ict.project.service.NoticeService;
import com.ict.project.vo.Board.BoardVO;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

    @Autowired
    private NoticeService noticeService;

    // 공지사항 목록 페이지 이동
    @GetMapping
    public ModelAndView noticePageGo(@RequestParam(defaultValue = "1") int nowPage, HttpSession session) {
        String empIdx = (String) session.getAttribute("emp_idx");
        if (empIdx == null) {
            logger.warn("세션에 직원 ID 없음, 로그인 페이지로 리다이렉트");
            return new ModelAndView("redirect:/login");
        }
        String deptName = (String) session.getAttribute("user.dept_name");
        logger.info("공지사항 목록 접근, 부서명: {}, 직원 ID: {}", deptName, empIdx);
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

    // 공지사항 등록 페이지 이동
    @GetMapping("/write")
    public ModelAndView noticeRegistrationPageGo(HttpSession session) {
        String empIdx = (String) session.getAttribute("emp_idx");
        if (empIdx == null) {
            logger.warn("세션에 직원 ID 없음, 로그인 페이지로 리다이렉트");
            return new ModelAndView("redirect:/login");
        }
        String deptName = (String) session.getAttribute("user.dept_name");
        logger.info("공지사항 등록 페이지 접근, 부서명: {}, 직원 ID: {}", deptName, empIdx);
        return new ModelAndView("MainPage/noticeRegistration");
    }

    // 공지사항 등록 처리
    @PostMapping("/register")
    public String register(BoardVO boardVO, @RequestParam("image") MultipartFile file, HttpSession session) {
        String empIdx = (String) session.getAttribute("emp_idx");
        if (empIdx == null) {
            logger.warn("직원 ID 없음, 로그인 페이지로 리다이렉트");
            return "redirect:/login";
        }
        String deptName = (String) session.getAttribute("dept_name");
        logger.info("공지사항 등록 요청, 부서명: {}, 직원 ID: {}", deptName, empIdx);
        
        boardVO.setEmp_idx(empIdx);
        try {
            noticeService.registerNotice(boardVO, file, session.getServletContext().getRealPath("/Uploads"));
            logger.info("공지사항 등록 성공, 게시글 ID: {}", boardVO.getBoard_id());
            List<BoardVO> recentNotices = noticeService.getRecentNotices(3);
            String lastUpdatedTime = noticeService.getLastUpdatedTime();
            session.setAttribute("latestNotices", recentNotices);
            session.setAttribute("lastUpdateDate", lastUpdatedTime);
            logger.info("세션에 최신 공지사항 갱신 완료");
        } catch (Exception e) {
            logger.error("공지사항 등록 실패: {}", e.getMessage(), e);
            return "redirect:/notice/write?error=registration_failed";
        }
        return "redirect:/notice";
    }

    // 공지사항 상세 페이지 이동
    @GetMapping("/detail")
    public ModelAndView detail(@RequestParam("id") int boardId, HttpSession session) {
        String empIdx = (String) session.getAttribute("emp_idx");
        if (empIdx == null) {
            logger.warn("세션에 직원 ID 없음, 로그인 페이지로 리다이렉트");
            return new ModelAndView("redirect:/login");
        }
        String deptName = (String) session.getAttribute("dept_name");
        logger.info("공지사항 상세 페이지 접근, 게시글 ID: {}, 부서명: {}", boardId, deptName);
        ModelAndView mv = new ModelAndView("MainPage/noticeDetail");
        BoardVO notice = noticeService.getNoticeDetail(boardId);
        if (notice != null) {
            noticeService.increaseViewCount(boardId);
            mv.addObject("board", notice);
        } else {
            logger.warn("공지사항 없음, 게시글 ID: {}", boardId);
            mv.setViewName("redirect:/notice");
        }
        return mv;
    }

    // 공지사항 수정 페이지 이동
    @GetMapping("/edit")
    public ModelAndView editPageGo(@RequestParam("id") int boardId, HttpSession session) {
        String empIdx = (String) session.getAttribute("emp_idx");
        if (empIdx == null) {
            logger.warn("세션에 직원 ID 없음, 로그인 페이지로 리다이렉트");
            return new ModelAndView("redirect:/login");
        }
        String deptName = (String) session.getAttribute("dept_name");
        logger.info("공지사항 수정 페이지 접근, 게시글 ID: {}, 부서명: {}", boardId, deptName);
        
        ModelAndView mv = new ModelAndView("MainPage/noticeEdit");
        BoardVO notice = noticeService.getNoticeDetail(boardId);
        if (notice != null) {
            mv.addObject("board", notice);
        } else {
            logger.warn("공지사항 없음, 게시글 ID: {}", boardId);
            mv.setViewName("redirect:/notice");
        }
        return mv;
    }

    // 공지사항 수정 처리
    @PostMapping("/update")
    public String update(BoardVO boardVO, 
                         @RequestParam(value = "image", required = false) MultipartFile file, 
                         @RequestParam(value = "keepImage", required = false) Boolean keepImage, 
                         HttpSession session) {
        String empIdx = (String) session.getAttribute("emp_idx");
        if (empIdx == null) {
            logger.warn("세션에 직원 ID 없음, 로그인 페이지로 리다이렉트");
            return "redirect:/login";
        }
        try {
            logger.info("공지사항 수정 요청, 게시글 ID: {}, 직원 ID: {}", boardVO.getBoard_id(), empIdx);

            if (file == null || file.isEmpty()) {
                if (keepImage == null || !keepImage) {
                    boardVO.setF_name(null);
                    logger.info("기존 이미지 제거");
                } else {
                    logger.info("기존 이미지 유지");
                }
            } else {
                String uploadPath = session.getServletContext().getRealPath("/Uploads");
                logger.info("업로드 경로: {}", uploadPath);

                String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
                File dest = new File(uploadPath, fileName);
                file.transferTo(dest);
                boardVO.setF_name(fileName);
                logger.info("파일 업로드 성공: {}", fileName);
            }

            String uploadPath = session.getServletContext().getRealPath("/Uploads");
            noticeService.updateNotice(boardVO, file, uploadPath);
            logger.info("공지사항 수정 성공, 게시글 ID: {}", boardVO.getBoard_id());

            List<BoardVO> recentNotices = noticeService.getRecentNotices(3);
            String lastUpdatedTime = noticeService.getLastUpdatedTime();
            session.setAttribute("latestNotices", recentNotices);
            session.setAttribute("lastUpdateDate", lastUpdatedTime);
            logger.info("세션에 최신 공지사항 갱신 완료");
        } catch (Exception e) {
            logger.error("공지사항 수정 실패: {}", e.getMessage(), e);
            return "redirect:/notice/edit?id=" + boardVO.getBoard_id() + "&error=update_failed";
        }
        return "redirect:/notice";
    }

    // 공지사항 삭제 처리
    @GetMapping("/delete")
    public String delete(@RequestParam("id") int boardId, HttpSession session) {
        String empIdx = (String) session.getAttribute("emp_idx");
        if (empIdx == null) {
            logger.warn("세션에 직원 ID 없음, 로그인 페이지로 리다이렉트");
            return "redirect:/login";
        }
        try {
            String deptName = (String) session.getAttribute("dept_name");
            if (!"슈퍼관리자".equals(deptName)) {
                logger.warn("슈퍼관리자 권한 없음, 직원 ID: {}", empIdx);
                return "redirect:/notice?error=unauthorized";
            }
            noticeService.deleteNotice(boardId);
            logger.info("공지사항 삭제 성공, 게시글 ID: {}", boardId);

            List<BoardVO> recentNotices = noticeService.getRecentNotices(3);
            String lastUpdatedTime = noticeService.getLastUpdatedTime();
            session.setAttribute("latestNotices", recentNotices);
            session.setAttribute("lastUpdateDate", lastUpdatedTime);
            logger.info("세션에 최신 공지사항 갱신 완료");
        } catch (Exception e) {
            logger.error("공지사항 삭제 실패: {}", e.getMessage(), e);
            return "redirect:/notice?error=delete_failed";
        }
        return "redirect:/notice";
    }

    // 최신 공지사항 Ajax 요청 처리
    @GetMapping("/latest-ajax")
    @ResponseBody
    public Map<String, Object> getLatestNoticesAjax(HttpSession session) {
        String empIdx = (String) session.getAttribute("emp_idx");
        if (empIdx == null) {
            logger.warn("세션에 직원 ID 없음, Ajax 요청 거부");
            return new HashMap<>();
        }

        logger.info("최신 공지사항 Ajax 요청, 직원 ID: {}", empIdx);
        List<BoardVO> recentNotices = noticeService.getRecentNotices(3);

        // 공지사항이 없으면 기본 공지사항 가져오기
        if (recentNotices == null || recentNotices.isEmpty()) {
            logger.warn("최신 공지사항 없음, 기본 공지사항 가져오기");
            BoardVO defaultNotice = noticeService.getDefaultNotice();
            if (defaultNotice != null) {
                recentNotices.add(defaultNotice);
            }
        }

        // 응답 데이터 구성
        Map<String, Object> response = new HashMap<>();
        response.put("notices", recentNotices);
        response.put("lastUpdateDate", recentNotices.isEmpty() ? "" : recentNotices.get(0).getUpdated_at());

        return response;
    }
}