package com.ict.project.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ict.project.common.Paging;
import com.ict.project.vo.board.BoardVO;

public interface NoticeService {
    List<BoardVO> getNoticeList(Paging paging);
    int getTotalNoticeCount();
    void registerNotice(BoardVO boardVO, MultipartFile file, String uploadPath);
    BoardVO getNoticeDetail(int boardId);
    void increaseViewCount(int boardId);
    void updateNotice(BoardVO boardVO, MultipartFile file, String uploadPath); // 올바른 메서드 시그니처
    void deleteNotice(int boardId);
}