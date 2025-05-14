// PersonnelServiceImpl.java
package com.ict.project.service;

import java.sql.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.PersonnelDAO;
import com.ict.project.vo.management.RequestLoggingVO;

@Service
public class PersonnelServiceImpl implements PersonnelService{

    @Autowired
    private PersonnelDAO personnelDAO;

    @Override
    public List<Map<String, Object>> getAllVacations() {
        return personnelDAO.getAllVacations();
    }

    @Override
    public List<Map<String, Object>> getAllApprovals() {
        return personnelDAO.getAllApprovals();
    }

    @Override
    public boolean updateVacationStatuses(List<Map<String, Object>> approvals) {
        try {
            Set<String> processedIds = new HashSet<>();
            for(Map<String, Object> approval : approvals) {
                String vacationId = String.valueOf(approval.get("vacation_id"));
                String status = String.valueOf(approval.get("status"));
                String comment = approval.get("comment") != null ? String.valueOf(approval.get("comment")) : "";
                System.out.println("Processing vacation_id: " + vacationId + ", status: " + status + ", comment: " + comment);
                if(!processedIds.contains(vacationId)) { // Process each unique vacationId once
                    Map<String, Object> approvalCopy = new HashMap<>(approval);
                    approvalCopy.put("comment", comment);
                    personnelDAO.updateVacationStatus(approvalCopy);
                    if ("승인".equals(status)) {
                        personnelDAO.deductVacationDays(approvalCopy);
                    }
                    processedIds.add(vacationId);
                }
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void insertVacationLogging(RequestLoggingVO logging) {
        personnelDAO.insertVacationLogging(logging);
    }

    @Override
    public List<Map<String, Object>> getAllInquiry() {
        return personnelDAO.getAllInquiry();
    }

    @Override
    public List<Map<String, Object>> getUserInquiry(int user_idx) {
        return personnelDAO.getUserInquiry(user_idx);
    }

    @Override
    public Map<String, Object> getUserVacationDays(int user_idx) {
        return personnelDAO.getUserVacationDays(user_idx);
    }

    @Override
    public List<Map<String, Object>> searchEmployeesByName(String searchKeyword) {
        return personnelDAO.searchEmployeesByName(searchKeyword);
    }

    @Override
    public List<Map<String, Object>> searchEmployeesByDepartment(String searchKeyword) {
        return personnelDAO.searchEmployeesByDepartment(searchKeyword);
    }

    @Override
    public List<Map<String, Object>> searchEmployeesByPosition(String searchKeyword) {
        return personnelDAO.searchEmployeesByPosition(searchKeyword);
    }

    @Override
    public Map<String, Object> serchpaydetail(String emp_idx) {
        return personnelDAO.serchpaydetail(emp_idx);
    }

    @Override
    public List<Map<String, Object>> serchpaylist(Map<String, Object> params) {
        return personnelDAO.serchpaylist(params);
    }

    @Override
    public int insertPay(Map<String, Object> params) {
        return personnelDAO.insertPay(params);
    }

    @Override
    public int updatePay(Map<String, Object> params) {
        return personnelDAO.updatePay(params);
    }

    @Override
    public boolean isPayRecordExists(String emp_idx, Date payment_date) {
        return personnelDAO.isPayRecordExists(emp_idx, payment_date);
    }

    @Override
    public void updateEmployeePay(Map<String, Object> params) {
        personnelDAO.updateEmployeePay(params);
    }

	@Override
	public List<Map<String, Object>> serchpaylistAll(String emp_idx) {
		return personnelDAO.serchpaylistAll(emp_idx);
	}

	@Override
	public void updateLatestSalary(Map<String, Object> updateParams) {
	    personnelDAO.updateLatestSalary(updateParams);
	}

	@Override
	public Map<String, Object> getLatestSalary(String emp_idx) {
		return personnelDAO.getLatestSalary(emp_idx);
	}

	@Override
	public void updatePayById(Map<String, Object> params) {
	    personnelDAO.updatePayById(params);
	}

	// 한찬욱
	// 관리자의 근무지 이동 신청을 받은 테이블 조회
	@Override
	public List<Map<String, Object>> getPersonChangeInfor(Map<String, Object> params) {
		try {
			return personnelDAO.getPersonChangeInfor(params);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// 관리자의 근무지 이동 승인 페이지 승인/반려 처리
	@Override
	public boolean updatePersonChangeStatus(List<Map<String, Object>> requestData) {
		int result = personnelDAO.updatePersonChangeStatus(requestData);
		return result > 0;  // 1이면 true, 0이면 false 반환
	}


	// 작성자: 김재겸 (05-13)
		@Override
		public Map<String, Object> getEmployeeDetails(String empIdx) {
			return personnelDAO.getEmployeeDetails(empIdx);
		}

		@Override
		public boolean updateWorkArrangement(String empIdx, String location, String attitudeType) {
	    	try {
	        	personnelDAO.updateWorkArrangement(empIdx, location, attitudeType);
	      	  	return true;
	    	} catch (Exception e) {
	       	 	e.printStackTrace();
	       	 	return false;
	   	 	}
	}
	


}