package com.ict.project.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.NorService;
import com.ict.project.vo.management.PermissionVO;
import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.UsersVO;

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
	
	@GetMapping("/passwordFind")
	public ModelAndView passwordFindPageGo() {
		return new ModelAndView("MainPage/passwordFind");
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

			// UsersVO 객체 전체를 세션에 저장 (기존 JSP 접근 방식과 일치)
			session.setAttribute("userVO", user);
			
			String emp_idx = employee.getEmp_idx();
			PermissionVO permission = norService.getEmployeeByPermission(emp_idx);

			// 기존 세션 속성도 유지 (필요시)
			session.setAttribute("loginchk", "ok");
			session.setAttribute("userVO", user);
			session.setAttribute("employeeVO", employee);
			session.setAttribute("emp_email", user.getEmp_email());
			session.setAttribute("emp_idx", employee.getEmp_idx());
			session.setAttribute("dept_name",employee.getDept_name());
			session.setAttribute("permissionvo", permission);
			
			
			
			// 관리자 및 슈퍼관리자 구분
			String deptName = employee.getDept_name().trim();
			session.setAttribute("user.deptName", deptName);
			if ("슈퍼관리자".equals(deptName) || "관리자".equals(deptName)) {
				session.setAttribute("admin", "ok");
			} else {
				session.setAttribute("admin", "no");
			}

			// 디버깅 로그
			logger.info("Login success for user: {}, dept_name: {}", emp_email, deptName);
			logger.info("UserVO in session: {}", user.getEmp_name()); // 로그 추가

			// user.admin 값 확인 로그 추가
			String adminStatus = (String) session.getAttribute("user.admin");
			logger.info("Admin status for user {}: {}", emp_email, adminStatus);

			
			mv.setViewName("redirect:/index?emp_idx=" + employee.getEmp_idx());
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
	@GetMapping("/myPage")
    public ModelAndView goMyPage(HttpSession session) {
    	try {
    		ModelAndView mv = new ModelAndView();
			
            // 세션에서 현재 로그인한 사용자 정보 가져오기
            UsersVO userVO = (UsersVO) session.getAttribute("userVO");
            if (userVO == null) {
                return new ModelAndView("redirect:/login");
            }
            
            // user_idx로 EmployeeVO 정보 조회
            EmployeeVO employee = norService.getEmployeeByUserIdx(userVO.getUser_idx());
            if (employee == null) {
                return new ModelAndView("error");
            }
            
            // emp_idx로 상세 정보 조회
            Map<String, Object> eVO = norService.getEmployeeInfor(employee.getEmp_idx());
            // 데이터 구조 확인을 위한 상세 로깅
            logger.info("UserVO: {}", userVO);
            logger.info("EmployeeVO: {}", employee);
            logger.info("MyPage Data Structure: {}", eVO != null ? eVO.keySet() : "eVO is null");
            logger.info("MyPage Data: {}", eVO);
            logger.info("f_name value: {}", eVO != null ? eVO.get("f_name") : "null");
         	
            if (eVO == null) {
                logger.error("Employee information is null for emp_idx: {}", employee.getEmp_idx());
            
                return new ModelAndView("error");
            }
			
			mv.addObject("eVO", eVO);
			mv.setViewName("MyPage/myPage");
			
			return mv;
			
		} catch (Exception e) {
			logger.error("MyPage Error: ", e);
			return new ModelAndView("error");
		}
    }
    

	
	
	
    // myPageUpdate에서 password, sign update
    // 경로를 /updateProfile로 변경하고, @RequestBody로 데이터를 받도록 수정
    // AJAX 요청에 대한 응답을 위해 @ResponseBody (또는 클래스 레벨에 @RestController)와 ResponseEntity 사용
    @PostMapping("/updateProfile") // 경로를 JSP의 AJAX 호출과 일치시킴
    @ResponseBody // 이 어노테이션 또는 클래스 레벨 @RestController가 있어야 JSON 응답 가능
    public ResponseEntity<String> updateProfile(@RequestBody Map<String, String> payload, HttpSession session) {
        // @RequestBody Map<String, String> payload : JSON {"password": "...", "signature": "..."} 형태의 데이터를 받음
        // 또는 아래처럼 ProfileUpdateDTO 같은 객체를 만들어 받을 수도 있습니다.
        // public ResponseEntity<String> updateProfile(@RequestBody ProfileUpdateDTO payload, HttpSession session) {
        //     String password = payload.getPassword();
        //     String signatureData = payload.getSignature();
        // }

        String password = payload.get("password");
        String signatureData = payload.get("signature");

        try {
            UsersVO userVO = (UsersVO) session.getAttribute("userVO");
            if (userVO == null) {
                // 로그인되지 않은 사용자의 요청 처리 (예: 401 Unauthorized)
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            // user_idx로 EmployeeVO 정보 조회 (선택적: 업데이트 권한 확인 등 로직이 없다면 user_idx만 사용 가능)
            // EmployeeVO employee = norService.getEmployeeByUserIdx(userVO.getUser_idx());
            // if (employee == null) {
            //     return ResponseEntity.status(HttpStatus.NOT_FOUND).body("직원 정보를 찾을 수 없습니다.");
            // }

            int userIdx = userVO.getUser_idx();

            // 비밀번호 업데이트 (비밀번호가 제공된 경우에만)
            if (password != null && !password.isEmpty()) {
                String encryptedPassword = passwordEncoder.encode(password);
                norService.updatePassword(userIdx, encryptedPassword);
            }
            
            // 서명 데이터 업데이트 (서명 데이터가 제공된 경우에만)
            // signatureData가 빈 문자열일 수도 있으므로, isEmpty() 체크보다는 null 체크 또는 정책에 따른 처리
            if (signatureData != null) { // signaturePad.isEmpty() ? '' 로 보내므로, 빈 문자열일 수 있음
                norService.updateSignature(userIdx, signatureData);
            }
			
            // 성공 응답 (HTTP 200 OK와 함께 메시지 전달)
            return ResponseEntity.ok("정보가 성공적으로 업데이트되었습니다.");

        } catch (Exception e) {
            logger.error("Profile update error for user_idx {}: ", (session.getAttribute("userVO") != null ? ((UsersVO)session.getAttribute("userVO")).getUser_idx() : "Unknown"), e);
            // 실패 응답 (HTTP 500 Internal Server Error와 함께 메시지 전달)
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("정보 업데이트 중 오류가 발생했습니다.");
        }
    }

}