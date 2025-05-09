package com.ict.project.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.NorService;
import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.UsersVO;

// 작성자: 최성현

@Controller
public class NorLoginAndRegisterController {

	private static final Logger logger = LoggerFactory.getLogger(NorLoginAndRegisterController.class);

	@Autowired
	private NorService norService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	// 로그인 페이지로 이동
	@GetMapping("/login")
	public ModelAndView loginPageGo() {
		return new ModelAndView("MainPage/login");
	}

	// 로그인 처리 (일반 사용자, 관리자, 슈퍼관리자 포함)

	@PostMapping("/login")
	public ModelAndView login(@RequestParam String emp_email, @RequestParam String emp_password, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		try {
			// 사용자가 입력한 이메일로 사용자 정보 조회
			UsersVO user = norService.getUserByEmail(emp_email);

			if (user == null) {
				mv.addObject("loginchk", "fail"); // 사용자 미존재
				mv.setViewName("MainPage/login");
				return mv;
			}
			// 입력한 비밀번호가 저장된 비밀번호와 일치하는지 확인
			if (!passwordEncoder.matches(emp_password, user.getEmp_password())) {
				mv.addObject("loginchk", "fail"); // 비밀번호 불일치
				mv.setViewName("MainPage/login");
				return mv;
			}
			// UsersVO에서 user_idx를 가져와서 EmployeeVO 정보 조회
			int user_idx = user.getUser_idx();
			EmployeeVO employee = norService.getEmployeeByUserIdx(user_idx);
			if (employee == null) {
				mv.addObject("loginchk", "fail"); // 직원 정보 미존재
				mv.setViewName("MainPage/login");
				return mv;
			}
			// 로그인 성공 처리 - 세션에 로그인 정보 저장
			session.setAttribute("loginchk", "ok");

			// 중요: UsersVO 객체 전체를 세션에 저장 (JSP에서 사용하는 방식과 일치시킴)
			session.setAttribute("userVO", user);

			// 기존 세션 속성도 유지 (필요시)
			session.setAttribute("user.emp_email", user.getEmp_email());
			session.setAttribute("user.emp_idx", employee.getEmp_idx());
			session.setAttribute("user.dept_name", employee.getDept_name().trim());

			// 관리자 및 슈퍼관리자 구분
			String deptName = employee.getDept_name().trim();
			if ("슈퍼관리자".equals(deptName) || "관리자".equals(deptName)) {
				session.setAttribute("user.admin", "ok");
			} else {
				session.setAttribute("user.admin", "no");
			}

			// 디버깅 로그
			logger.info("Login success for user: {}, dept_name: {}", emp_email, deptName);
			logger.info("UserVO in session: {}", user.getEmp_name()); // 로그 추가

			// user.admin 값 확인 로그 추가
			String adminStatus = (String) session.getAttribute("user.admin");
			logger.info("Admin status for user {}: {}", emp_email, adminStatus);

			// 공지사항 페이지로 리다이렉트
			mv.setViewName("redirect:/index");
		} catch (Exception e) {
			logger.error("Login error for user {}: ", emp_email, e);
			mv.addObject("error", "로그인 중 오류가 발생했습니다. 다시 시도해주세요.");
			mv.setViewName("MainPage/login");
		}
		return mv;
	}

	// 로그아웃 처리
	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate(); // 세션 무효화
		return new ModelAndView("redirect:/login"); // 로그인 페이지로 리디렉션
	}

	// index 페이지로 이동
	@GetMapping("/index")
	public ModelAndView goToIndex() {
		return new ModelAndView("MainPage/index");
	}

	
//	작성자: 한찬욱
//	index에서 MyPage로 이동
    @PostMapping("/myPage")
    public ModelAndView goMyPage(@RequestParam String emp_idx) {
    	try {
    		
    		ModelAndView mv = new ModelAndView();
			Map<String, Object> eVO = norService.getEmployeeInfor(emp_idx);	
			
			mv.addObject("eVO", eVO);
			mv.setViewName("MyPage/myPage");
			
			return mv;
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("error");
		}
    }
    
	//	myPage에서 index 페이지로 이동 
	@GetMapping("/index") 
	public ModelAndView returnToIndex() { 
		
		return new ModelAndView("MainPage/index"); 
	}
	
	// myPage에서 myPageUpdate 창으로 이동
	@PostMapping("/myPageUp")
	public ModelAndView myPageUpdate(@RequestParam("emp_idx") String emp_idx) {
		ModelAndView mv = new ModelAndView();
		Map<String, Object> eVO = norService.getEmployeeInfor(emp_idx);
		
		mv.addObject("eVO", eVO);
		mv.setViewName("MyPage/myPageUpdate");
		return mv;
	}

	
	/*
	// myPageUpdate에서 myPage로 이동
	
	@GetMapping("/returnMyPage") public ModelAndView returnMyPage() {
	
	return new ModelAndView("/MyPage/myPage"); }
	
	*/
    // myPageUpdate에서 DB에 비밀번호 및 사인 저장
}