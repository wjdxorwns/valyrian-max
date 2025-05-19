package com.ict.project.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.ict.project.vo.UserVO;

@Repository
public class UserDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    private static final String MAPPER_NAMESPACE = "web";

    public UserVO findByEmail(String emp_email) {
        return sqlSessionTemplate.selectOne(MAPPER_NAMESPACE + ".findByEmail", emp_email);
    }

    public int insertUser(UserVO user) {
        return sqlSessionTemplate.insert(MAPPER_NAMESPACE + ".insertUser", user);
    }
}
