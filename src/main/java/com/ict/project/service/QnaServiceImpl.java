package com.ict.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.common.QnaPaeging;
import com.ict.project.repository.QnaDAO;
import com.ict.project.vo.personnel.pFile.QuestionVO;

@Service
public class QnaServiceImpl implements QnaService {
	 
	@Autowired
	    private QnaDAO qnaDAO;

	@Override
	public List<Map<String, Object>> getAllQna() {
		// TODO Auto-generated method stub
		return qnaDAO.getAllQna();
	}

	@Override
	public List<Map<String, Object>> getQnaByEmpIdx(String empIdx) {
		return qnaDAO.getQnaByEmpIdx(empIdx);
	}

	@Override
	public Map<String, Object> getUserInfoByEmpIdx(String emp_idx) {
		// TODO Auto-generated method stub
		return qnaDAO.getUserInfoByEmpIdx(emp_idx);
	}

	@Override
	public void insertQna(Map<String, Object> param) {
		qnaDAO.insertQna(param);
	}

	@Override
	public QuestionVO getQnaDetail(String answer_id) {
		// TODO Auto-generated method stub
		return qnaDAO.getQnaDetail(answer_id);
	}

	@Override
	public void updateQna(QuestionVO qnavo) {
		qnaDAO.updateQna(qnavo);
	}

	@Override
	public void deleteQna(QuestionVO qnavo) {
		qnaDAO.deleteQna(qnavo);
	}

	@Override
	public int getTotalCount() {
		return qnaDAO.getTotalCount();
	}

	@Override
	public int getTotalCountByEmpIdx(String empIdx) {
		return qnaDAO.getTotalCountByEmpIdx(empIdx);
	}

	@Override
	public List<Map<String, Object>> getAllQnaPaging(QnaPaeging paging) {
		return qnaDAO.getAllQnaPaging(paging);
	}

	@Override
	public List<Map<String, Object>> getQnaByEmpIdxPaging(String empIdx, QnaPaeging paging) {
		return qnaDAO.getQnaByEmpIdxPaging(empIdx,paging);
	}







	
	

}