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

    // The original updatePay(Map<String, Object> params) method is likely for generic updates,
    // but updatePayById is specifically for salary records. Retain both for now if their usage differs.
    int updatePay(Map<String, Object> params); // This one might be used for generic employee updates or specific salary updates

    boolean isPayRecordExists(String emp_idx, Date payment_date);

    void updateEmployeePay(Map<String, Object> params); // This seems to update the employee's 'pay' field directly in the Employee table

    List<Map<String, Object>> serchpaylistAll(String emp_idx);

    // This method was declared in the original PersonnelService but not implemented or called.
    // It was likely meant for updating a "latest salary" field in the employee table.
    // The new `updatePayById` now handles updating salary records by `salary_id`.
    // If `updateLatestSalary` still has a distinct purpose (e.g., updating a dedicated "current_salary" field in the employee table),
    // it should be retained and implemented. Otherwise, consider removing or merging.
    // For now, commenting it out as it's unused and its purpose might be covered by updateEmployeePay
    // void updateLatestSalary(Map<String, Object> updateParams);

    Map<String, Object> getLatestSalary(String emp_idx); // Retrieves the latest salary record for an employee

    void updatePayById(Map<String, Object> updateParams); // Specifically updates a salary record by its ID
}