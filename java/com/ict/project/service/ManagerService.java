package com.ict.project.service;

import java.util.List;
import java.util.Map; // Map import 추가

import com.ict.project.vo.management.PermissionVO;
import com.ict.project.vo.management.RequestVO;
import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.PersonnelChangeVO;
import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.vo.personnel.pFile.EmpPictureVO;
import com.ict.project.vo.personnel.pFile.UsersignVO;


public interface ManagerService {
	 // 직원 등록
    void registerEmployee(EmployeeVO employee, UsersVO user, UsersignVO usersign, 
             RequestVO request, PermissionVO permission) throws Exception;
    
    // 직원 사진 등록
    void registerEmpPicture(EmployeeVO employeeVO, EmpPictureVO picVO) throws Exception;
    
    // 직원 전체 조회 (Map 형태로 반환)
    List<Map<String, Object>> getAllEmployees(String searchType, String keyword); // 파라미터 추가
    
    // 중복확인
    int checkEmailDuplicate(String email);
    int checkEmpIdDuplicate(String empId);
    int checkPhoneDuplicate(String phoneNumber);

   
    
    // 직원 정보 수정
    boolean updateEmployee(EmployeeVO employee);
    
    boolean updateUser(Map<String, Object> param);
    
    
    
    //인사 발령 정보 수정
   // boolean updatePersonnelChange(PersonnelChangeVO personnelChange);
    
    // 프로필 이미지 수정
    boolean updateProfileImage(EmpPictureVO picture);
    
    
     /* 직원 상세 정보 조회
      * @param emp_idx 직원 고유번호
      * @return 직원 관련 모든 정보를 담은 Map*/
    Map<String, Object> getEmployeeById(String emp_idx);
    
    // 관리자급 permission 추가
    void addPermissionIfNotExists(String emp_idx);
    
    // permission 테이블에서 emp_idx 제거
    void removePermission(String emp_idx);
    
    // 퇴사시 직원 리스트에서 블라 처리
    List<Map<String, Object>> getResignEmployees();
    
    
    
    
    List<Map<String, String>> getAllPermissionList();
	void updatePermissions(String userId, Map<String, Integer> permissions);

	
	List<Map<String, Object>> getSearchResign();
	List<Map<String, Object>> getSearchKeyWord(Map<String, Object> paramMap);
	void updateQuitter(Map<String, Object> paramMap);
	void updateUserRemove(Map<String, Object> paramMap);

}