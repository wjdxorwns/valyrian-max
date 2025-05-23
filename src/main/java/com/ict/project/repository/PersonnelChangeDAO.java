package com.ict.project.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PersonnelChangeDAO {

	@Autowired
	private SqlSession sqlSession;
	
	// 한찬욱
	// 관리자의 근무지 신청 목록 테이블 조회
	public List<Map<String, Object>> getApplyChangeInfor() {
			List<Map<String, Object>> result = sqlSession.selectList("personnel.getApplyChangeInfor") ;
			
			return result;
	}
		
	// 관리자의 근무지 승인/반려된 목록 테이블 조회
	public List<Map<String, Object>> getPersonChangeInfor() {
		List<Map<String, Object>> result = sqlSession.selectList("personnel.getPersonChangeInfor");

		return result;
	}

	// 관리자의 근무지 이동 승인 페이지 승인/반려 처리
	public int updatePersonChangeStatus(Map<String, Object> requestData) {
		// 먼저 레코드 존재 여부 확인
		int exists = sqlSession.selectOne("personnel.checkRequestLoggingExists", requestData);
		requestData.put("recordExists", exists);
		int result = sqlSession.update("personnel.updateLoggingpersonnelChangeStatus", requestData);

		// 새로운 레코드 삽입인 경우 personnelchange도 업데이트
		if (exists == 0) {
			sqlSession.update("personnel.updatePersonnelChangeLocation", requestData);
		}
		return result;
	}

	// 근무지 이동 신청을 승인 or 반려 했을 때 상태 초기화
	public boolean resetPersonChangeStatus(Map<String, Object> requestData) {
		try {
			sqlSession.update("personnel.resetPersonChangeStatus", requestData);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
}
