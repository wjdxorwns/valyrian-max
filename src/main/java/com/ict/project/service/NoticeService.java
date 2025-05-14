package com.ict.project.service;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import com.ict.project.common.Paging;
import com.ict.project.vo.Board.BoardVO;

public interface NoticeService {
    List<BoardVO> getNoticeList(Paging paging);
    int getTotalNoticeCount();
    void registerNotice(BoardVO boardVO, MultipartFile file, String uploadPath);
    BoardVO getNoticeDetail(int boardId);
    void increaseViewCount(int boardId);
    void updateNotice(BoardVO boardVO, MultipartFile file, String uploadPath);
    void deleteNotice(int boardId);
    List<BoardVO> getRecentNotices(int limit);
    String getLastUpdatedTime();
    BoardVO getDefaultNotice(); // 기본 공지사항 반환 메서드
}