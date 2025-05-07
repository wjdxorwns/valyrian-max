<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 - 3부상조</title>
<link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">

<style>
/* 비밀번호 찾기 페이지 스타일 */
.forgot-container {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: calc(100vh - 120px);
	background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
	padding: 20px;
}

.forgot-box {
	background: #fff;
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 400px;
	text-align: center;
}

.forgot-title {
	font-size: 28px;
	font-weight: 700;
	color: #333;
	margin-bottom: 10px;
}

.forgot-subtitle {
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

.forgot-button {
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

.forgot-button:hover {
	background: #0056b3;
}

.back-to-login {
	margin-top: 20px;
	font-size: 14px;
	color: #666;
}

.back-to-login a {
	color: #007bff;
	text-decoration: none;
}

.back-to-login a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />

	<main>
		<section class="forgot-container">
			<div class="forgot-box">
				<h2 class="forgot-title">비밀번호 찾기</h2>
				<p class="forgot-subtitle">가입하신 이메일을 입력하세요.</p>
				<form id="forgotForm" action="<c:url value='/forgot-password/send-email' />" method="post">
					<div class="input-group">
						<label for="email">이메일</label>
						<input type="email" id="email" name="email" placeholder="이메일을 입력하세요" required>
					</div>
					<button type="submit" class="forgot-button">인증 코드 받기</button>
				</form>
				<c:if test="${not empty emailError}">
					<p style="color: red;">${emailError}</p>
				</c:if>
				<div class="back-to-login">
					<a href="<c:url value='/login' />">로그인 페이지로 돌아가기</a>
				</div>
			</div>
		</section>

		<!-- 인증 코드 입력 폼 -->
		<c:if test="${not empty verification}">
			<section class="forgot-container">
				<div class="forgot-box">
					<h2 class="forgot-title">인증 코드 입력</h2>
					<p class="forgot-subtitle">이메일로 발송된 인증 코드를 입력하세요.</p>
					<form id="verificationForm" action="<c:url value='/forgot-password/verify-code' />" method="post">
						<div class="input-group">
							<label for="verificationCode">인증 코드</label>
							<input type="text" id="verificationCode" name="verificationCode" placeholder="인증 코드를 입력하세요" required>
						</div>
						<button type="submit" class="forgot-button">인증 코드 확인</button>
					</form>
				</div>
			</section>
		</c:if>
	</main>

	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

	<script>
		document.getElementById('forgotForm').addEventListener('submit', function(e) {
			const email = document.getElementById('email').value;
			if (!email) {
				e.preventDefault();
				alert('이메일을 입력해주세요.');
			}
		});
	</script>
</body>
</html>
