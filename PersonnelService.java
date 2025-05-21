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
	void updateRequestVacationStatus(Map<String, Object> params);

	void insertVacationLogging(RequestLoggingVO logging);
	boolean resetVacationRequest(int requestIdx);

	List<Map<String, Object>> getAllInquiry(); // This method is declared but not used in the controller, consider
												// removing if not needed.

	List<Map<String, Object>> getUserInquiry(int user_idx);

	// �옍�뿬 �뿰李� 議고쉶 硫붿꽌�뱶 異붽�
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

	// �옉�꽦�옄 : �븳李ъ슧
	// 愿�由ъ옄�쓽 洹쇰Т吏� �씠�룞 �떊泥��쓣 諛쏆� �뀒�씠釉� 議고쉶
	public List<Map<String, Object>> getPersonChangeInfor();

	// 愿�由ъ옄�쓽 洹쇰Т吏� �씠�룞 �듅�씤 �럹�씠吏� �듅�씤/諛섎젮 泥섎━
	boolean updatePersonChangeStatus(Map<String, Object> requestData);

	// 洹쇰Т吏� �씠�룞 �떊泥��쓣 �듅�씤 or 諛섎젮 �뻽�쓣 �븣 �긽�깭 珥덇린�솕
	boolean resetPersonChangeStatus(Map<String, Object> requestData);

	// �옉�꽦�옄: 源��옱寃� (05-13)
	Map<String, Object> getEmployeeDetails(String empIdx);

	boolean updateWorkArrangement(String empIdx, String location, String attitudeType);

}