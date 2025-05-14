<!-- 최성현 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="description" content="3부상조 회원가입 - 안전하고 간편한 비즈니스 플랫폼에 가입하세요.">
<title>3부상조 - 회원가입</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- CSS 파일 링크 -->
<link href="<c:url value='/resources/css/Header.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />"
	rel="stylesheet">
<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: 'Roboto', sans-serif;
}

main {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 1rem;
	min-height: calc(100vh - 80px - 200px);
	background: #e9f0fd;
	margin-top: 80px;
}

.signup-container {
	background: #fff;
	border-radius: 8px;
	padding: 1.5rem;
	width: 100%;
	max-width: 800px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	overflow-y: auto;
	max-height: calc(100vh - 80px - 200px - 2rem);
}

.signup-container h2 {
	font-size: 1.5rem;
	color: #333;
	text-align: center;
	margin-bottom: 0.5rem;
	font-weight: 700;
}

.signup-container p.welcome {
	font-size: 0.9rem;
	color: #666;
	text-align: center;
	margin-bottom: 1.5rem;
}

.error-message {
	display: none;
	color: #fff;
	background-color: #ff6b6b;
	padding: 0.5rem;
	border-radius: 4px;
	margin-bottom: 1rem;
	font-size: 0.85rem;
	text-align: center;
}

.error-message.show {
	display: block;
}

.form-grid | {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 1.5rem;
	margin-bottom: 1rem;
}

.form-section {
	display: flex;
	flex-direction: column;
	gap: 0.8rem;
}

.section-title {
	font-size: 1rem;
	color: #333;
	margin-bottom: 0.5rem;
	padding-bottom: 0.3rem;
	border-bottom: 1px solid #ddd;
	font-weight: 500;
}

.form-group {
	margin-bottom: 0.8rem;
}

.form-group label {
	display: block;
	font-size: 0.9rem;
	color: #333;
	margin-bottom: 0.3rem;
	font-weight: 500;
}

.input-with-button {
	display: flex;
	gap: 0.5rem;
	align-items: center;
}

input[type="text"], input[type="email"], input[type="password"] {
	width: 100%;
	padding: 0.6rem;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 0.9rem;
	background-color: #fff;
	transition: border-color 0.3s;
}

input[type="text"]:focus, input[type="email"]:focus, input[type="password"]:focus
	{
	outline: none;
	border-color: #1e90ff;
	box-shadow: 0 0 4px rgba(30, 144, 255, 0.2);
}

input[readonly], input:disabled {
	background-color: #f5f5f5;
	cursor: not-allowed;
	opacity: 0.6;
}

.form-group input[type="button"] {
	padding: 0.6rem 1rem;
	background-color: #1e90ff;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 0.85rem;
	transition: background 0.3s;
	white-space: nowrap;
}

.form-group input[type="button"]:hover {
	background-color: #1c86ee;
}

button[type="submit"] {
	width: 100%;
	padding: 0.8rem;
	background-color: #1e90ff;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 0.95rem;
	transition: background 0.3s;
}

button[type="submit"]:hover {
	background-color: #1c86ee;
}

button[type="submit"]:disabled {
	background-color: #a0c4ff;
	cursor: not-allowed;
}

.login-link {
	text-align: center;
	margin-top: 1rem;
	font-size: 0.85rem;
	color: #666;
}

.login-link a {
	color: #1e90ff;
	text-decoration: none;
}

.login-link a:hover {
	text-decoration: underline;
}

/* Signature Canvas Styling */
#signatureCanvas {
	border: 1px solid #ddd;
	border-radius: 4px;
	background-color: #f9f9f9;
	width: 100%;
	height: 100px;
	touch-action: none; /* Prevent scrolling on touch devices */
}

