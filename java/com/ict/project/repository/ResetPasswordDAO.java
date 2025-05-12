package com.ict.project.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ResetPasswordDAO {

    private static final String NAMESPACE = "com.ict.project.repository.ResetPasswordDAO";

    @Autowired
    private SqlSession sqlSession;

    // 비밀번호를 업데이트하는 메서드
    public int updatePassword(String empEmail, String empPassword) {
        try {
            // 매퍼로 전달할 파라미터 설정
            var params = new java.util.HashMap<String, Object>();
            params.put("empEmail", empEmail);
            params.put("empPassword", empPassword);

            // MyBatis 매퍼 호출
            return sqlSession.update(NAMESPACE + ".updatePassword", params);
        } catch (Exception e) {
            e.printStackTrace();
            return 0; // 오류 발생 시 0 반환
        }
    }
}