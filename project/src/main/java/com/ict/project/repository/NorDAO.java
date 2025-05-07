package com.ict.project.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.vo.personnel.EmployeeVO;

@Repository
public class NorDAO {

    @Autowired
    private SqlSession sqlSession;

    // 이메일로 사용자 조회
    public UsersVO getUserByEmail(String emp_email) {
        return sqlSession.selectOne("nor.getUserByEmail", emp_email);
    }

    // user_idx로 직원 조회
    public EmployeeVO getEmployeeByUserIdx(int userIdx) {
        return sqlSession.selectOne("nor.getEmployeeByUserIdx", userIdx);
    }
}
