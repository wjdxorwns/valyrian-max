package com.ict.project.repository;

import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.common.Paging;
import com.ict.project.vo.board.BoardVO;

/**
 * 공지사항 데이터 액세스 객체(DAO) 클래스
 */
@Repository
public class NoticeDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NS = "com.ict.project.repository.NoticeDAO";

    public List<BoardVO> getNoticeList(Paging paging) {
        return sqlSession.selectList(NS + ".getNoticeList", paging);
    }

    public int getTotalNoticeCount() {
        return sqlSession.selectOne(NS + ".getTotalNoticeCount");
    }

    public void insertNotice(BoardVO boardVO) {
        sqlSession.insert(NS + ".insertNotice", boardVO);
    }

    public BoardVO getNoticeDetail(int boardId) {
        return sqlSession.selectOne(NS + ".getNoticeDetail", boardId);
    }

    public void increaseViewCount(int boardId) {
        sqlSession.update(NS + ".increaseViewCount", boardId);
    }

    public void updateNotice(BoardVO boardVO) {
        sqlSession.update(NS + ".updateNotice", boardVO);
    }

    public void deleteNotice(int boardId) {
        sqlSession.update(NS + ".deleteNotice", boardId); // 삭제 쿼리 호출
    }
}