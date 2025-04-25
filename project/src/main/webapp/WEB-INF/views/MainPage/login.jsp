<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="description" content="3부창조 로그인 - 안전하고 간편한 비즈니스 플랫폼에 접속하세요.">
<title>3부창조 - 로그인</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<!-- CSS 파일 링크 -->
<link href="<c:url value='/resources/css/Header.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />"
	rel="stylesheet">

<style>
.login-container {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: calc(100vh - 120px); /* Header와 Footer 높이를 고려 */
	background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
	padding: 20px;
}

.login-box {
	background: #fff;
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 400px;
	text-align: center;
}

.login-title {
	font-size: 28px;
	font-weight: 700;
	color: #333;
	margin-bottom: 10px;
}

.login-subtitle {
	font-size: 16px;
	color: #666;
	margin-bottom: 30px;
}

.input-group {
	margin-bottom: 20px;
	text-align: left;
}

.input-group label {
	display: block;
	font-size: 14px;
	color: #333;
	margin-bottom: 8px;
	font-weight: 500;
}

.input-group input {
	width: 100%;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 16px;
	transition: border-color 0.3s;
}

.input-group input:focus {
	outline: none;
	border-color: #007bff;
}

.options {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
	font-size: 14px;
}

.remember-me {
	color: #666;
}

.forgot-password {
	color: #007bff;
	text-decoration: none;
}

.forgot-password:hover {
	text-decoration: underline;
}

.login-button {
	width: 100%;
	padding: 12px;
	background: #007bff;
	border: none;
	border-radius: 5px;
	color: #fff;
	font-size: 16px;
	font-weight: 500;
	cursor: pointer;
	transition: background 0.3s;
}

.login-button:hover {
	background: #0056b3;
}

.signup-prompt {
	margin-top: 20px;
	font-size: 14px;
	color: #666;
}

.signup-prompt a {
	color: #007bff;
	text-decoration: none;
}

.signup-prompt a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />
	<main>
		<section class="login-container">
			<div class="login-box">
				<h2 class="login-title">3부창조 로그인</h2>
				<p class="login-subtitle">안전하고 간편한 비즈니스 플랫폼에 접속하세요</p>
				<form id="loginForm" action="<c:url value='/login' />" method="post">
					<div class="input-group">
						<label for="username">아이디</label> <input type="text" id="username"
							name="username" placeholder="아이디를 입력하세요" required>
					</div>
					<div class="input-group">
						<label for="password">비밀번호</label> <input type="password"
							id="password" name="password" placeholder="비밀번호를 입력하세요" required>
					</div>
					<div class="options">
						<label class="remember-me"> <input type="checkbox"
							name="rememberMe"> 로그인 유지
						</label> <a href="<c:url value='/forgot-password' />"
							class="forgot-password">비밀번호 찾기</a>
					</div>
					<button type="submit" class="login-button">로그인</button>
				</form>
			</div>
		</section>
	</main>

	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

	<script>
		document.getElementById('loginForm').addEventListener('submit',
				function(e) {
					const username = document.getElementById('username').value;
					const password = document.getElementById('password').value;

					if (!username || !password) {
						e.preventDefault();
						alert('아이디와 비밀번호를 입력해주세요.');
					}
				});
	</script>
</body>
</html>