<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부창조 - 로그인</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
<style>
* {
	box-sizing: border-box;
	font-family: 'Roboto', sans-serif;
}

body, html {
	margin: 0;
	padding: 0;
	height: 100vh;
}

body {
	background-image: url('https://images.unsplash.com/photo-1608889175626-2a2f464f2130');
	background-size: cover;
	background-position: center;
	display: flex;
	justify-content: flex-end;
	align-items: center;
}

.login-container {
	width: 320px;
	background-color: rgba(0, 160, 255, 0.85); /* 더 흐리게 */
	border-radius: 30px;
	padding: 40px 30px;
	margin-right: 60px;
	color: white;
	box-shadow: 0 4px 20px rgba(0,0,0,0.3); /* 그림자 */
}

.logo {
	text-align: center;
	margin-bottom: 20px;
}

.logo img {
	width: 50px;
}

.logo h2 {
	margin: 5px 0;
}

h3 {
	text-align: center;
	margin-bottom: 30px;
	line-height: 1.4;
	font-size: 22px;
}

input[type="email"], input[type="password"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 15px;
	border: none;
	border-radius: 5px;
	font-size: 14px;
	box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
}

.login-btn {
	width: 100%;
	padding: 10px;
	background-color: navy;
	color: white;
	font-size: 16px;
	border: none;
	border-radius: 5px;
	margin-bottom: 15px;
	cursor: pointer;
}

.social-btn {
	width: 100%;
	padding: 10px;
	margin-top: 8px;
	border: none;
	border-radius: 5px;
	font-size: 14px;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
}

.social-google {
	background-color: white;
	color: black;
}

.social-kakao {
	background-color: #FEE500;
	color: black;
}

.social-naver {
	background-color: #03C75A;
	color: white;
}

.social-btn img {
	width: 20px;
	height: 20px;
	margin-right: 8px;
}

.register-link {
	text-align: center;
	margin-top: 10px;
	font-size: 12px;
	color: #eee;
}

a {
	color: #fff;
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="login-container">
		<div class="logo">
			<img src="https://cdn-icons-png.flaticon.com/512/709/709579.png" alt="로고" />
			<h2>3부창조</h2>
		</div>
		<h3>Create<br>Account</h3>
		
		<form name="loginForm" onsubmit="return validateForm()" action="loginProcess" method="post">
			<input type="email" name="email" placeholder="이메일" required />
			<input type="password" name="password" placeholder="비밀번호" required />
			<button type="submit" class="login-btn">로그인</button>
		</form>

		<div class="register-link">
			계정이 없으신가요? <a href="register.jsp">가입하기</a>
		</div>

		<button class="social-btn social-google">
			<img src="https://cdn-icons-png.flaticon.com/512/281/281764.png" alt="Google 아이콘" /> Google로 시작하기
		</button>
		<button class="social-btn social-kakao">
			<img src="https://cdn-icons-png.flaticon.com/512/2111/2111493.png" alt="Kakao 아이콘" /> 카카오로 시작하기
		</button>
		<button class="social-btn social-naver">
			<img src="https://cdn-icons-png.flaticon.com/512/2175/2175377.png" alt="Naver 아이콘" /> 네이버로 시작하기
		</button>
	</div>

	<script>
		function validateForm() {
			const email = document.loginForm.email.value;
			const password = document.loginForm.password.value;
			if (!email || !password) {
				alert("이메일과 비밀번호를 모두 입력해주세요.");
				return false;
			}
			return true;
		}
	</script>
</body>
</html>
