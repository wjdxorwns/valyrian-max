package com.ict.project.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.vo.personnel.UserVO;

@Repository
public class ManagerDAO {
	 @Autowired
	    private SqlSessionTemplate sqlSessionTemplate;


	    public List<UserVO> getAllEmp() {
	        try {
	            return sqlSessionTemplate.selectList("man.getAllEmp");
	        } catch (Exception e) {
	            e.printStackTrace();
	            return null;
	        }
	    }


	    public List<UserVO> getEmpNameSearch(UserVO uVO) {
	        try {
	            return sqlSessionTemplate.selectList("man.nameList", uVO);
	        } catch (Exception e) {
	            e.printStackTrace();
	            return null;
	        }
	    }


	    public List<UserVO> getEmpIdSearch(UserVO uVO) {
	        try {
	            return sqlSessionTemplate.selectList("man.idList", uVO);
	        } catch (Exception e) {
	            e.printStackTrace();
	            return null;
	        }
	    }
}
