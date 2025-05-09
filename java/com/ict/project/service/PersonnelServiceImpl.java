package com.ict.project.service;

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
				if(!processedIds.contains(vacationId)) {
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
	public List<Map<String, Object>> getUserInquiry(int user_idx) {// TODO Auto-generated method stub
		return personnelDAO.getUserInquiry(user_idx);
	}

	@Override
	public Map<String, Object> getUserVacationDays(int user_idx) {
		return personnelDAO.getUserVacationDays(user_idx);
	}

}
