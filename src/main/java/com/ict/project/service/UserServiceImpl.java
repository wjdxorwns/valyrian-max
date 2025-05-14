package com.ict.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ict.project.repository.UserDAO;
import com.ict.project.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDAO userDAO;

    @Override
    public UserVO loginByEmail(String emp_email, String emp_password) {
        UserVO user = userDAO.findByEmail(emp_email);
        if (user != null && user.getEmp_password().equals(emp_password)) {
            return user;
        }
        return null;
    }

    @Override
    public int signup(UserVO user) {
        return userDAO.insertUser(user);
    }
}
