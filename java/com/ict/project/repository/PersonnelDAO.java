package com.ict.project.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.vo.personnel.VacationVO;

@Repository
public class PersonnelDAO {
	
	@Autowired
    private SqlSession sqlSession;

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
