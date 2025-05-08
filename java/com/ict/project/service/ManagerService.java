package com.ict.project.service;

import java.util.List;

import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.PersonnelChangeVO;
import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.vo.personnel.pFile.EmpPictureVO;
import com.ict.project.vo.personnel.pFile.UsersignVO;



public interface ManagerService {
	// 직원 등록
	 void registerEmployee(EmployeeVO employee, UsersVO user, UsersignVO usersign,
             EmpPictureVO picture, PersonnelChangeVO change);

    // 직원 전체 조회
    List<EmployeeVO> getAllEmployees();
}