package com.ict.project.repository;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ResetPasswordDAO {

    private static final String NAMESPACE = "ResetPassword";

    @Autowired
    private SqlSession sqlSession;

    // 비밀번호를 업데이트하는 메서드
    public int updatePassword(String empEmail, String empPassword) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("empEmail", empEmail);
            params.put("empPassword", empPassword);
            int updatedRows = sqlSession.update(NAMESPACE + ".updatePassword", params);
            if (updatedRows == 0) {
                System.err.println("No rows updated for email: " + empEmail);
            }
            return updatedRows;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}