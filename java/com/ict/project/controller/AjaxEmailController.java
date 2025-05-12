package com.ict.project.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.EmailService;

@RestController
public class AjaxEmailController {
    @Autowired 
    private EmailService emailService; 

    @PostMapping("/sendCode")
    @ResponseBody
    public String sendCode(@RequestParam("email") String email, HttpServletRequest request) {
        System.out.println("Received /sendCode request with email: " + email);
        if (email == null || email.trim().isEmpty() || !email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            System.err.println("Invalid email format: " + email);
            return "fail: Invalid email format";
        }
        try {
            String code = emailService.sendAuthMail(email);
            request.getSession().setAttribute("authCode", code);
            request.getSession().setAttribute("authTime", System.currentTimeMillis());
            System.out.println("Auth code sent: " + code + " to " + email);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Failed to send email: " + e.getMessage());
            return "fail: " + e.getMessage();
        }   
    }
    
    @PostMapping("/verifyCode")
    @ResponseBody
    public String verifyCode(@RequestParam("code") String code, HttpServletRequest request) {
        System.out.println("Received /verifyCode request with code: " + code);
        String savedCode = (String) request.getSession().getAttribute("authCode");
        Long savedTime = (Long) request.getSession().getAttribute("authTime");
        
        long currentTime = System.currentTimeMillis();
        if (savedCode == null || savedTime == null) {
            System.err.println("No auth code or time in session");
            return "no_code";
        }
        if ((currentTime - savedTime) > 1000 * 60 * 5) {
            System.err.println("Auth code expired");
            return "expired";
        }
        if (savedCode.equals(code)) {
            System.out.println("Code matched");
            request.getSession().setAttribute("isVerified", true); // 인증 성공 플래그 설정
            return "match"; 
        } else {
            System.err.println("Code mismatch: expected " + savedCode + ", received " + code);
            return "mismatch";
        }
    }

    // 비밀번호 변경 페이지로 이동
    @GetMapping("/passwordChange")
    public ModelAndView passwordChange(HttpServletRequest request) {
        Boolean isVerified = (Boolean) request.getSession().getAttribute("isVerified");
        if (isVerified != null && isVerified) {
            return new ModelAndView("MainPage/passwordChange"); // 대소문자 정확히 일치
        } else {
            return new ModelAndView("ErrorPage").addObject("message", "인증이 필요합니다.");
        }
    }
}