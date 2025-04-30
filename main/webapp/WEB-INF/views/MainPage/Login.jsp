<!-- 최성현 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="description" content="3부상조 로그인 - 안전하고 간편한 비즈니스 플랫폼에 접속하세요.">
<title>3부상조 - 로그인</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<!-- CSS 파일 링크 -->
<link href="<c:url value='/resources/css/Header.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/login.css' />"
	rel="stylesheet">

<style>

</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />
	<main>
		<section class="login-container">
			<div class="login-box">
				<h2 class="login-title">3부상조 로그인</h2>
				<p class="login-subtitle">안전하고 간편한 비즈니스 플랫폼에 접속하세요</p>
				<form id="loginForm" action="<c:url value='/login' />" method="post">
					<div class="input-group">
						<label for="emp_email">이메일</label> 
						<input type="email" id="emp_email" name="emp_email" placeholder="이메일을 입력하세요" required>
					</div>
					<div class="input-group">
						<label for="emp_password">비밀번호</label> 
						<input type="password" id="emp_password" name="emp_password" placeholder="비밀번호를 입력하세요" required>
					</div>
					<div class="options">
						<a href=" " class="forgot-password">비밀번호 찾기</a>
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
					const emp_email = document.getElementById('emp_email').value;
					const emp_password = document.getElementById('emp_password').value;

					if (!emp_email || !emp_password) {
						e.preventDefault();
						alert('이메일과 비밀번호를 입력해주세요.');
					}
				});
	</script>
</body>
</html>