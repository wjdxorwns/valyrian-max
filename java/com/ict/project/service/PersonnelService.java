package com.ict.project.service;

import java.util.List;
import java.util.Map;

import com.ict.project.vo.management.RequestLoggingVO;

public interface PersonnelService {
	
	List<Map<String, Object>> getAllVacations();
	List<Map<String, Object>> getAllApprovals();
	boolean updateVacationStatuses(List<Map<String, Object>> approval);
	public void insertVacationLogging(RequestLoggingVO logging);
	
	
	List<Map<String, Object>> getAllInquiry();
	
	List<Map<String, Object>> getUserInquiry(int user_idx);
	// 잔여 연차 조회 메서드 추가
    Map<String, Object> getUserVacationDays(int user_idx);

}
