package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.ManagerDAO;
import com.ict.project.vo.personnel.UserVO;

@Service
public class ManagerServiceImpl implements ManagerService{
	@Autowired
    private ManagerDAO managerDAO;

    @Override
    public List<UserVO> getAllEmp() {
        return managerDAO.getAllEmp();
    }

    @Override
    public List<UserVO> getEmpNameSearch(UserVO uVO) {
        return managerDAO.getEmpNameSearch(uVO);
    }

    @Override
    public List<UserVO> getEmpIdSearch(UserVO uVO) {
        return managerDAO.getEmpIdSearch(uVO);
    }
}
