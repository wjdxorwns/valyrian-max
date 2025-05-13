package com.ict.project.repository;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.UsersVO;

@Repository
public class NorDAO {

    @Autowired
    private SqlSession sqlSession;
    
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    // 이메일로 사용자 조회
    public UsersVO getUserByEmail(String emp_email) {
        return sqlSession.selectOne("nor.getUserByEmail", emp_email);
    }

    // user_idx로 직원 조회
    public EmployeeVO getEmployeeByUserIdx(int userIdx) {
        return sqlSession.selectOne("nor.getEmployeeByUserIdx", userIdx);
    }
    
 // 작성자: 한찬욱 | 기여자: 김재겸
    //	user_idx로 MyPage(자신의 정보) 불러오기
    public Map<String, Object> getEmployeeInfor(String emp_idx) {
    	
    	return sqlSessionTemplate.selectOne("nor.getEmployeeInfor", emp_idx);
    }
    
	public int updatePassword(int userIdx, String encryptedPassword) {
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("userIdx", userIdx);
		paraMap.put("encryptedPassword", encryptedPassword);
		
		return sqlSessionTemplate.update("nor.updatePassword", paraMap);
	}

	
	public int updateSignature(Map<String, Object> params) {
		return sqlSessionTemplate.update("nor.updateSignature", params);
	}

}
