package com.ict.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.NorDAO;
import com.ict.project.vo.personnel.UserVO;

@Service
public class NorServiceImpl implements NorService{
	@Autowired
	private NorDAO norDAO;
	
	@Override
	public UserVO getLoginForm(int user_idx) {

		return norDAO.getLoginForm(user_idx);
	}

}
