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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ict.project.service.PersonnelService;
import com.ict.project.vo.personnel.EmployeeVO;
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
	
	// 작성자: 정택준
	@GetMapping("/PayrollManagement")
	public ModelAndView getPayrollManagement(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/Payment/pay");
		return mv;
	}
	
	@PostMapping("/searchEmployees")
    public ModelAndView searchEmployees(
            @RequestParam("searchType") String searchType,
            @RequestParam("searchKeyword") String searchKeyword,
            HttpSession session) {
        ModelAndView mv = new ModelAndView("Payment/adminPay");
      

        Map<String, String> searchOptions = new HashMap<>();
        searchOptions.put("name", "이름");
        searchOptions.put("department", "부서");
        searchOptions.put("position", "직책");
        mv.addObject("searchOptions", searchOptions);
        mv.addObject("selectedType", searchType);
        mv.addObject("searchKeyword", searchKeyword);

        if (searchType == null || searchType.trim().isEmpty()) {
            mv.addObject("error", "검색 기준을 선택하세요.");
            return mv;
        }
        if (searchKeyword == null || searchKeyword.trim().isEmpty()) {
            mv.addObject("error", "검색어를 입력하세요.");
            return mv;
        }

        List<Map<String, Object>> employeeList = new ArrayList<>();
        if ("name".equals(searchType)) {
            employeeList = personnelService.searchEmployeesByName(searchKeyword);
        } else if ("department".equals(searchType)) {
            employeeList = personnelService.searchEmployeesByDepartment(searchKeyword);
        } else if ("position".equals(searchType)) {
            employeeList = personnelService.searchEmployeesByPosition(searchKeyword);
        } else {
            mv.addObject("error", "잘못된 검색 기준입니다.");
            return mv;
        }
      
        mv.addObject("employeeList", employeeList);
        System.out.println("Employee List: " + employeeList);
        return mv;
    }
	
	@GetMapping("/pay_update")
	public ModelAndView getPayUpdate(@RequestParam("emp_idx") String emp_idx) {
		ModelAndView mv = new ModelAndView();
		
		
		
		return null;
	}
	
	@GetMapping("/payrollList")
	public ModelAndView getPayrollList(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("Payment/pay");
		return mv;
	}
	
	
	@GetMapping("/payrollGrade")
	public ModelAndView getPayrollGrade(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("Payment/adminPay");
		return mv;
	}
	
	// 작성자: 김용호
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
	
		// 한찬욱
		// 관리자의 근무지 이동 신청을 받은 테이블 조회
		@GetMapping("/personnelChange")
		public ModelAndView getPersonnelChangeRequests(HttpSession session) {
			try{
				ModelAndView mv = new ModelAndView();
				//	세션에서 직접 emp_idx 가져오기 
				String emp_idx = (String) session.getAttribute("emp_idx");
				
				if(emp_idx == null){
					return new ModelAndView("redirect:/login");
				}
				
				Map<String, Object> params = new HashMap<>();
				params.put("emp_idx", emp_idx);

				List<Map<String, Object>> personChangeList = personnelService.getPersonChangeInfor(params);
				
				if (personChangeList == null) {
					return new ModelAndView("error");
				}

				mv.addObject("personChangeList", personChangeList);
				mv.setViewName("PersonnelManagement/PersonnelChange/personnelChange");
				return mv;

			}catch(Exception e){
				e.printStackTrace();
				return new ModelAndView("error");
			}
		}

		// 근무지 이동 승인/반려 처리
		@PostMapping("/updatePersonChangeStatus")
		public ResponseEntity<Map<String, Boolean>> updatePersonChangeStatus(@RequestBody Map<String, Object> requestData) {
			try{
				// 상태 업데이트와 히스토리 기록을 동시에 처리
				boolean updateSuccess = personnelService.updatePersonChangeStatus(requestData);
			//	boolean insertSuccess = personnelService.insertPersonChangeHistory(requestData);
				boolean resetSuccess = personnelService.resetPersonChangeStatus(requestData);

				Map<String, Boolean> response = new HashMap<>();
				response.put("success", (updateSuccess && /* insertSuccess && */ resetSuccess));
				return ResponseEntity.ok(response);
			}catch(Exception e){
				e.printStackTrace();
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
			}
		}




}