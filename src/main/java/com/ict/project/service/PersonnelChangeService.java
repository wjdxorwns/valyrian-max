package com.ict.project.service;

import java.util.List;
import java.util.Map;

public interface PersonnelChangeService {
	

	// 작성자 : 한찬욱
	public List<Map<String, Object>> getApplyChangeInfor();

	// 관리자의 근무지 승인, 반려 신청을 받은 테이블 조회
	public List<Map<String, Object>> getPersonChangeInfor();

	// 관리자의 근무지 이동 승인 페이지 승인/반려 처리
	boolean updatePersonChangeStatus(Map<String, Object> requestData);

	// 근무지 이동 신청을 승인 or 반려 했을 때 상태 초기화
	boolean resetPersonChangeStatus(Map<String, Object> requestData);

}
