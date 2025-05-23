package com.ict.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.PersonnelChangeDAO;

@Service
public class PersonnelChangeServiceImpl implements PersonnelChangeService {
	
	@Autowired
	private PersonnelChangeDAO personnelChangeDAO;
	
	// 한찬욱
	@Override
	// 관리자의 근무지 신청 목록 테이블 조회
	public List<Map<String, Object>> getApplyChangeInfor() {
		try {
			List<Map<String, Object>> result = personnelChangeDAO.getApplyChangeInfor();
			System.out.println("applyService Data: " + result); // 데이터 확인
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	
	// 관리자의 근무지 승인/반려된 목록 테이블 조회
	@Override
	public List<Map<String, Object>> getPersonChangeInfor() {
		try {
			List<Map<String, Object>> result = personnelChangeDAO.getPersonChangeInfor();
			System.out.println("personService Data: " + result); // 데이터 확인
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
			personnelChangeDAO.updatePersonChangeStatus(requestData);
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
			personnelChangeDAO.resetPersonChangeStatus(requestData);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
