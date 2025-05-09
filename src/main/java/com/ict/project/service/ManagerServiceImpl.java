package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.ManagerDAO;
import com.ict.project.vo.personnel.UsersVO;

@Service
public class ManagerServiceImpl implements ManagerService{
	@Autowired
    private ManagerDAO managerDAO;

    @Override
    public List<UsersVO> getAllEmp() {
        return managerDAO.getAllEmp();
    }

    @Override
    public List<UsersVO> getEmpNameSearch(UsersVO uVO) {
        return managerDAO.getEmpNameSearch(uVO);
    }

    @Override
    public List<UsersVO> getEmpIdSearch(UsersVO uVO) {
        return managerDAO.getEmpIdSearch(uVO);
    }
}
