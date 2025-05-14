package com.ict.project.service;

import com.ict.project.vo.personnel.EmployeeVO;

public interface EmployeeService {
    EmployeeVO findByUserIdx(int user_idx);
    EmployeeVO findByEmpIdx(String emp_idx);
}