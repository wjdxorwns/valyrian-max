// PersonnelController.java
package com.ict.project.controller;

import java.sql.Date;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.PersonnelService;
import com.ict.project.vo.management.RequestLoggingVO;
import com.ict.project.vo.personnel.UsersVO; // Assuming UsersVO exists and is used for session user

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

    // 휴가 리스트
    @GetMapping("/vacationList")
    public ModelAndView VacationListPageGO(HttpSession session) {

        UsersVO user = (UsersVO) session.getAttribute("userVO");
        if (user == null) {
            System.out.println("No user in session, redirecting to login");
            return new ModelAndView("redirect:/login");
        }

        ModelAndView mv = new ModelAndView("Vacation/vacationList");
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

        ModelAndView mv = new ModelAndView("Vacation/vacationApproval");
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
                // Ensure request_idx and logging_vacation are correctly mapped from the incoming request body
                Object requestIdxObj = approval.get("request_idx");
                if (requestIdxObj instanceof Number) {
                    logging.setRequest_idx(((Number) requestIdxObj).intValue());
                } else if (requestIdxObj != null) {
                    try {
                        logging.setRequest_idx(Integer.parseInt(String.valueOf(requestIdxObj)));
                    } catch (NumberFormatException e) {
                        System.err.println("Invalid request_idx format: " + requestIdxObj);
                        // Handle error or skip logging for this entry
                    }
                }
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

        ModelAndView mv = new ModelAndView("Vacation/vacationInquiry");

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

     // 관리자 메인 급여 페이지 이동
    @GetMapping("/adminPay")
    public ModelAndView goToAdminPay() {
        return new ModelAndView("redirect:/admin_pay_list");
    }

    // 관리자 급여 리스트 조회
    @GetMapping("/admin_pay_list")
    public ModelAndView adminPayList() {
        ModelAndView mv = new ModelAndView("Payment/adminPay");
        // Initially search for all employees (empty keyword)
        List<Map<String, Object>> employeeList = personnelService.searchEmployeesByName("");
        mv.addObject("employeeList", employeeList);
        return mv;
    }

    // 직원 급여 페이지 진입 (This seems to be a redundant mapping for PayrollManagement, consider consolidating)
    @GetMapping("/PayrollManagement")
    public ModelAndView payrollManagement(HttpSession session) {
        String emp_idx = (String) session.getAttribute("emp_idx");
        ModelAndView mv = new ModelAndView("Payment/pay");
        mv.addObject("emp_idx", emp_idx);
        return mv;
    }

    // 직원 전체 급여 보기 (Redirects to /paylist with emp_idx from session)
    @GetMapping("/payrollList")
    public ModelAndView payrollListRedirect(HttpSession session) {
        String emp_idx = (String) session.getAttribute("emp_idx");
        if (emp_idx == null) {
            // Handle case where emp_idx is not in session, e.g., redirect to login or error page
            return new ModelAndView("redirect:/login"); // Or an appropriate error view
        }
        return new ModelAndView("redirect:/paylist?emp_idx=" + emp_idx);
    }

    // Deprecated mapping, redirects to admin_pay_list
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
                employeeList = personnelService.searchEmployeesByName(searchKeyword);
                break;
            case "department":
                employeeList = personnelService.searchEmployeesByDepartment(searchKeyword);
                break;
            case "position":
                employeeList = personnelService.searchEmployeesByPosition(searchKeyword);
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
        Map<String, Object> user = personnelService.serchpaydetail(emp_idx);

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

        Map<String, Object> latestSalary = personnelService.getLatestSalary(emp_idx);

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
        Map<String, Object> user = personnelService.serchpaydetail(emp_idx);
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
            // Ensure salary_id exists and is a valid integer
            int salary_id = -1; // Default value or error handling
            if (paramMap.containsKey("salary_id") && !paramMap.get("salary_id").isEmpty()) {
                try {
                    salary_id = Integer.parseInt(paramMap.get("salary_id"));
                } catch (NumberFormatException e) {
                    System.err.println("Invalid salary_id format: " + paramMap.get("salary_id"));
                    // Handle error, maybe redirect with an error message
                    return new ModelAndView("redirect:/admin_pay_list?error=invalid_salary_id");
                }
            } else {
                System.err.println("salary_id is missing in paramMap for updatePay.");
                return new ModelAndView("redirect:/admin_pay_list?error=missing_salary_id");
            }

            double base_salary = Double.parseDouble(paramMap.get("base_salary"));
            double bonus = Double.parseDouble(paramMap.get("bonus"));

            Map<String, Object> updateParams = new HashMap<>();
            updateParams.put("salary_id", salary_id);
            updateParams.put("base_salary", base_salary);
            updateParams.put("bonus", bonus);

            personnelService.updatePayById(updateParams);

            // The original code also updates employee's 'pay' (base_salary) here.
            // This assumes `pay` in the employee table is the current base salary.
            Map<String, Object> empParams = new HashMap<>();
            empParams.put("emp_idx", emp_idx);
            empParams.put("pay", base_salary); // Assuming 'pay' field in employee table maps to base_salary
            personnelService.updateEmployeePay(empParams);

        } catch (NumberFormatException e) {
            System.err.println("Number format error in updatePay: " + e.getMessage());
            e.printStackTrace();
            return new ModelAndView("redirect:/admin_pay_list?error=number_format_error");
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("redirect:/admin_pay_list?error=internal_error");
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

            if (base_salary <= 0 || personnelService.isPayRecordExists(emp_idx, payment_date)) {
                // Prevent insertion if base_salary is non-positive or a record for this emp_idx and payment_date already exists
                System.out.println("Attempted to insert pay record with invalid base_salary or duplicate entry.");
                return new ModelAndView("redirect:/admin_pay_list?error=invalid_or_duplicate_pay_record");
            }

            Map<String, Object> insertParams = new HashMap<>();
            insertParams.put("emp_idx", emp_idx);
            insertParams.put("base_salary", base_salary);
            insertParams.put("bonus", bonus);
            insertParams.put("payment_date", payment_date);

            personnelService.insertPay(insertParams);

            // Update the employee's main pay field in the Employee table (assuming 'pay' is the current base salary)
            Map<String, Object> empParams = new HashMap<>();
            empParams.put("emp_idx", emp_idx);
            empParams.put("pay", base_salary); // Update the employee's overall pay with the newly inserted base salary
            personnelService.updateEmployeePay(empParams);

        } catch (NumberFormatException e) {
            System.err.println("Number format error in insertPay: " + e.getMessage());
            e.printStackTrace();
            return new ModelAndView("redirect:/admin_pay_list?error=number_format_error");
        } catch (IllegalArgumentException e) { // For Date.valueOf()
            System.err.println("Date format error in insertPay: " + e.getMessage());
            e.printStackTrace();
            return new ModelAndView("redirect:/admin_pay_list?error=invalid_date_format");
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("redirect:/admin_pay_list?error=internal_error");
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

        List<Map<String, Object>> paylist;

        if (payment_date != null && !payment_date.isEmpty()) {
            // Assuming payment_date can be "YYYY-MM" or "YYYY-MM-DD"
            // If "YYYY-MM", append "-01" to make it parsable as a Date
            if (payment_date.length() == 7) {
                payment_date += "-01";
            }
            params.put("payment_date", payment_date);
            paylist = personnelService.serchpaylist(params); // Search by specific date
        } else {
            paylist = personnelService.serchpaylistAll(emp_idx); // Get all payroll records for the employee
        }

        mv.addObject("paylist", paylist);
        return mv;
    }

    // 기본 pay.jsp 이동용 (세션 값만 전달)
    @GetMapping("/pay")
    public ModelAndView getPayPage(HttpSession session) {
        String emp_idx = (String) session.getAttribute("emp_idx");
        ModelAndView mv = new ModelAndView("Payment/pay");
        mv.addObject("emp_idx", emp_idx); // Pass emp_idx to the view
        return mv;
    }

}