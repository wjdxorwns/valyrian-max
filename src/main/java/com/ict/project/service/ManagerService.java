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
            PersonnelChangeVO change, RequestVO request, PermissionVO permission) throws Exception;
    
    // 직원 사진 등록
    void registerEmpPicture(EmployeeVO employeeVO, EmpPictureVO picVO) throws Exception;

    // 중복확인
    int checkEmailDuplicate(String email);
    int checkEmpIdDuplicate(String empId);
    int checkPhoneDuplicate(String phoneNumber);
    
    // 직원 리스트 전체 조회 (Map 형태로 반환) 최성현
    List<Map<String, Object>> getAllEmployees(String searchType, String keyword); // 파라미터 추가
    
    // 작성자 : 한찬욱
    // 직원 상세 정보 조회
    Map<String, Object> getEmployeeDetail(String emp_idx);

	// 변경된 직원 정보를 DB로 보내서 수정
    void updateEmployee(Map<String, Object> paramMap);    
    
       
    // 직원 정보, 프로필 이미지 수정
 
    boolean updateProfileImage(EmpPictureVO picture);
  
    
    // 직원 상세조회에서 관리자 슈퍼관리자로 설정 시 permission 추가
    void addPermissionIfNotExists(String emp_idx);
    // 강등시 permission 테이블에서 emp_idx 제거
    void removePermission(String emp_idx);
    
    
    
    
    List<Map<String, String>> getAllPermissionList();

    // 키 값, 맵 구조 => 데이터를 하나씩 저장
    void updatePermissions(String userId, Map<String, Integer> permissions);
    Map<String, Integer> getPermissions(String userId);
	
	List<Map<String, Object>> getSearchResign();
	List<Map<String, Object>> getSearchKeyWord(Map<String, Object> paramMap);
		void updateQuitter(Map<String, Object> paramMap);
		void updateUserRemove(Map<String, Object> paramMap);

}