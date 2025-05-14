package com.ict.project.service;

import java.util.List;
import java.util.Map;

//작성자: 김재겸
public interface ManagerService {
	
	List<Map<String, String>> getAllPermissionList();
	void updatePermissions(String userId, Map<String, Integer> permissions);




}