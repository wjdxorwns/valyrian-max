package com.ict.project.service;

import java.util.List;

import com.ict.project.vo.personnel.UserVO;

public interface ManagerService {
	List<UserVO> getAllEmp();
    List<UserVO> getEmpNameSearch(UserVO uVO);
    List<UserVO> getEmpIdSearch(UserVO uVO);
}
