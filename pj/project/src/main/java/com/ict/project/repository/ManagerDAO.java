package com.ict.project.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class ManagerDAO {
	 @Autowired
	 private SqlSessionTemplate sqlSessionTemplate;
	 	
	 private static final String NAMESPACE = "manager";
	 
		public List<Map<String, Object>> getAllPermissionList() {
			try {
				return sqlSessionTemplate.selectList(NAMESPACE + ".list");
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}
	 	
	 	public void updatePermissions(String userId, Map<String, Integer> permissions) {
	        try {
	            sqlSessionTemplate.update(NAMESPACE + ".updatePermissions", Map.of("userId", userId, "permissions", permissions));
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	
				
				
}