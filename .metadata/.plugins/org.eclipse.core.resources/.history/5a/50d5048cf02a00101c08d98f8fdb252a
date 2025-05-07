package com.ict.project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.vo.personnel.UsersVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

// 작성자: 김재겸

@Controller
public class PersonnelController {

    private static final Logger logger = LoggerFactory.getLogger(PersonnelController.class);

    /*
      기능
      1. 출퇴근 도장 기능
      2. 오늘의 할일 달력(TO DO 달력) 기능
      3. 근무 방식 및 희망 근무지 기능
      4. 내 월급 리스트 확인 기능
      5. 휴가 신청 기능
      6. 공지사항 기능
     */

    @GetMapping("/attendance")
    public ModelAndView AttendancePageGO(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        debugSession(session, "/attendance");
        // 세션 확인
        if (!isUserLoggedIn(session)) {
            logger.warn("[DEBUG] 로그인되지 않은 사용자 - /attendance로 접근 시도");
            mv.setViewName("redirect:/login");
            return mv;
        }
        mv.setViewName("MainPage/attendance");
        return mv;
    }

    @GetMapping("/PayrollManagement")
    public ModelAndView getPayrollManagement(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        debugSession(session, "/PayrollManagement");
        // 세션 확인
        if (!isUserLoggedIn(session)) {
            logger.warn("[DEBUG] 로그인되지 않은 사용자 - /PayrollManagement로 접근 시도");
            mv.setViewName("redirect:/login");
            return mv;
        }
        mv.setViewName("/Payment/pay");
        return mv;
    }

    @GetMapping("/payrollList")
    public ModelAndView getPayrollList(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        debugSession(session, "/payrollList");
        // 세션 확인
        if (!isUserLoggedIn(session)) {
            logger.warn("[DEBUG] 로그인되지 않은 사용자 - /payrollList로 접근 시도");
            mv.setViewName("redirect:/login");
            return mv;
        }
        mv.setViewName("Payment/pay");
        return mv;
    }

    @GetMapping("/payrollGrade")
    public ModelAndView getPayrollGrade(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        debugSession(session, "/payrollGrade");
        // 세션 확인 (관리자 권한 확인 추가)
        if (!isUserLoggedIn(session)) {
            logger.warn("[DEBUG] 로그인되지 않은 사용자 - /payrollGrade로 접근 시도");
            mv.setViewName("redirect:/login");
            return mv;
        }
        if (!"ok".equals(session.getAttribute("admin"))) {
            logger.warn("[DEBUG] 관리자 권한 없음 - /payrollGrade로 접근 시도, emp_email: {}", 
                session.getAttribute("emp_email"));
            mv.setViewName("redirect:/index");
            return mv;
        }
        mv.setViewName("Payment/adminPay");
        return mv;
    }

    // 세션 데이터 디버깅 메서드
    private void debugSession(HttpSession session, String endpoint) {
        System.out.println("[DEBUG] 엔드포인트: " + endpoint);
        System.out.println("[DEBUG] 세션 loginchk: " + session.getAttribute("loginchk"));
        System.out.println("[DEBUG] 세션 emp_email: " + session.getAttribute("emp_email"));
        System.out.println("[DEBUG] 세션 role: " + session.getAttribute("role"));
        System.out.println("[DEBUG] 세션 admin: " + session.getAttribute("admin"));
        UsersVO user = (UsersVO) session.getAttribute("userVO");
        System.out.println("[DEBUG] 세션 userVO: " + (user != null ? user.toString() : "null"));
       
    }

    // 로그인 상태 확인 메서드
    private boolean isUserLoggedIn(HttpSession session) {
        return "ok".equals(session.getAttribute("loginchk"));
    }
}