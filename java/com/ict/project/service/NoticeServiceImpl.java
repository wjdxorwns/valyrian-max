package com.ict.project.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ict.project.common.Paging;
import com.ict.project.repository.NoticeDAO;
import com.ict.project.vo.board.BoardVO;

@Service
public class NoticeServiceImpl implements NoticeService {

    private static final Logger logger = LoggerFactory.getLogger(NoticeServiceImpl.class);

    @Autowired
    private NoticeDAO noticeDAO;

    @Override
    public List<BoardVO> getNoticeList(Paging paging) {
        logger.info("Fetching notice list with paging: {}", paging);
        return noticeDAO.getNoticeList(paging);
    }

    @Override
    public int getTotalNoticeCount() {
        logger.info("Fetching total notice count");
        return noticeDAO.getTotalNoticeCount();
    }

    @Override
    public void registerNotice(BoardVO boardVO, MultipartFile file, String uploadPath) {
        logger.info("Registering notice: {}", boardVO);
        if (!file.isEmpty()) {
            try {
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
                File dest = new File(uploadPath, fileName);
                file.transferTo(dest);
                boardVO.setF_name(fileName);
                logger.info("File uploaded successfully: {}", fileName);
            } catch (Exception e) {
                logger.error("Error uploading file: {}", e.getMessage(), e);
            }
        }
        noticeDAO.insertNotice(boardVO);
    }

    @Override
    public BoardVO getNoticeDetail(int boardId) {
        logger.info("Fetching notice detail for boardId: {}", boardId);
        return noticeDAO.getNoticeDetail(boardId);
    }

    @Override
    public void increaseViewCount(int boardId) {
        logger.info("Increasing view count for boardId: {}", boardId);
        noticeDAO.increaseViewCount(boardId);
    }

    @Override
    public void updateNotice(BoardVO boardVO, MultipartFile file, String uploadPath) {
        try {
            if (file != null && !file.isEmpty()) {
                // 새 파일 업로드 처리
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
                File dest = new File(uploadPath, fileName);
                file.transferTo(dest);
                boardVO.setF_name(fileName); // 새 파일명 설정
                logger.info("File uploaded successfully: {}", fileName);
            } else {
                logger.info("No file uploaded. Existing file name will be used if present.");
            }

            // 공지사항 업데이트 실행
            noticeDAO.updateNotice(boardVO);
            logger.info("Database updated successfully for board_id: {}", boardVO.getBoard_id());
        } catch (Exception e) {
            logger.error("Error updating notice: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to update notice", e);
        }
    }

    @Override
    public void deleteNotice(int boardId) {
        logger.info("Deleting notice for boardId: {}", boardId);
        noticeDAO.deleteNotice(boardId);
    }
}