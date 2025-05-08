package com.ict.project.repository;

import com.ict.project.vo.personnel.EmployeeVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmployeeDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String MAPPER_NAMESPACE = "com.ict.project.repository.EmployeeDAO.";

    public EmployeeVO findByUserIdx(int user_idx) {
        return sqlSession.selectOne(MAPPER_NAMESPACE + "findByUserIdx", user_idx);
    }

    public EmployeeVO findByEmpIdx(String emp_idx) {
        return sqlSession.selectOne(MAPPER_NAMESPACE + "findByEmpIdx", emp_idx);
    }
}