package com.ict.project.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmailDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "email"; // 매퍼 네임스페이스를 "email"로 변경

    public int countActiveUserByEmail(String email) {
        return sqlSession.selectOne(NAMESPACE + ".countActiveUserByEmail", email);
    }
}