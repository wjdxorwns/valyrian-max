package com.ict.project.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.vo.personnel.UsersVO;

@Repository
public class PersonnelDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	

}