.signature-buttons {
	display: flex;
	gap: 0.5rem;
	margin-top: 0.5rem;
}
</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />
	<main>
		<div class="signup-container">
			<h2>회원가입</h2>
			<p class="welcome">3부상조와 함께 비즈니스 여정을 시작하세요!</p>
			<div class="error-message" id="error-message">
				<c:out value="${error}" />
			</div>
			<form action="/members_join_ok" method="post" autocomplete="off"
				onsubmit="return checkForm();">
				<div class="form-grid">
					<!-- Account Information -->
					<div class="form-section">
						<div class="section-title">계정 정보</div>
						<div class="form-group">
							<label for="emp_name">이름</label> 
							<input type="text" id="emp_name" name="emp_name" placeholder="이름" required tabindex="1" />
						</div>
						<div class="form-group">
							<label for="emp_email">이메일</label> 
							<input type="email" id="emp_email" name="emp_email" placeholder="이메일" required tabindex="2" />
						</div>
						<div class="form-group">
							<label for="emp_password">비밀번호</label> 
							<input type="password" id="emp_password" name="emp_password" placeholder="비밀번호" required tabindex="3" />
						</div>
						<div class="form-group">
							<label for="emp_password_confirm">비밀번호 확인</label> 
							<input type="password" id="emp_password_confirm" name="emp_password_confirm" placeholder="비밀번호 확인" required tabindex="4" />
						</div>
					</div>
					<!-- Address, Contact, and Signature Information -->
					<div class="form-section">
						<div class="section-title">주소 정보</div>
						<div class="form-group">
							<label for="home">주소</label>
							<div class="input-with-button">
								<input type="text" id="home" name="home" placeholder="주소" readonly required tabindex="5" /> 
								<input type="button" value="주소찾기" onclick="execDaumPostcode()" tabindex="6" />
							</div>
						</div>
						<div class="form-group">
							<label for="detail_home">상세주소</label> 
							<input type="text" id="detail_home" name="detail_home" placeholder="상세주소 입력" tabindex="7" />
						</div>
						<div class="section-title">연락처 정보</div>
						<div class="form-group">
							<label for="phone_number">전화번호</label> 
							<input type="text" id="phone_number" name="phone_number" placeholder="전화번호" required disabled tabindex="8" />
						</div>
						<div class="form-group">
							<label for="emailCode">이메일 인증번호</label>
							<div class="input-with-button">
								<input type="text" id="emailCode" placeholder="인증번호 입력" tabindex="9" /> 
								<input type="button" value="인증확인" onclick="checkVerificationCode()" tabindex="10" />
							</div>
						</div>
						<div class="section-title">서명 정보</div>
						<div class="form-group">
							<label for="signatureCanvas">서명</label>
							<canvas id="signatureCanvas" width="300" height="100"></canvas>
							<div class="signature-buttons">
								<input type="button" value="지우기" onclick="clearSignature()" tabindex="11" /> 
								<input type="button" value="저장" onclick="saveSignature()" tabindex="12" />
							</div>
							<input type="hidden" id="signatureData" name="signatureData" />
						</div>
					</div>
				</div>
				<button type="submit" id="submitBtn" disabled tabindex="13">가입 완료</button>
			</form>
			<div class="login-link">
				이미 계정이 있으신가요? <a href="/login">로그인</a>
			</div>
		</div>
	</main>
	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

	<script>
	// Signature Canvas Setup
    const canvas = document.getElementById('signatureCanvas');
    const ctx = canvas.getContext('2d');
    let isDrawing = false;
    let lastX = 0;
    let lastY = 0;

    // Set canvas drawing properties
    ctx.strokeStyle = '#000';
    ctx.lineWidth = 2;
    ctx.lineCap = 'round';

    // Mouse Events
    canvas.addEventListener('mousedown', startDrawing);
    canvas.addEventListener('mousemove', draw);
    canvas.addEventListener('mouseup', stopDrawing);
    canvas.addEventListener('mouseout', stopDrawing);

    // Touch Events
    canvas.addEventListener('touchstart', (e) => {
        e.preventDefault();
        const touch = e.touches[0];
        const rect = canvas.getBoundingClientRect();
        lastX = touch.clientX - rect.left;
        lastY = touch.clientY - rect.top;
        isDrawing = true 
    });

    canvas.addEventListener('touchmove', (e) => {
        e.preventDefault();
        if (!isDrawing) return;
        const touch = e.touches[0];
        const rect = canvas.getBoundingClientRect();
        const x = touch.clientX - rect.left;
        const y = touch.clientY - rect.top;
        ctx.beginPath();
        ctx.moveTo(lastX, lastY);
        ctx.lineTo(x, y);
        ctx.stroke();
        lastX = x;
        lastY = y;
    });

    canvas.addEventListener('touchend', () => {
        isDrawing = false;
    });

    function startDrawing(e) {
        isDrawing = true;
        const rect = canvas.getBoundingClientRect();
        lastX = e.clientX - rect.left;
        lastY = e.clientY - rect.top;
    }

    function draw(e) {
        if (!isDrawing) return;
        const rect = canvas.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        ctx.beginPath();
        ctx.moveTo(lastX, lastY);
        ctx.lineTo(x, y);
        ctx.stroke();
        lastX = x;
        lastY = y;
    }

    function stopDrawing() {
        isDrawing = false;
    }

    function clearSignature() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        document.getElementById('signatureData').value = '';
    }

    function saveSignature() {
        const dataUrl = canvas.toDataURL('image/png');
        document.getElementById('signatureData').value = dataUrl;
        showError("서명이 저장되었습니다.");
        setTimeout(hideError, 3000);
    }

    // Form Validation
    function checkForm() {
        const emp_name = document.getElementById('emp_name').value.trim();
        const emp_email = document.getElementById('emp_email').value.trim();
        const emp_password = document.getElementById('emp_password').value.trim();
        const emp_password_confirm = document.getElementById('emp_password_confirm').value.trim();
        const home = document.getElementById('home').value.trim();
        const phone_number = document.getElementById('phone_number').value.trim();
        const signatureData = document.getElementById('signatureData').value;
        const errorBox = document.getElementById('error-message');

        if (!emp_name || !emp_email || !emp_password || !emp_password_confirm || !home || !phone_number || !signatureData) {
            showError("모든 필수 항목을 입력하고 서명을 저장해주세요.");
            return false;
        }

        if (emp_password !== emp_password_confirm) {
            showError("비밀번호가 일치하지 않습니다.");
            return false;
        }

        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
        const phonePattern = /^\d{10,11}$/;
        const namePattern = /^[가-힣]{2,10}$/;

        if (!namePattern.test(emp_name)) {
            showError("이름은 한글 2~10자여야 합니다.");
            return false;
        }

        if (!emailPattern.test(emp_email)) {
            showError("유효한 이메일 주소를 입력해주세요.");
            return false;
        }

        if (!passwordPattern.test(emp_password)) {
            showError("비밀번호는 영문자와 숫자 조합으로 최소 8자 이상이어야 합니다.");
            return false;
        }

        if (!phonePattern.test(phone_number)) {
            showError("유효한 전화번호를 입력해주세요 (10~11자리 숫자).");
            return false;
        }

        hideError();
        return true;
    }

    function showError(message) {
        const errorBox = document.getElementById('error-message');
        if (errorBox) {
            errorBox.textContent = message;
            errorBox.classList.add('show');
        }
    }

    function hideError() {
        const errorBox = document.getElementById('error-message');
        if (errorBox) {
            errorBox.textContent = '';
            errorBox.classList.remove('show');
        }
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                const fullAddr = data.address;
                document.getElementById('home').value = fullAddr;
            }
        }).open();
    }

    function sendVerificationCode() {
        const email = document.getElementById('emp_email').value.trim();
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(email)) {
            showError("유효한 이메일 주소를 입력해주세요.");
            return;
        }
        showError("인증번호가 이메일로 전송되었습니다.");
        setTimeout(hideError, 3000);
    }

    function checkVerificationCode() {
        const code = document.getElementById('emailCode').value.trim();
        if (!code) {
            showError("인증번호를 입력해주세요.");
            return;
        }
        document.getElementById('phone_number').disabled = false;
        showError("인증이 완료되었습니다.");
        document.getElementById('submitBtn').disabled = false;
        setTimeout(hideError, 3000);
    }
	</script>
</body>
</html>