<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('https://images.unsplash.com/photo-1516442719524-a603408c90cb?fit=crop&w=1350&q=80') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Arial', sans-serif;
        }
        .signup-container {
            background-color: rgba(0, 170, 255, 0.85);
            border-radius: 20px;
            padding: 40px 30px;
            width: 300px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            text-align: center;
        }
        .signup-container h2 {
            color: white;
            margin-bottom: 30px;
        }
        .signup-container input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid lightgray;
            border-radius: 5px;
            outline: none;
        }
        .signup-container button {
            width: 95%;
            padding: 10px;
            background: linear-gradient(to bottom, #3a9bdc, #0a5fbd);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 14px;
        }
        .signup-container button:hover {
            background: linear-gradient(to bottom, #2b87c6, #084d9c);
        }
        .signup-container p {
            margin-top: 15px;
            color: white;
            font-size: 12px;
        }
        .error-message {
            color: red;
            font-size: 12px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="signup-container">
    <h2>회원가입</h2>
    <form action="/signup" method="post">
        <input type="email" id="emp_email" name="emp_email" placeholder="이메일" required>
        <input type="text" id="emp_name" name="emp_name" placeholder="이름" required>
        <input type="password" id="emp_password" name="emp_password" placeholder="비밀번호" required>
        <input type="text" id="home" name="home" placeholder="집 주소" required>
        <input type="text" id="phone_number" name="phone_number" placeholder="전화번호" required>
        <button type="submit">가입 완료</button>
        <p class="error-message">${error}</p>
    </form>
    <p>이미 계정이 있으신가요? <a href="/login" style="color: white;">로그인</a></p>
</div>

</body>
</html>