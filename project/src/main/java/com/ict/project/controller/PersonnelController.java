package com.ict.project.controller;

import java.sql.Date;
import java.util.*;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.PersonnelService;

@Controller
public class PersonnelController {

    @Autowired
    private PersonnelService personnelservice;

    // 관리자 메인 급여 페이지 이동
    @GetMapping("/adminPay")
    public ModelAndView goToAdminPay() {
        return new ModelAndView("redirect:/admin_pay_list");
    }

    // 관리자 급여 리스트 조회
    @GetMapping("/admin_pay_list")
    public ModelAndView adminPayList() {
        ModelAndView mv = new ModelAndView("Payment/adminPay");
        List<Map<String, Object>> employeeList = personnelservice.searchEmployeesByName("");
        mv.addObject("employeeList", employeeList);
        return mv;
    }

    // 직원 급여 페이지 진입
    @GetMapping("/PayrollManagement")
    public ModelAndView payrollManagement(HttpSession session) {
        String emp_idx = (String) session.getAttribute("emp_idx");
        ModelAndView mv = new ModelAndView("Payment/pay");
        mv.addObject("emp_idx", emp_idx);
        return mv;
    }

    // 직원 전체 급여 보기
    @GetMapping("/payrollList")
    public ModelAndView payrollListRedirect(HttpSession session) {
        String emp_idx = (String) session.getAttribute("emp_idx");
        return new ModelAndView("redirect:/paylist?emp_idx=" + emp_idx);
    }
    @GetMapping("/payrollGrade")
    public ModelAndView deprecatedPayrollGradeRedirect() {
        return new ModelAndView("redirect:/admin_pay_list");
    }

    // 관리자 급여 검색
    @PostMapping("/searchEmployees")
    public ModelAndView searchEmployees(@RequestParam("searchType") String searchType,
                                        @RequestParam("searchKeyword") String searchKeyword) {
        ModelAndView mv = new ModelAndView("Payment/adminPay");
        List<Map<String, Object>> employeeList = new ArrayList<>();

        switch (searchType) {
            case "name":
                employeeList = personnelservice.searchEmployeesByName(searchKeyword);
                break;
            case "department":
                employeeList = personnelservice.searchEmployeesByDepartment(searchKeyword);
                break;
            case "position":
                employeeList = personnelservice.searchEmployeesByPosition(searchKeyword);
                break;
            default:
                mv.addObject("error", "잘못된 검색 기준입니다.");
                break;
        }

        mv.addObject("employeeList", employeeList);
        return mv;
    }

    // 급여 수정 진입
    @GetMapping("/pay_detail")
    public ModelAndView getPayUpdate(@RequestParam("emp_idx") String emp_idx, HttpSession session) {
       
    	if (!"ok".equals(session.getAttribute("admin"))) {
        	return new ModelAndView("redirect:/index");
        }
        Map<String, Object> user = personnelservice.serchpaydetail(emp_idx);
        
        if (user != null && user.get("gender") != null) {
            String genderCode = user.get("gender").toString();
            if ("0".equals(genderCode)) {
                user.put("gender", "남자");
            } else if ("1".equals(genderCode)) {
                user.put("gender", "여자");
            } else {
                user.put("gender", "-");
            }
        }
        
        Map<String, Object> latestSalary = personnelservice.getLatestSalary(emp_idx);

        if (latestSalary != null) {
        	 user.put("base_salary", latestSalary.get("base_salary"));
        	 user.put("bonus", latestSalary.get("bonus"));
        	 user.put("salary_id", latestSalary.get("salary_id")); 
        }
        
        
        ModelAndView mv = new ModelAndView("Payment/adminPayDetailUpdate");
        mv.addObject("user", user);
        return mv;
    }

    // 급여 삽입 진입
    @GetMapping("/pay_insert")
    public ModelAndView getPayInsert(@RequestParam("emp_idx") String emp_idx, HttpSession session) {
        if (!"ok".equals(session.getAttribute("admin"))) {
            return new ModelAndView("redirect:/index");
        }
        Map<String, Object> user = personnelservice.serchpaydetail(emp_idx);
        if (user != null && user.get("gender") != null) {
            String genderCode = user.get("gender").toString();
            if ("0".equals(genderCode)) {
                user.put("gender", "남자");
            } else if ("1".equals(genderCode)) {
                user.put("gender", "여자");
            } else {
                user.put("gender", "-");
            }
        }

        ModelAndView mv = new ModelAndView("Payment/adminPayDetailInsert");
        mv.addObject("user", user);
        return mv;
    }

