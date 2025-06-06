package com.ict.project.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.common.QnaPaeging;
import com.ict.project.vo.personnel.pFile.QuestionVO;

@Repository
public class QnaDAO {
	
	 @Autowired
	    private SqlSession sqlSession;

	public List<Map<String, Object>> getAllQna() {
		return sqlSession.selectList("qna.allqna");
	}

	public List<Map<String, Object>> getQnaByEmpIdx(String empIdx) {
		return sqlSession.selectList("qna.empidxlist", empIdx);
	}

	public Map<String, Object> getUserInfoByEmpIdx(String emp_idx) {
		return sqlSession.selectOne("qna.writefind",emp_idx);
	}

	public void insertQna(Map<String, Object> param) {
		sqlSession.insert("qna.insert",param);
	}

	public QuestionVO getQnaDetail(String answer_id) {
		return sqlSession.selectOne("qna.qnaDetail",answer_id);
	}

	public void updateQna(QuestionVO qnavo) {
		sqlSession.update("qna.update",qnavo);
	}

	public void deleteQna(QuestionVO qnavo) {

		sqlSession.update("qna.delete",qnavo);
	}

	public int getTotalCount() {
		  return sqlSession.selectOne("qna.totalCount");
	}

	public int getTotalCountByEmpIdx(String empIdx) {
		// TODO Auto-generated method stub
		 return sqlSession.selectOne("qna.totalCountByEmpIdx", empIdx);
	}

	public List<Map<String, Object>> getAllQnaPaging(QnaPaeging paging) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("qna.selectAllPaging", paging);
	}

	public List<Map<String, Object>> getQnaByEmpIdxPaging(String empIdx, QnaPaeging paging) {
		  Map<String, Object> param = new HashMap<>();
	        param.put("empIdx", empIdx);
	        param.put("offset", paging.getOffset());
	        param.put("limit", paging.getNumPerPage());
	        return sqlSession.selectList("qna.selectByEmpIdxPaging", param);
	}
	
	
	
	





}