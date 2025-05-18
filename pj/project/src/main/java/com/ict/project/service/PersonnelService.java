package com.ict.project.service;

import java.util.List;
import java.util.Map;

// 작성자: 정택준
public interface PersonnelService {
	List<Map<String, Object>> searchEmployeesByName(String searchKeyword);

	List<Map<String, Object>> searchEmployeesByDepartment(String searchKeyword);

	List<Map<String, Object>> searchEmployeesByPosition(String searchKeyword);
	
	// 작성자: 김용호
	List<Map<String, Object>> getAllVacations();

	List<Map<String, Object>> getAllApprovals();

	boolean updateVacationStatuses(List<Map<String, Object>> approval);
	
	// 작성자 : 한찬욱
	// 관리자의 근무지 이동 신청을 받은 테이블 조회
	public List<Map<String, Object>> getPersonChangeInfor();

	// 관리자의 근무지 이동 승인 페이지 승인/반려 처리
	boolean updatePersonChangeStatus(Map<String, Object> requestData);

	// 근무지 이동 신청을 승인 or 반려 했을 때 상태 초기화
	boolean resetPersonChangeStatus(Map<String, Object> requestData);
	
}