    // 급여 수정 처리
    @PostMapping("/admin_Pay_Update_Ok")
    public ModelAndView updatePay(@RequestParam Map<String, String> paramMap, HttpSession session) {
        if (!"ok".equals(session.getAttribute("admin"))) {
            return new ModelAndView("redirect:/index");
        }
        try {
            String emp_idx = paramMap.get("emp_idx");
            int salary_id = Integer.parseInt(paramMap.get("salary_id"));
            double base_salary = Double.parseDouble(paramMap.get("base_salary"));
            double bonus = Double.parseDouble(paramMap.get("bonus"));

            Map<String, Object> updateParams = new HashMap<>();
            updateParams.put("salary_id", salary_id); 
            updateParams.put("base_salary", base_salary);
            updateParams.put("bonus", bonus);

            personnelservice.updatePayById(updateParams); // 이 메서드로 변경

            Map<String, Object> empParams = new HashMap<>();
            empParams.put("emp_idx", emp_idx);
            empParams.put("base_salary", base_salary);
            empParams.put("bonus", bonus);
            personnelservice.updateEmployeePay(empParams);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("redirect:/admin_pay_list");
    }

    // 급여 삽입 처리
    @PostMapping("/admin_Pay_Insert_Ok")
    public ModelAndView insertPay(@RequestParam Map<String, String> paramMap, HttpSession session) {
        if (!"ok".equals(session.getAttribute("admin"))) {
            return new ModelAndView("redirect:/index");
        }
        try {
            String emp_idx = paramMap.get("emp_idx");
            double base_salary = Double.parseDouble(paramMap.get("base_salary"));
            double bonus = Double.parseDouble(paramMap.get("bonus"));
            Date payment_date = Date.valueOf(paramMap.get("payment_date"));

            if (base_salary <= 0 || personnelservice.isPayRecordExists(emp_idx, payment_date)) {
                return new ModelAndView("redirect:/admin_pay_list");
            }

            Map<String, Object> insertParams = new HashMap<>();
            insertParams.put("emp_idx", emp_idx);
            insertParams.put("base_salary", base_salary);
            insertParams.put("bonus", bonus);
            insertParams.put("payment_date", payment_date);

            personnelservice.insertPay(insertParams);

            Map<String, Object> empParams = new HashMap<>();
            empParams.put("emp_idx", emp_idx);
            empParams.put("pay", base_salary);
            personnelservice.updateEmployeePay(empParams);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("redirect:/admin_pay_list");
    }

    // 직원 본인 급여 조회 (전체 or 특정 지급일)
    @GetMapping("/paylist")
    public ModelAndView getPayList(@RequestParam("emp_idx") String emp_idx,
                                   @RequestParam(value = "payment_date", required = false) String payment_date) {
        ModelAndView mv = new ModelAndView("Payment/pay");
        Map<String, Object> params = new HashMap<>();
        params.put("emp_idx", emp_idx);

        if (payment_date != null && !payment_date.isEmpty()) {
            if (payment_date.length() == 7) payment_date += "-01";
            params.put("payment_date", payment_date);
        }

        List<Map<String, Object>> paylist;
        if (params.containsKey("payment_date")) {
            paylist = personnelservice.serchpaylist(params);
        } else {
            paylist = personnelservice.serchpaylistAll(emp_idx);  // ← 새로 추가
        }

        mv.addObject("paylist", paylist);
        return mv;
    }

    // 기본 pay.jsp 이동용 (세션 값만 전달)
    @GetMapping("/pay")
    public ModelAndView getPayPage(HttpSession session) {
        String emp_idx = (String) session.getAttribute("emp_idx");
        ModelAndView mv = new ModelAndView("Payment/pay");
        mv.addObject("emp_idx", emp_idx);
        return mv;
    }
}