package com.ict.project.service;

import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.EmailDAO;

@Service
public class EmailServiceImpl implements EmailService {

    @Autowired
    private EmailDAO emailDAO;

    @Override
    public String createCode() {
        Random ran = new Random();
        return String.valueOf(100000 + ran.nextInt(900000));
    }

    @Override
    public void sendHtmlMail(String toEmail, String subject, String htmlContent) throws Exception {
        if (toEmail == null || toEmail.trim().isEmpty()) {
            throw new IllegalArgumentException("Recipient email cannot be empty");
        }
        System.out.println("Preparing to send email to: " + toEmail);
        Properties props = new Properties();
        String smtpHost = EmailUtil.get("mail.smtp.host");
        String smtpPort = EmailUtil.get("mail.smtp.port");
        String smtpAuth = EmailUtil.get("mail.smtp.auth");
        String starttls = EmailUtil.get("mail.smtp.starttls.enable");

        if (smtpHost == null || smtpPort == null || smtpAuth == null || starttls == null) {
            throw new IllegalStateException("Missing SMTP configuration in mail.properties");
        }

        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", smtpPort);
        props.put("mail.smtp.auth", smtpAuth);
        props.put("mail.smtp.starttls.enable", starttls);
        props.put("mail.debug", "true");

        String username = EmailUtil.get("mail.smtp.username");
        String password = EmailUtil.get("mail.smtp.password");
        if (username == null || password == null) {
            throw new IllegalStateException("SMTP username or password not configured");
        }

        System.out.println("SMTP settings: host=" + smtpHost + ", port=" + smtpPort + ", auth=" + smtpAuth + ", username=" + username);

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username, EmailUtil.get("mail.sender.name"), "UTF-8"));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
        message.setSubject(subject);
        message.setSentDate(new Date());
        message.setContent(htmlContent, "text/html; charset=UTF-8");

        System.out.println("Sending email to: " + toEmail);
        Transport.send(message);
        System.out.println("Email sent successfully to: " + toEmail);
    }

    @Override
    public String sendAuthMail(String toEmail) throws Exception {
        if (toEmail == null || toEmail.trim().isEmpty() || !toEmail.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            throw new IllegalArgumentException("Invalid recipient email address");
        }
        String code = createCode();
        String html = "<h3>인증코드</h3><p><b>" + code + "</b></p><p>5분 이내에 입력해주세요</p>";
        System.out.println("Generated auth code: " + code + " for email: " + toEmail);
        sendHtmlMail(toEmail, "[ICTEDU 서비스] 이메일 인증", html);
        return code;
    }

    @Override
    public boolean isEmailRegistered(String email) {
        return emailDAO.countActiveUserByEmail(email) > 0;
    }
}