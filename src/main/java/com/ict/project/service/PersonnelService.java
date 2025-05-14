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

	// 작성자: 김재겸 (05-13)
	Map<String, Object> getEmployeeDetails(String empIdx);

	boolean updateWorkArrangement(String empIdx, String location, String attitudeType);

}
