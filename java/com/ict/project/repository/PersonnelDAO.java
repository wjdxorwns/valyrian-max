package com.ict.project.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.vo.management.RequestLoggingVO;
import com.ict.project.vo.personnel.VacationVO;

@Repository
public class PersonnelDAO {
	
	@Autowired
    private SqlSession sqlSession;
	//신청 된 모든 휴가
    public List<Map<String, Object>> getAllVacations() {
        return sqlSession.selectList("com.ict.project.repository.PersonnelDAO.getAllVacations");
    }
    
    //휴가 승인 대기 
    public List<Map<String, Object>> getAllApprovals() {
		return sqlSession.selectList("com.ict.project.repository.PersonnelDAO.getAllApprovals");
	}
    //휴가 승인
    public void updateVacationStatus(Map<String, Object> approval) {
    	sqlSession.update("com.ict.project.repository.PersonnelDAO.updateVacationStatus", approval);
    }
    //휴가 승인 데이터 로그 삽입
    public void insertVacationLogging(RequestLoggingVO logging) {
    	sqlSession.insert("com.ict.project.repository.PersonnelDAO.insertVacationLogging", logging);
    }
    
    //개인 휴가 현황
    public List<Map<String, Object>> getAllInquiry() {
		return sqlSession.selectList("com.ict.project.repository.PersonnelDAO.getAllInquiry");
	}
    public List<Map<String, Object>> getUserInquiry(int user_idx) {
    	return sqlSession.selectList("com.ict.project.repository.PersonnelDAO.getUserInquiry", user_idx);
    }
    public Map<String, Object> getUserVacationDays(int user_idx){
    	return sqlSession.selectOne("com.ict.project.repository.PersonnelDAO.getUserVacationDays", user_idx);
    }
    //휴가 차감
    public void deductVacationDays(Map<String, Object> approval) {
    	sqlSession.update("com.ict.project.repository.PersonnelDAO.deductVacationDays", approval);
    }

}
