package com.ict.project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.common.Paging;
import com.ict.project.vo.Board.BoardVO;

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
        sqlSession.update(NS + ".deleteNotice", boardId);
    }

    public List<BoardVO> getRecentNotices(int limit) {
        return sqlSession.selectList(NS + ".getRecentNotices", limit);
    }

    public String getLastUpdatedTime() {
        return sqlSession.selectOne(NS + ".getLastUpdatedTime");
    }

    public BoardVO getDefaultNotice() {
        return sqlSession.selectOne(NS + ".getDefaultNotice");
    }
}