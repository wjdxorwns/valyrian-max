package com.ict.project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map; // Map import 추가
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.project.repository.ManagerDAO;
import com.ict.project.vo.management.PermissionVO;
import com.ict.project.vo.management.RequestVO;
import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.PersonnelChangeVO;
import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.vo.personnel.pFile.EmpPictureVO;
import com.ict.project.vo.personnel.pFile.UsersignVO;

@Service
public class ManagerServiceImpl implements ManagerService{
    @Autowired
    private ManagerDAO managerDAO;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void registerEmployee(EmployeeVO employee, UsersVO user, UsersignVO usersign,
            PersonnelChangeVO change, RequestVO request, PermissionVO permission) throws Exception {
       

    	managerDAO.insertUser(user);
    	int userIdx = user.getUser_idx();
    	// 2. user_idx를 연관된 VO들에 설정
        employee.setUser_idx(userIdx);
        usersign.setUser_idx(userIdx);
       
        // emp_id 생성 (고용타입에 따라)
        String empId = generateUniqueEmpId(employee.getEmployment_type());
        employee.setEmp_id(empId);
        
        // emp_idx 생성 (랜덤값)
        String empIdx = generateUniqueEmpIdx();
        employee.setEmp_idx(empIdx);
        
        //  Employee 등록
        managerDAO.insertEmployee(employee);
        
        // Request 테이블에 emp_idx 등록
        managerDAO.insertRequest(employee);
        
        managerDAO.insertPermission(employee);
        
      
        
    }
  
    
    private String generateUniqueEmpIdx() {
        Random random = new Random();
        String empIdx;
        int loopCount = 0;

        do {
            int rand = 100000 + random.nextInt(900000); // 100000 ~ 999999
            empIdx = String.valueOf(rand);
            loopCount++;
            if (loopCount > 100) throw new RuntimeException("중복 emp_idx 생성 실패");
        } while (managerDAO.checkEmpIdxDuplicate(empIdx) > 0);

        return empIdx;
    }

    private String generateUniqueEmpId(String employmentType) {
        Random random = new Random();
        String empId;
        int loopCount = 0;
        String prefix;

        // 고용 타입에 따른 접두사 설정
        switch (employmentType) {
            case "정규직":
                prefix = "E";
                break;
            case "계약직":
                prefix = "T";
                break;
            case "아르바이트":
                prefix = "P";
                break;
            default:
                throw new IllegalArgumentException("유효하지 않은 고용 타입입니다: " + employmentType);
        }

        do {
            int rand = 1 + random.nextInt(999); // 001 ~ 999
            empId = prefix + String.format("%03d", rand); // E001, T001, P001 형식
            loopCount++;
            if (loopCount > 100) throw new RuntimeException("중복 emp_id 생성 실패");
        } while (managerDAO.countByEmpId(empId) > 0);

        return empId;
    }

    @Override
    public void registerEmpPicture(EmployeeVO employeeVO, EmpPictureVO picVO) throws Exception {
        if (employeeVO.getEmp_idx() == null || employeeVO.getEmp_idx().isEmpty()) {
            throw new IllegalArgumentException("직원번호(emp_idx)가 비어 있습니다.");
        }
        
        // employee 테이블에 해당 emp_idx가 존재하는지 확인
        if (managerDAO.checkEmpIdxDuplicate(employeeVO.getEmp_idx()) == 0) {
            throw new IllegalArgumentException("해당 직원번호(" + employeeVO.getEmp_idx() + ")가 employee 테이블에 존재하지 않습니다.");
        }
        
        picVO.setEmp_idx(employeeVO.getEmp_idx());
        managerDAO.insertEmpPicture(picVO);
    }

    
    @Override
    public int checkEmailDuplicate(String email) {
        return managerDAO.countByEmail(email);
    }

    @Override
    public int checkEmpIdDuplicate(String empId) {
        return managerDAO.countByEmpId(empId);
    }

    @Override
    public int checkPhoneDuplicate(String phoneNumber) {
        return managerDAO.countByPhoneNumber(phoneNumber);
    }

  
    @Override
    public boolean updateProfileImage(EmpPictureVO picture) {
        return managerDAO.updateProfileImage(picture) > 0;
    }
    

    
    

    @Override
    public void addPermissionIfNotExists(String emp_idx) {
        // 이미 권한이 있으면 추가하지 않음
        if (managerDAO.getPermissionByEmpIdx(emp_idx) == null) {
            EmployeeVO vo = new EmployeeVO();
            vo.setEmp_idx(emp_idx);
            managerDAO.insertPermission(vo);
        }
    }
    // 직원으로 강등되면 permission  삭제
    @Override
    public void removePermission(String emp_idx) {
        managerDAO.removePermission(emp_idx);
    }
    
    //	최성현
    @Override
    public List<Map<String, Object>> getAllEmployees(String searchType, String keyword) { // 파라미터 추가
        // DAO에서 Map 형태로 조회된 결과를 그대로 반환
        return managerDAO.getAllEmployees(searchType, keyword); // 파라미터 전달
    }
	
	// 작성자 : 한찬욱
    // 직원 상세 정보 조회
    @Override
    public Map<String, Object> getEmployeeDetail(String emp_idx) {
        return managerDAO.getEmployeeDetail(emp_idx);
    }
    
    // 변경된 직원 정보를 DB로 보내서 수정
    @Override
    @Transactional
    public void updateEmployee(Map<String, Object> paramMap) {
        // 1. employee 테이블 업데이트
        managerDAO.updateEmployee(paramMap);

        // 2. users 테이블 업데이트
        managerDAO.updateUsers(paramMap);

        // 3. emppicture 테이블 업데이트
        managerDAO.updateEmpPicture(paramMap);
    }	
	
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
    public Map<String, Integer> getPermissions(String userId) {
        Map<String, Object> rawPermissions = managerDAO.getPermissions(userId);
        Map<String, Integer> result = new HashMap<>();

        result.put("can_access_employee", convertToInt(rawPermissions.get("can_access_employee")));
        result.put("can_access_worktype", convertToInt(rawPermissions.get("can_access_worktype")));
        result.put("can_access_personnel", convertToInt(rawPermissions.get("can_access_personnel")));
        result.put("can_access_salary", convertToInt(rawPermissions.get("can_access_salary")));
        result.put("can_access_vacation", convertToInt(rawPermissions.get("can_access_vacation")));

        return result;
    }

    // 헬퍼 메서드: Object → Integer 변환 (null → 0)
    private int convertToInt(Object obj) {
        if (obj == null) return 0;
        try {
            return Integer.parseInt(obj.toString());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
    
    @Override
	public List<Map<String, Object>> getSearchResign() {
		// TODO Auto-generated method stub
		return managerDAO.getSearchResign();
	}

	@Override
	public List<Map<String, Object>> getSearchKeyWord(Map<String, Object> paramMap) {
		return managerDAO.getSearchKeyWord(paramMap);
	}

	@Override
	public void updateQuitter(Map<String, Object> paramMap) {
		managerDAO.updateQuitter(paramMap);
	}

	@Override
	public void updateUserRemove(Map<String, Object> paramMap) {
		managerDAO.updateUserRemove(paramMap);
		
	}



}