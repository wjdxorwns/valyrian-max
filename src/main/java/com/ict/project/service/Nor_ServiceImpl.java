package com.ict.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.Nor_DAO;
import com.ict.project.vo.personnel.UserVO;

@Service
public class Nor_ServiceImpl implements Nor_Service {

    @Autowired
    private Nor_DAO norDAO;

    @Override
    public UserVO login(String empEmail, String empPassword) {
        UserVO user = norDAO.findByEmail(empEmail);
        if (user != null && user.getEmp_password().equals(empPassword)) {
            return user; // Successful login
        }
        return null; // Failed login
    }
}