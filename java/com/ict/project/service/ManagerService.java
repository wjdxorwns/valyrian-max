package com.ict.project.service;

import java.util.List;
import java.util.Map; // Map import 추가

import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.PersonnelChangeVO;
import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.vo.personnel.pFile.EmpPictureVO;
import com.ict.project.vo.personnel.pFile.UsersignVO;


public interface ManagerService {
    // 직원 등록
    void registerEmployee(EmployeeVO employee, UsersVO user, UsersignVO usersign, PersonnelChangeVO change);

    // 직원 사진 등록
    void registerEmpPicture(EmployeeVO employeeVO, EmpPictureVO picVO) throws Exception;

    // 직원 전체 조회 (Map 형태로 반환)
    List<Map<String, Object>> getAllEmployees(String searchType, String keyword); // 파라미터 추가

    // 중복확인
    public int checkEmailDuplicate(String email);
    public int checkEmpIdDuplicate(String empId);
    public int checkPhoneDuplicate(String phoneNumber);
    
    List<Map<String, String>> getAllPermissionList();
	void updatePermissions(String userId, Map<String, Integer> permissions);
}