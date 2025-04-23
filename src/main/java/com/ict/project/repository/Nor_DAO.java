package com.ict.project.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.vo.personnel.UserVO;

@Repository
public class Nor_DAO {

    @Autowired
    private SqlSessionTemplate sqlSession;

    public UserVO findByEmail(String empEmail) {
        return sqlSession.selectOne("nor.findByEmail", empEmail);
    }
}