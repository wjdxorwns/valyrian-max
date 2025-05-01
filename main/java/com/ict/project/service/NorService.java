package com.ict.project.service;

import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.vo.personnel.EmployeeVO;

public interface NorService {
    // 이메일로 사용자 조회
    UsersVO getUserByEmail(String emp_email);

    // user_idx로 직원 조회
    EmployeeVO getEmployeeByUserIdx(int userIdx);
}
