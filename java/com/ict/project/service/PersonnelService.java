// PersonnelService.java
package com.ict.project.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.ict.project.vo.management.RequestLoggingVO;

public interface PersonnelService {

    List<Map<String, Object>> getAllVacations();
    List<Map<String, Object>> getAllApprovals();
    boolean updateVacationStatuses(List<Map<String, Object>> approval);
    void insertVacationLogging(RequestLoggingVO logging);


    List<Map<String, Object>> getAllInquiry(); // This method is declared but not used in the controller, consider removing if not needed.

    List<Map<String, Object>> getUserInquiry(int user_idx);
    // 잔여 연차 조회 메서드 추가
    Map<String, Object> getUserVacationDays(int user_idx);

    List<Map<String, Object>> searchEmployeesByName(String searchKeyword);

    List<Map<String, Object>> searchEmployeesByDepartment(String searchKeyword);

    List<Map<String, Object>> searchEmployeesByPosition(String searchKeyword);

    Map<String, Object> serchpaydetail(String emp_idx);

    List<Map<String, Object>> serchpaylist(Map<String, Object> params);

    int insertPay(Map<String, Object> params);

    int updatePay(Map<String, Object> params);

    boolean isPayRecordExists(String emp_idx, Date payment_date);

    void updateEmployeePay(Map<String, Object> params);

	List<Map<String, Object>> serchpaylistAll(String emp_idx);

	void updateLatestSalary(Map<String, Object> updateParams);

	Map<String, Object> getLatestSalary(String emp_idx);

	void updatePayById(Map<String, Object> updateParams);

	// 작성자 : 한찬욱
	// 관리자의 근무지 이동 신청을 받은 테이블 조회
	public List<Map<String, Object>> getPersonChangeInfor(Map<String, Object> params);

	// 관리자의 근무지 이동 승인 페이지 승인/반려 처리
	boolean updatePersonChangeStatus(List<Map<String, Object>> requestData);
	

	// 작성자: 김재겸 (05-13)
	Map<String, Object> getEmployeeDetails(String empIdx);

	boolean updateWorkArrangement(String empIdx, String location, String attitudeType);
	
	
	
}