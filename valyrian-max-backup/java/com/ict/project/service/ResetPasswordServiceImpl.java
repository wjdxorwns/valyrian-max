package com.ict.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.project.repository.ResetPasswordDAO;

@Service
public class ResetPasswordServiceImpl implements ResetPasswordService {

    @Autowired
    private ResetPasswordDAO resetPasswordDAO;

    @Override
    @Transactional
    public boolean updatePassword(String empEmail, String newPassword) {
        try {
            // DAO를 호출하여 비밀번호 변경
            int updatedRows = resetPasswordDAO.updatePassword(empEmail, newPassword);
            return updatedRows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            // Wrap checked exception in a RuntimeException to trigger rollback
            throw new RuntimeException("Failed to update password for email: " + empEmail, e);
        }
    }
}