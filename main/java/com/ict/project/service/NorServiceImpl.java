package com.ict.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.NorDAO;
import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.UsersVO;

@Service
public class NorServiceImpl implements NorService {

    @Autowired
    private NorDAO norDAO;

    @Override
    public UsersVO getUserByEmail(String emp_email) {
        return norDAO.getUserByEmail(emp_email);
    }

    @Override
    public EmployeeVO getEmployeeByUserIdx(int userIdx) {
        return norDAO.getEmployeeByUserIdx(userIdx);
    }
}
