package com.ict.project.service;

import com.ict.project.vo.UserVO;

public interface UserService {
    UserVO loginByEmail(String emp_email, String emp_password);
    int signup(UserVO user);
}
