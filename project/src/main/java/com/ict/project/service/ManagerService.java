package com.ict.project.service;

import java.util.List;

import com.ict.project.vo.personnel.UsersVO;

public interface ManagerService {
	List<UsersVO> getAllEmp();
    List<UsersVO> getEmpNameSearch(UsersVO uVO);
    List<UsersVO> getEmpIdSearch(UsersVO uVO);
}
