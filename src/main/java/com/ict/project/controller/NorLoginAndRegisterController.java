package com.ict.project.controller;

// 작성자: 최성현 | 기여자: 김재겸

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.NorService;

@Controller
public class NorLoginAndRegisterController {
	
	/*
	  	기능
	  	1. 로그인 기능
	  	2. 회원가입 기능
	  	3. 비밀번호 찾기
	  
	 */
	
	@Autowired
	private NorService norService;
	
	@RequestMapping("/MainPage")
	public ModelAndView loginPageGo() {
		return new ModelAndView("MainPage/login");
	}
	
	// 비밀번호 찾기 페이지 이동
	@GetMapping("/password_found")
    public ModelAndView getPasswordForm() {
    	return new ModelAndView("MainPage/password_found");
    }
    
	@PostMapping("/login")
    public ModelAndView getSignupForm() {
    	return new ModelAndView("MainPage/login");
    }
}
