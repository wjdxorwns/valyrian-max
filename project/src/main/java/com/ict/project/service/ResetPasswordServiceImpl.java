package com.ict.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ict.project.repository.ResetPasswordDAO;

@Service
public class ResetPasswordServiceImpl implements ResetPasswordService {

    @Autowired
    private ResetPasswordDAO resetPasswordDAO;

    @Override
    public boolean updatePassword(String empEmail, String newPassword) {
        try {
            // DAO를 호출하여 비밀번호 변경
            return resetPasswordDAO.updatePassword(empEmail, newPassword) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}