package com.ict.project.repository;

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
	   
	// 전자결제 관련 메서드
	public void insertApproval(Map<String, Object> approvalData) {
		sqlSessionTemplate.insert(NAMESPACE + ".insertApproval", approvalData);
	}
	
	public List<Map<String, Object>> getApprovalList(String empIdx) {
		return sqlSessionTemplate.selectList(NAMESPACE + ".getApprovalList", empIdx);
	}
	
	public Map<String, Object> getApprovalDetail(String approvalId) {
		return sqlSessionTemplate.selectOne(NAMESPACE + ".getApprovalDetail", approvalId);
	}
	
	public void updateApprovalStatus(String approvalId, String status) {
		Map<String, String> params = Map.of("approvalId", approvalId, "status", status);
		sqlSessionTemplate.update(NAMESPACE + ".updateApprovalStatus", params);
	}
}