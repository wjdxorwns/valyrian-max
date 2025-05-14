package com.ict.project.service;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

// 작성자: 김재겸
public interface ManagerService {
	// 권한 부여 가능한 직원 리스트 호출
	List<Map<String, String>> getAllPermissionList();
	
	// 권한 업데이트
	void updatePermissions(String userId, Map<String, Integer> permissions);

	// 직원 정보 조회
	public Map<String, Object> getEmployeeInfo(String emp_idx);

	// 근무 방식 업데이트
	public boolean updateWorkType(String emp_idx, String workType);

	// 휴가 정보 조회
	public Map<String, Object> getVacationInfo(String emp_idx);

	// 휴가 승인 상태 업데이트
	public boolean updateVacationStatus(String emp_idx, String status);
}
