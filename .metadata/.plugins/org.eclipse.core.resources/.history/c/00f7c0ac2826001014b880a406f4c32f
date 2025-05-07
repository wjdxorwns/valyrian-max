package com.ict.project.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.vo.personnel.UserVO;

@Repository
public class NorDAO {
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public UserVO getLoginForm(int user_idx) {
		
		return sessionTemplate.selectOne("nor.login",user_idx);
	}

}
