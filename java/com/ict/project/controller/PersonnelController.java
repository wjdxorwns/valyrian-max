package com.ict.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.PersonnelService;
import com.ict.project.vo.management.RequestLoggingVO;
import com.ict.project.vo.personnel.UsersVO;

// 작성자: 김재겸


@Controller
public class PersonnelController {
/*
  기능
  1. 출퇴근 도장 기능
  2. 오늘의 할일 달력(TO DO 달력) 기능
  3. 근무 방식 및 희망 근무지 기능
  4. 내 월급 리스트 확인 기능
  5. 휴가 신청 기능
  6. 공지사항 기능
 */
	
	@Autowired
    private PersonnelService personnelService;
	
	@GetMapping("/attendance")
	public ModelAndView AttendancePageGO() {
		return new ModelAndView("MainPage/attendance");
	}
	
	// 휴가 리스트
	@GetMapping("/vacationList")
	public ModelAndView VacationListPageGO(HttpSession session) {
		
		UsersVO user = (UsersVO) session.getAttribute("userVO");
		if (user == null) {
			System.out.println("No user in session, redirecting to login");
			return new ModelAndView("redirect:/login");
		}
		// 관리자 권한 확인
		String adminStatus = (String) session.getAttribute("admin");
		if (!"ok".equals(adminStatus)) {
			System.out.println("User is not admin, redirecting to error page");
			session.setAttribute("errorMessage", "관리자 권한이 필요합니다.");
			return new ModelAndView("redirect:/index");
		}
		
		ModelAndView mv = new ModelAndView("vacation/vacationList");
		List<Map<String, Object>> vacationList = personnelService.getAllVacations();
		Map<String, Map<String, Object>> vacationMap = new HashMap<>();
	    for (Map<String, Object> vacation : vacationList) {
	    	vacationMap.put(String.valueOf(vacation.get("vacation_id")), vacation);
	    }
	    
	    // ModelAndView에 Map 추가
	    mv.addObject("vacationMap", vacationMap);
	    return mv;
	}
	
	// 휴가 승인 및 대기
	@GetMapping("/vacationApproval")
	public ModelAndView vacationApprovalPageGO(HttpSession session) {
		
		UsersVO user = (UsersVO) session.getAttribute("userVO");
		if (user == null) {
			System.out.println("No user in session, redirecting to login");
			return new ModelAndView("redirect:/login");
		}
		// 관리자 권한 확인
		String adminStatus = (String) session.getAttribute("admin");
		if (!"ok".equals(adminStatus)) {
			System.out.println("User is not admin, redirecting to error page");
			session.setAttribute("errorMessage", "관리자 권한이 필요합니다.");
			return new ModelAndView("redirect:/index");
		}
		
		ModelAndView mv = new ModelAndView("vacation/vacationApproval");
		List<Map<String, Object>> vacationApproval = personnelService.getAllApprovals();
		Map<String, Map<String, Object>> vacationMap = new HashMap<>();
	    for (Map<String, Object> vacation : vacationApproval) {
	    	vacationMap.put(String.valueOf(vacation.get("vacation_id")), vacation);
	    }
	    
	    // ModelAndView에 Map 추가
	    mv.addObject("vacationMap", vacationMap);
	    return mv;
	}
	
	@PostMapping("/updateVacationStatus")
	public ResponseEntity<Map<String, Boolean>> updateVacationStatus(@RequestBody List<Map<String, Object>> approvals) {
		System.out.println("Received /updateVacationStatus request with approvals: " + approvals);
		boolean success = personnelService.updateVacationStatuses(approvals);
		
		if(success) {
			for(Map<String, Object> approval : approvals) {
				RequestLoggingVO logging = new RequestLoggingVO();
				logging.setRequest_idx(Integer.parseInt(String.valueOf(approval.get("request_idx")))); // Vacation 테이블의 request_idx
				logging.setLogging_vacation(String.valueOf(approval.get("status"))); // 승인 또는 반려
				logging.setReject(approval.get("comment") != null ? String.valueOf(approval.get("comment")) : ""); // 반려 사유
				
				personnelService.insertVacationLogging(logging);
			}
		}
		
		Map<String, Boolean> response = new HashMap<>();
		response.put("success", success);
		System.out.println("Returning response: " + response);
		return ResponseEntity.ok(response);
	}
	
	@GetMapping("/vacationInquiry")
	public ModelAndView vacationInquiryPageGO(HttpSession session) {
		
		UsersVO user = (UsersVO) session.getAttribute("userVO");
		if(user == null) {
			System.out.println("No user in session, redirecting to login");
			return new ModelAndView("redirect:/login");
		}
		
		ModelAndView mv = new ModelAndView("vacation/vacationInquiry");
		
		// 사용자별 휴가 기록 조회
		List<Map<String, Object>> vacationInquiry = personnelService.getUserInquiry(user.getUser_idx());
		Map<String, Map<String, Object>> vacationMap = new HashMap<>();
		for (Map<String, Object> vacation : vacationInquiry) {
			vacationMap.put(String.valueOf(vacation.get("vacation_id")), vacation);
		}
		// 사용자별 잔여 연차 정보 조회
        Map<String, Object> vacationDays = personnelService.getUserVacationDays(user.getUser_idx());
        
		mv.addObject("vacationMap", vacationMap);
		mv.addObject("vacationDays", vacationDays);
		mv.addObject("user", user);
		return mv;
	}
	
}
