package com.ict.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.PersonnelChangeService;

@Controller
public class PersonnelChangeController {
	
	@Autowired
	private PersonnelChangeService personnelChangeService;

	// 한찬욱
	// 관리자의 근무지 이동 신청을 받은 테이블 조회
	@GetMapping("/personnelChange")
	public ModelAndView getPersonnelChangeRequests(HttpSession session) {
	    try {
	        ModelAndView mv = new ModelAndView();
	        String emp_idx = (String) session.getAttribute("emp_idx");
	        if (emp_idx == null) {
	            return new ModelAndView("redirect:/login");
	        }
	        
	        List<Map<String, Object>> applyChangeList = personnelChangeService.getApplyChangeInfor();
	        if (applyChangeList == null) {
	            System.out.println("applyChangeList is null");
	            applyChangeList = new ArrayList<>();
	        }
	        System.out.println("Apply Change List size: " + applyChangeList.size());
	        System.out.println("Apply Change List content: " + applyChangeList);
	        
	        List<Map<String, Object>> personChangeList = personnelChangeService.getPersonChangeInfor();
	        if (personChangeList == null) {
	            System.out.println("personChangeList is null");
	            personChangeList = new ArrayList<>();
	        }
	        System.out.println("Person Change List size: " + personChangeList.size());
	        System.out.println("Person Change List content: " + personChangeList);
	
	        // 데이터 유효성 검증
	        for (Map<String, Object> applyChange : applyChangeList) {
	            if (!applyChange.containsKey("request_idx") || !applyChange.containsKey("emp_id")) {
	                System.out.println("Invalid applyChange data: " + applyChange);
	            }
	        }
	
	        for (Map<String, Object> personChange : personChangeList) {
	            if (!personChange.containsKey("request_idx") || !personChange.containsKey("emp_id")) {
	                System.out.println("Invalid personChange data: " + personChange);
	            }
	        }
	
	        mv.addObject("applyChangeList", applyChangeList);
	        mv.addObject("personChangeList", personChangeList);
	        mv.setViewName("PersonnelManagement/PersonnelChange/personnelChange");
	
	        return mv;
	
	    } catch (Exception e) {
	        System.out.println("Error in getPersonnelChangeRequests: " + e.getMessage());
	        e.printStackTrace();
	        return new ModelAndView("error");
	    }
	}

	// 근무지 이동 승인/반려 처리
	@PostMapping("/updatePersonChangeStatus")
	public ResponseEntity<Map<String, Boolean>> updatePersonChangeStatus(@RequestBody Map<String, Object> requestData) {
		try {
			// 상태 업데이트와 히스토리 기록을 동시에 처리
			boolean updateSuccess = personnelChangeService.updatePersonChangeStatus(requestData);
			// boolean insertSuccess =
			// personnelService.insertPersonChangeHistory(requestData);
			boolean resetSuccess = personnelChangeService.resetPersonChangeStatus(requestData);

			Map<String, Boolean> response = new HashMap<>();
			response.put("success", (updateSuccess && /* insertSuccess && */ resetSuccess));
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}


}
