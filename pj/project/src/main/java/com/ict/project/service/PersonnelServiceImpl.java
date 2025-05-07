package com.ict.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.PersonnelDAO;
import com.ict.project.vo.personnel.UsersVO;

@Service
public class PersonnelServiceImpl implements PersonnelService{
	
	@Autowired
	private PersonnelDAO personnelDAO;
	


}
