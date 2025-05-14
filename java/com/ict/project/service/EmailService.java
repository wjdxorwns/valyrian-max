package com.ict.project.service;

public interface EmailService {
    String createCode();
    void sendHtmlMail(String toEmail, String subject, String htmlContent) throws Exception;
    String sendAuthMail(String toEmail) throws Exception;
    boolean isEmailRegistered(String email); // 이미 정의되어 있음, 오타 수정
}