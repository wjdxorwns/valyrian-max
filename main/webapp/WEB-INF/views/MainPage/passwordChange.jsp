<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 변경 - 3부상조</title>
<link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">

<style>
.reset-container {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: calc(100vh - 120px);
	background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
	padding: 20px;
}

.reset-box {
	background: #fff;
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 400px;
	text-align: center;
}

.reset-title {
	font-size: 28px;
	font-weight: 700;
	color: #333;
	margin-bottom: 10px;
}

.reset-subtitle {
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

.reset-button {
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

.reset-button:hover {
	background: #0056b3;
}
</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />

	<main>
		<section class="reset-container">
			<div class="reset-box">
				<h2 class="reset-title">비밀번호 변경</h2>
				<p class="reset-subtitle">새 비밀번호를 입력하세요.</p>
				<form id="resetForm" action="<c:url value='/reset-password/submit' />" method="post">
					<div class="input-group">
						<label for="new_password">새 비밀번호</label>
						<input type="password" id="new_password" name="new_password" placeholder="새 비밀번호를 입력하세요" required>
					</div>
					<div class="input-group">
						<label for="confirm_password">새 비밀번호 확인</label>
						<input type="password" id="confirm_password" name="confirm_password" placeholder="비밀번호를 다시 입력하세요" required>
					</div>
					<button type="submit" class="reset-button">비밀번호 변경</button>
				</form>
			</div>
		</section>
	</main>

	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

	<script>
		document.getElementById('resetForm').addEventListener('submit', function(e) {
			const newPassword = document.getElementById('new_password').value;
			const confirmPassword = document.getElementById('confirm_password').value;
			if (!newPassword || !confirmPassword) {
				e.preventDefault();
				alert('모든 비밀번호 입력란을 채워주세요.');
				return;
			}
			if (newPassword !== confirmPassword) {
				e.preventDefault();
				alert('비밀번호가 일치하지 않습니다.');
			}
		});
	</script>
</body>
</html>
