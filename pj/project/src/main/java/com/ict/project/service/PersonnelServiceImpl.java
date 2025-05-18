package com.ict.project.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.PersonnelDAO;
// 작성자: 정택준
@Service
public class PersonnelServiceImpl implements PersonnelService{
	@Autowired
	private PersonnelDAO personnelDAO;
	
	@Override
	public List<Map<String, Object>> searchEmployeesByName(String searchKeyword) {
		
		return personnelDAO.searchEmployeesByName(searchKeyword);
	}

	@Override
	public List<Map<String, Object>> searchEmployeesByDepartment(String searchKeyword) {
		// TODO Auto-generated method stub
		return personnelDAO.searchEmployeesByDepartment(searchKeyword);
	}

	@Override
	public List<Map<String, Object>> searchEmployeesByPosition(String searchKeyword) {
		// TODO Auto-generated method stub
		return personnelDAO.searchEmployeesByPosition(searchKeyword);
	}
	
	// 작성자: 김용호
	@Override
    public List<Map<String, Object>> getAllVacations() {
        return personnelDAO.getAllVacations();
    }

	@Override
	public List<Map<String, Object>> getAllApprovals() {
		return personnelDAO.getAllApprovals();
	}

	@Override
	public boolean updateVacationStatuses(List<Map<String, Object>> approval) {
		try {
			Set<String> processedIds = new HashSet<>();
			for(Map<String, Object> approval1 : approval) {
				String vacationId = String.valueOf(approval1.get("vacation_id"));
				if(!processedIds.contains(vacationId)) {
					personnelDAO.updateVacationStatus(approval1);
					processedIds.add(vacationId);
				}
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	//	작성자 : 한찬욱
	// 관리자의 근무지 이동 신청을 받은 테이블 조회
	@Override
	public List<Map<String, Object>> getPersonChangeInfor() {
		try {
			List<Map<String, Object>> result = personnelDAO.getPersonChangeInfor();
			System.out.println("Service Data: " + result);  // 데이터 확인
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// 관리자의 근무지 이동 승인 페이지 승인/반려 처리
	@Override
	public boolean updatePersonChangeStatus(Map<String, Object> requestData) {
		try {
			personnelDAO.updatePersonChangeStatus(requestData);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 근무지 이동 신청을 승인 or 반려 했을 때 상태 초기화
	@Override
	public boolean resetPersonChangeStatus(Map<String, Object> requestData) {
		try {
			personnelDAO.resetPersonChangeStatus(requestData);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	
	
	
}
