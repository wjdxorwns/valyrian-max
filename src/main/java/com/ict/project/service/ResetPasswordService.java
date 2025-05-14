package com.ict.project.service;

// 비밀번호 변경 서비스 인터페이스
public interface ResetPasswordService {
    // 비밀번호를 업데이트하는 메서드
    boolean updatePassword(String empEmail, String newPassword);
}