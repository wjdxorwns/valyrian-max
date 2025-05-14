package com.ict.project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.ManagerDAO;
import com.ict.project.vo.management.PermissionVO;
import com.ict.project.vo.personnel.UsersVO;

@Service
public class ManagerServiceImpl implements ManagerService {
	@Autowired
    private ManagerDAO managerDAO;
	
	@Override
	public List<Map<String, String>> getAllPermissionList() {
	    List<Map<String, Object>> permissionList = managerDAO.getAllPermissionList();
	    List<Map<String, String>> transformedList = new ArrayList<>();

	    for (Map<String, Object> permission : permissionList) {
	        Map<String, String> transformedPermission = new HashMap<>();
	        // emp_idx를 String으로 안전하게 변환
	        Object empIdx = permission.get("emp_idx");
	        transformedPermission.put("emp_idx", empIdx != null ? empIdx.toString() : "");
	        
	        // emp_name을 String으로 안전하게 변환
	        Object empName = permission.get("emp_name");
	        transformedPermission.put("emp_name", empName != null ? empName.toString() : "");
	        
	        // 권한 값을 안전하게 변환
	        transformedPermission.put("canAccessEmployee", convertPermissionValue(permission.get("can_access_employee")));
	        transformedPermission.put("canAccessWorktype", convertPermissionValue(permission.get("can_access_worktype")));
	        transformedPermission.put("canAccessPersonnel", convertPermissionValue(permission.get("can_access_personnel")));
	        transformedPermission.put("canAccessSalary", convertPermissionValue(permission.get("can_access_salary")));
	        transformedPermission.put("canAccessVacation", convertPermissionValue(permission.get("can_access_vacation")));
	        
	        transformedList.add(transformedPermission);
	    }
	    return transformedList;
	}
	
	// 권한 값을 안전하게 변환하는 헬퍼 메서드
	private String convertPermissionValue(Object value) {
	    if (value == null) return "미승인";
	    try {
	        int intValue = Integer.parseInt(value.toString());
	        return intValue == 1 ? "승인" : "미승인";
	    } catch (NumberFormatException e) {
	        return "미승인";
	    }
	}

    @Override
    public void updatePermissions(String userId, Map<String, Integer> permissions) {
        // 각 권한을 업데이트하는 로직
    	managerDAO.updatePermissions(userId, permissions);
    }

	@Override
	public Map<String, Object> getEmployeeInfo(String emp_idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean updateWorkType(String emp_idx, String workType) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Map<String, Object> getVacationInfo(String emp_idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean updateVacationStatus(String emp_idx, String status) {
		// TODO Auto-generated method stub
		return false;
	}
}