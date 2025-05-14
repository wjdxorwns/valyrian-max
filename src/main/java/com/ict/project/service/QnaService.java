package com.ict.project.service;


import java.util.List;
import java.util.Map;

import com.ict.project.common.QnaPaeging;
import com.ict.project.vo.personnel.pFile.QuestionVO;


public interface QnaService  {

	List<Map<String, Object>> getAllQna();

	List<Map<String, Object>> getQnaByEmpIdx(String empIdx);

	Map<String, Object> getUserInfoByEmpIdx(String emp_idx);

	void insertQna(Map<String, Object> param);

	QuestionVO getQnaDetail(String answer_id);

	void updateQna(QuestionVO qnavo);

	void deleteQna(QuestionVO qnavo);

	int getTotalCount();

	int getTotalCountByEmpIdx(String empIdx);

	List<Map<String, Object>> getAllQnaPaging(QnaPaeging paging);

	List<Map<String, Object>> getQnaByEmpIdxPaging(String empIdx, QnaPaeging paging);

	






	

}
