package com.ict.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ict.project.service.ResetPasswordService;

@Controller
@RequestMapping("/reset-password")
public class ResetPasswordController {

    @Autowired
    private ResetPasswordService resetPasswordService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @PostMapping("/submit")
    public String resetPassword(@RequestParam("emp_email") String empEmail,
                                 @RequestParam("new_password") String newPassword,
                                 @RequestParam("confirm_password") String confirmPassword,
                                 Model model) {
        // 이메일이 비어 있는지 확인
        if (empEmail == null || empEmail.isEmpty()) {
            model.addAttribute("error", "이메일이 필요합니다.");
            return "reset-password"; // 비밀번호 변경 페이지로 다시 이동
        }

        // 비밀번호 확인
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "reset-password"; // 비밀번호 변경 페이지로 다시 이동
        }

        // 비밀번호 암호화
        String encodedPassword = passwordEncoder.encode(newPassword);

        // 비밀번호 변경 처리
        boolean isUpdated = resetPasswordService.updatePassword(empEmail, encodedPassword);
        if (isUpdated) {
            // 성공 시 로그인 페이지로 리다렉션
            return "redirect:/login?resetSuccess=true"; // 리다이렉트 시 성공 메시지 전달 (선택 사항)
        } else {
            model.addAttribute("error", "비밀번호 변경에 실패했습니다. 다시 시도해주세요.");
            return "reset-password";
        }
    }
}