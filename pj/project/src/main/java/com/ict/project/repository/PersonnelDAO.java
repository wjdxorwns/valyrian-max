package com.ict.project.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
// 작성자: 정택준
@Repository
public class PersonnelDAO {
	
	@Autowired
    private SqlSession sqlSession;

	public List<Map<String, Object>> searchEmployeesByName(String searchKeyword) {
        return sqlSession.selectList("personnel.findByEmpNameContaining", searchKeyword);
    }

    public List<Map<String, Object>> searchEmployeesByDepartment(String searchKeyword) {
        return sqlSession.selectList("personnel.findByDeptNameContaining", searchKeyword);
    }

    public List<Map<String, Object>> searchEmployeesByPosition(String searchKeyword) {
        return sqlSession.selectList("personnel.findByPositionContaining", searchKeyword);
    }
    
    // 작성자: 김용호
    public List<Map<String, Object>> getAllVacations() {
        return sqlSession.selectList("com.ict.project.repository.PersonnelDAO.getAllVacations");
    }
    
    public List<Map<String, Object>> getAllApprovals() {
		return sqlSession.selectList("com.ict.project.repository.PersonnelDAO.getAllApprovals");
	}
    
    public void updateVacationStatus(Map<String, Object> approval) {
    	sqlSession.update("com.ict.project.repository.PersonnelDAO.updateVacationStatus", approval);
    }

	//	작성자 : 한찬욱
	// 관리자의 근무지 이동 신청을 받은 테이블 조회
	public List<Map<String, Object>> getPersonChangeInfor() {
		List<Map<String, Object>> result = sqlSession.selectList("personnel.getPersonChangeInfor");
		System.out.println("DAO Data: " + result);  // 데이터 확인
		return result;
	}

    // 관리자의 근무지 이동 승인 페이지 승인/반려 처리
    public int updatePersonChangeStatus(Map<String, Object> requestData) {
        // 먼저 레코드 존재 여부 확인
        int exists = sqlSession.selectOne("personnel.checkRequestLoggingExists", requestData);
        requestData.put("recordExists", exists);
        int result = sqlSession.update("personnel.updateLoggingpersonnelChangeStatus", requestData);
        
        // 새로운 레코드 삽입인 경우 personnelchange도 업데이트
        if (exists == 0) {
            sqlSession.update("personnel.updatePersonnelChangeLocation", requestData);
        }
        return result;
    }

    // 근무지 이동 신청을 승인 or 반려 했을 때 상태 초기화
    public boolean resetPersonChangeStatus(Map<String, Object> requestData) {
        try {
            sqlSession.update("personnel.resetPersonChangeStatus", requestData);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }




}