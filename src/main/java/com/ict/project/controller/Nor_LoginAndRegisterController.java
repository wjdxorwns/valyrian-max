package com.ict.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ict.project.service.Nor_Service;
import com.ict.project.vo.personnel.UserVO;

@Controller
public class Nor_LoginAndRegisterController {

    @Autowired
    private Nor_Service norService;

    // Display the login page
    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // Maps to login.jsp
    }

    // Handle login form submission
    @PostMapping("/login")
    public String login(@RequestParam("emp_email") String empEmail, 
                        @RequestParam("emp_password") String empPassword, 
                        Model model) {
        UserVO user = norService.login(empEmail, empPassword);
        if (user != null) {
            // Successful login - redirect to a dashboard or home page
            return "redirect:/dashboard"; // Adjust redirect as needed
        } else {
            // Failed login - show error message
            model.addAttribute("error", "이메일 또는 비밀번호가 잘못되었습니다.");
            return "login"; // Return to login page with error
        }
    }
}