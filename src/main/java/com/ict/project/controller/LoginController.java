package com.ict.project.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.LoginService;

@Controller
public class LoginController {

    @Autowired
    private LoginService loginService;

    // 로그인 페이지로 이동
    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // /WEB-INF/views/login.jsp로 매핑 (servlet-context.xml의 ViewResolver 설정 필요)
    }

    // 로그인 처리
    @PostMapping("/loginProcess")
    public ModelAndView processLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        ModelAndView mav = new ModelAndView();

        boolean isValid = loginService.authenticate(email, password);
        if (isValid) {
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            mav.setViewName("redirect:/index.jsp");
        } else {
            mav.addObject("errorMessage", "로그인 실패: 이메일이나 비밀번호가 잘못되었습니다.");
            mav.setViewName("login"); // 로그인 실패 시 다시 로그인 페이지로
        }
        return mav;
    }
}