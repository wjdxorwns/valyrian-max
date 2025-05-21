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

    @PostMapping(value = "/sendCode", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String sendCode(@RequestParam("email") String email, HttpServletRequest request) {
        System.out.println("Received /sendCode request with email: " + email);
        if (email == null || email.trim().isEmpty() || !email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            System.err.println("Invalid email format: " + email);
            return "fail: Invalid email format";
        }
        try {
            // 이메일 등록 여부 확인
            boolean isRegistered = emailService.isEmailRegistered(email);
            if (!isRegistered) {
                System.err.println("Unregistered email: " + email);
                return "fail: 가입된 이메일이 아닙니다";
            }
            // EmailService의 sendAuthMail 메서드로 인증 코드 전송
            String code = emailService.sendAuthMail(email);
            request.getSession().setAttribute("authCode", code);
            request.getSession().setAttribute("authTime", System.currentTimeMillis());
            System.out.println("Auth code sent: " + code + " to " + email);
            return "success";
        } catch (IllegalArgumentException e) {
            System.err.println("Invalid email argument: " + e.getMessage());
            return "fail: " + e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Failed to send email: " + e.getMessage());
            // 클라이언트가 이해할 수 있는 메시지로 변환
            String errorMsg = (e.getMessage() != null && e.getMessage().equals("Invalid recipient email address"))
                ? "유효하지 않은 이메일 주소입니다"
                : "이메일 전송에 실패했습니다. 관리자에게 문의하세요.";
            return "fail: " + errorMsg;
        }
    }

    @PostMapping(value = "/verifyCode", produces = "text/plain; charset=UTF-8")
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
            request.getSession().setAttribute("isVerified", true);
            return "match";
        } else {
            System.err.println("Code mismatch: expected " + savedCode + ", received " + code);
            return "mismatch";
        }
    }

    @GetMapping("/passwordChange")
    public ModelAndView passwordChange(HttpServletRequest request) {
        Boolean isVerified = (Boolean) request.getSession().getAttribute("isVerified");
        if (isVerified != null && isVerified) {
            return new ModelAndView("MainPage/passwordChange");
        } else {
            return new ModelAndView("ErrorPage").addObject("message", "인증이 필요합니다.");
        }
    }
}