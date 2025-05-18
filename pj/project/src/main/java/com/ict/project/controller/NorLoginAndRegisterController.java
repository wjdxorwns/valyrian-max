package com.ict.project.controller;

import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
			session.setAttribute("employeeVO", employee); 
			session.setAttribute("emp_email", user.getEmp_email());
			session.setAttribute("emp_idx", employee.getEmp_idx());
			
            // 부서 정보 설정
            String deptName = employee.getDept_name();  // EmployeeVO에서 dept_name 가져오기
            session.setAttribute("role", deptName);
            logger.info("부서 정보: {} ", deptName);  // 디버깅을 위한 코드				

            // 관리자 및 슈퍼관리자 구분
            if ("슈퍼관리자".equals(deptName) || "관리자".equals(deptName)) {
                session.setAttribute("admin", "ok"); // 아무튼 관리자 직종임
            } else {
                session.setAttribute("admin", "no"); // 일반 직원 
            }

            // 메인 페이지로 리다이렉트
            mv.setViewName("redirect:/index?emp_idx=" + employee.getEmp_idx());
            System.out.println(session);
        } catch (Exception e) {
            logger.error("Login error for user {}: ", emp_email, e);  // 로깅을 통한 오류 기록
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
	@GetMapping("/myPage")
    public ModelAndView goMyPage(HttpSession session) {
    	try {
    		ModelAndView mv = new ModelAndView();
			
            UsersVO userVO = (UsersVO) session.getAttribute("userVO");
            if (userVO == null) {
                return new ModelAndView("redirect:/login");
            }
            //	직원 정보 가져오기기
            EmployeeVO employee = norService.getEmployeeByUserIdx(userVO.getUser_idx());
            if (employee == null) {
                return new ModelAndView("error");
            }
            
            Map<String, Object> eVO = norService.getEmployeeInfor(employee.getEmp_idx());
          
            logger.info("UserVO: {}", userVO);
            logger.info("EmployeeVO: {}", employee);
            logger.info("MyPage Data Structure: {}", eVO != null ? eVO.keySet() : "eVO is null");
            logger.info("MyPage Data: {}", eVO);
            logger.info("f_name value: {}", eVO != null ? eVO.get("f_name") : "null");
         	
            if (eVO == null) {
                logger.error("Employee information is null for emp_idx: {}", employee.getEmp_idx());
            
                return new ModelAndView("error");
            }

			String signature = norService.getSignature(employee.getUser_idx());

			if (signature != null) {
				eVO.put("signature", signature);
			} 

			
			mv.addObject("eVO", eVO);
			mv.setViewName("MyPage/myPage");
			
			return mv;
			
		} catch (Exception e) {
			logger.error("MyPage Error: ", e);
			return new ModelAndView("error");
		}
    }
    
    @PostMapping("/updateProfile")
    @ResponseBody 
    public ResponseEntity<String> updateProfile(@RequestBody Map<String, String> payload, HttpSession session) {

        String password = payload.get("password");
        String signatureData = payload.get("signature");

        try {
            UsersVO userVO = (UsersVO) session.getAttribute("userVO");
            if (userVO == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            int userIdx = userVO.getUser_idx();


            if (password != null && !password.isEmpty()) {
                String encryptedPassword = passwordEncoder.encode(password);
                norService.updatePassword(userIdx, encryptedPassword);
            }
            

            if (signatureData != null) { 
                norService.updateSignature(userIdx, signatureData);
            }
			

            return ResponseEntity.ok("정보가 성공적으로 업데이트되었습니다.");

        } catch (Exception e) {
            logger.error("Profile update error for user_idx {}: ", (session.getAttribute("userVO") != null ? ((UsersVO)session.getAttribute("userVO")).getUser_idx() : "Unknown"), e);
           
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("정보 업데이트 중 오류가 발생했습니다.");
        }
    }

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}