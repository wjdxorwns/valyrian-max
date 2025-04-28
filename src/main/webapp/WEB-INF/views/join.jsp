<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
            padding: 30px 25px;
            width: 350px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            text-align: center;
        }
        .signup-container h2 {
            color: white;
            margin-bottom: 25px;
        }
        .signup-container input[type="text"],
        .signup-container input[type="email"],
        .signup-container input[type="password"] {
            width: 90%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid lightgray;
            border-radius: 5px;
            outline: none;
        }
        .signup-container input[type="button"] {
            width: 95%;
            padding: 10px;
            margin-top: 8px;
            background: linear-gradient(to bottom, #3a9bdc, #0a5fbd);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .signup-container input[type="button"]:hover {
            background: linear-gradient(to bottom, #2b87c6, #084d9c);
        }
        .signup-container button[type="submit"] {
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
        .signup-container button[type="submit"]:hover {
            background: linear-gradient(to bottom, #2b87c6, #084d9c);
        }
        .signup-container p {
            color: white;
            font-size: 12px;
            margin-top: 10px;
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
    <form action="/members_join_ok" method="post" autocomplete="off" onsubmit="return checkForm();">
        <input type="text" id="m_id" name="m_id" placeholder="아이디" required>
        <input type="password" id="m_pw" name="m_pw" placeholder="비밀번호" required>
        <input type="password" id="m_pw2" name="m_pw2" placeholder="비밀번호 확인" required>
        <input type="text" id="m_name" name="m_name" placeholder="이름" required>
        <input type="text" id="m_addr" name="m_addr" placeholder="주소" readonly required>
        <input type="button" value="주소찾기" onclick="execDaumPostcode()">

        <input type="text" id="m_addr2" name="m_addr2" placeholder="상세주소입력">

        <input type="email" id="m_email" name="m_email" placeholder="이메일" required>
        <input type="button" value="인증번호 보내기" onclick="sendVerificationCode()">

        <input type="text" id="emailCode" placeholder="인증번호 입력">
        <input type="button" value="인증확인" onclick="checkVerificationCode()">

        <input type="text" id="m_phone" name="m_phone" placeholder="전화번호" required disabled>

        <button type="submit" id="submitBtn" disabled>가입 완료</button>

        <p class="error-message">${error}</p>
        <p>이미 계정이 있으신가요? <a href="/login" style="color: white;">로그인</a></p>
    </form>
</div>

<script>
    function checkForm() {
        const pw = $("#m_pw").val();
        const pw2 = $("#m_pw2").val();
        if (pw === pw2) {
            return true;
        } else {
            alert("비밀번호가 일치하지 않습니다.");
            $("#m_pw").val("");
            $("#m_pw2").val("").focus();
            return false;
        }
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById('m_addr').value = data.address;
            }
        }).open();
    }

    function sendVerificationCode() {
        alert("이메일로 인증번호가 전송되었습니다. (구현 필요)");
        // Ajax로 서버 요청 예제
    }

    function checkVerificationCode() {
        alert("인증번호 확인 완료. (구현 필요)");
        $("#m_phone").prop('disabled', false);
        $("#submitBtn").prop('disabled', false);
    }
</script>

</body>
</html>