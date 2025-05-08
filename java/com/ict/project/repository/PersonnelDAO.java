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

}