package com.ict.project.service;

import com.ict.project.repository.EmployeeDAO;
import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeDAO employeeDAO;

    @Override
    public EmployeeVO findByUserIdx(int user_idx) {
        return employeeDAO.findByUserIdx(user_idx);
    }
}