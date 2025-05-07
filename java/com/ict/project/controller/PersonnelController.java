package com.ict.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.PersonnelService;

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
	public ModelAndView VacationListPageGO() {
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
	public ModelAndView vacationApprovalPageGO() {
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
		boolean success = personnelService.updateVacationStatuses(approvals);
		Map<String, Boolean> response = new HashMap<>();
		response.put("success", success);
		return ResponseEntity.ok(response);
	}
	
}
