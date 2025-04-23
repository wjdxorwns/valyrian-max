<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="3부창조 로그인 - 안전하고 간편한 비즈니스 플랫폼에 접속하세요.">
    <title>3부창조 - 로그인</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Roboto', sans-serif;
        } /* 기본 스타일 초기화 */

        body, html {
            height: 100vh;
            background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), 
                url('https://images.unsplash.com/photo-1608889175626-2a2f464f2130');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            color: #fff;
        } /* 전체 페이지 레이아웃 설정 */

        /* Header */
        header {
            background-color: #87ceeb;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        } /* 헤더 스타일 정의 */

        .logo a {
            color: #fff;
            text-decoration: none;
            font-size: 1.8rem;
            font-weight: 700;
        } /* 로고 스타일 */

        .nav-links {
            display: flex;
            gap: 1.5rem;
        } /* 네비게이션 링크 컨테이너 */

        .nav-links a {
            color: #fff;
            text-decoration: none;
            font-size: 1rem;
            padding: 0.5rem 1rem;
            transition: all 0.3s ease;
        } /* 네비게이션 링크 스타일 */

        .nav-links a:hover {
            background-color: #6ab7d5;
            border-radius: 4px;
        } /* 네비게이션 링크 호버 효과 */

        /* Main Content */
        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        } /* 메인 콘텐츠 레이아웃 */

        .login-wrapper {
            display: flex;
            max-width: 960px;
            width: 100%;
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
        } /* 로그인 창 컨테이너 */

        .branding-section {
            flex: 1;
            background: linear-gradient(135deg, #87ceeb, #6ab7d5);
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: #fff;
        } /* 브랜딩 섹션 스타일 */

        .branding-section img {
            width: 80px;
            margin-bottom: 1rem;
            filter: brightness(0) invert(1);
        } /* 브랜딩 섹션 로고 이미지 */

        .branding-section h2 {
            font-size: 2rem;
            margin-bottom: 1rem;
        } /* 브랜딩 섹션 제목 */

        .branding-section p {
            font-size: 1.1rem;
            line-height: 1.5;
            color: #e0f4ff;
        } /* 브랜딩 섹션 설명 텍스트 */

        .login-section {
            flex: 1;
            padding: 3rem;
            background-color: #fff;
            color: #333;
        } /* 로그인 폼 섹션 */

        .login-section h3 {
            font-size: 1.8rem;
            margin-bottom: 2rem;
            text-align: center;
            color: #333;
        } /* 로그인 섹션 제목 */

        .error-message {
            display: none;
            color: #fff;
            background-color: #ff6b6b;
            padding: 0.75rem;
            border-radius: 4px;
            margin-bottom: 1rem;
            font-size: 0.9rem;
            text-align: center;
        } /* 에러 메시지 스타일 */

        .error-message.show {
            display: block;
        } /* 에러 메시지 표시 스타일 */

        .form-group {
            margin-bottom: 1.5rem;
        } /* 폼 입력 그룹 스타일 */

        .form-group label {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            border: 0;
        } /* 접근성을 위한 숨김 라벨 */

        input[type="email"], input[type="password"] {
            width: 100%;
            padding: 0.85rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: #f9f9f9;
        } /* 이메일 및 비밀번호 입력 필드 */

        input[type="email"]:focus, input[type="password"]:focus {
            outline: none;
            border-color: #87ceeb;
            box-shadow: 0 0 8px rgba(135, 206, 235, 0.3);
            background-color: #fff;
        } /* 입력 필드 포커스 효과 */

        .login-btn {
            width: 100%;
            padding: 0.85rem;
            background-color: #1e3a8a;
            color: #fff;
            font-size: 1.1rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        } /* 로그인 버튼 스타일 */

        .login-btn:hover {
            background-color: #172554;
            transform: scale(1.03);
        } /* 로그인 버튼 호버 효과 */

        .forgot-password {
            text-align: right;
            margin: 0.75rem 0;
            font-size: 0.9rem;
        } /* 비밀번호 찾기 링크 스타일 */

        .forgot-password a {
            color: #6ab7d5;
        } /* 비밀번호 찾기 링크 색상 */

        .forgot-password a:hover {
            color: #87ceeb;
            text-decoration: underline;
        } /* 비밀번호 찾기 링크 호버 효과 */

        .signup {
            text-align: center;
            margin: 1.5rem 0;
            font-size: 0.9rem;
            color: #666;
        } /* 회원가입 링크 섹션 */

        .signup a {
            color: #6ab7d5;
        } /* 회원가입 링크 색상 */

        .signup a:hover {
            color: #87ceeb;
            text-decoration: underline;
        } /* 회원가입 링크 호버 효과 */

        .social-login {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        } /* 소셜 로그인 버튼 컨테이너 */

        .social-btn {
            flex: 1;
            padding: 0.75rem;
            border: none;
            border-radius: 8px;
            font-size: 0.9rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            min-width: 120px;
        } /* 소셜 로그인 버튼 스타일 */

        .social-btn:hover {
            transform: scale(1.03);
        } /* 소셜 로그인 버튼 호버 효과 */

        .social-google {
            background-color: #fff;
            color: #333;
            border: 1px solid #ddd;
        } /* 구글 로그인 버튼 스타일 */

        .social-kakao {
            background-color: #FEE500;
            color: #381E1F;
        } /* 카카오 로그인 버튼 스타일 */

        .social-naver {
            background-color: #03C75A;
            color: #fff;
        } /* 네이버 로그인 버튼 스타일 */

        .social-btn img {
            width: 24px;
            height: 24px;
            margin-right: 0.5rem;
        } /* 소셜 로그인 버튼 아이콘 */

        footer {
            padding: 1rem;
            text-align: center;
            font-size: 0.9rem;
            color: #e0f4ff;
            background-color: rgba(0, 0, 0, 0.5);
        } /* 푸터 스타일 */

        footer a {
            color: #e0f4ff;
            text-decoration: none;
        } /* 푸터 링크 스타일 */

        footer a:hover {
            text-decoration: underline;
        } /* 푸터 링크 호버 효과 */

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        } /* 페이드 인 애니메이션 */

        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        } /* 슬라이드 업 애니메이션 */

        .form-group {
            animation: slideUp 0.5s ease-out forwards;
            animation-delay: calc(0.1s * var(--order));
        } /* 폼 그룹 애니메이션 */
    </style>
</head>
<body>
    <header>
        <div class="logo"><a href="/">3부상조</a></div> <!-- 로고 -->
        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/notice">공지사항</a> <!-- 공지사항 링크 -->
            <a href="${pageContext.request.contextPath}/signup">회원가입</a> <!-- 회원가입 링크 -->
            <a href="#">개인정보</a> <!-- 개인정보 링크 -->
        </nav>
    </header>
    <main>
        <div class="login-wrapper">
            <div class="branding-section">
                <img src="https://cdn-icons-png.flaticon.com/512/709/709579.png" alt="3부창조 로고" /> <!-- 브랜딩 로고 -->
                <h2>3부창조에 오신 것을 환영합니다</h2> <!-- 브랜딩 제목 -->
                <p>안전하고 간편한 비즈니스 플랫폼으로, 당신의 성공을 함께 만들어갑니다.</p> <!-- 브랜딩 설명 -->
            </div>
            <div class="login-section">
                <h3>로그인</h3> <!-- 로그인 제목 -->
                <div class="error-message ${not empty error ? 'show' : ''}" id="error-message">${error}</div> <!-- 에러 메시지 -->
                <form name="loginForm" onsubmit="return validateForm()" action="${pageContext.request.contextPath}/login" method="post">
                    <div class="form-group" style="--order: 1;">
                        <label for="emp_email">이메일</label> <!-- 이메일 라벨 -->
                        <input type="email" id="emp_email" name="emp_email" placeholder="이메일" required tabindex="1" /> <!-- 이메일 입력 -->
                    </div>
                    <div class="form-group" style="--order: 2;">
                        <label for="emp_password">비밀번호</label> <!-- 비밀번호 라벨 -->
                        <input type="password" id="emp_password" name="emp_password" placeholder="비밀번호" required tabindex="2" /> <!-- 비밀번호 입력 -->
                    </div>
                    <div class="forgot-password">
                        <a href="#">비밀번호를 잊으셨나요?</a> <!-- 비밀번호 찾기 링크 -->
                    </div>
                    <div class="form-group" style="--order: 3;">
                        <button type="submit" class="login-btn" tabindex="3">로그인</button> <!-- 로그인 버튼 -->
                    </div>
                </form>
                <div class="signup">
                    계정이 없으신가요? <a href="${pageContext.request.contextPath}/signup">회원가입</a> <!-- 회원가입 링크 -->
                </div>
                <div class="social-login">
                    <button class="social-btn social-google" tabindex="4">
                        <img src="https://cdn-icons-png.flaticon.com/512/281/281764.png" alt="Google 아이콘" /> Google <!-- 구글 로그인 버튼 -->
                    </button>
                    <button class="social-btn social-kakao" tabindex="5">
                        <img src="https://cdn-icons-png.flaticon.com/512/2111/2111493.png" alt="Kakao 아이콘" /> Kakao <!-- 카카오 로그인 버튼 -->
                    </button>
                    <button class="social-btn social-naver" tabindex="6">
                        <img src="https://cdn-icons-png.flaticon.com/512/2175/2175377.png" alt="Naver 아이콘" /> Naver <!-- 네이버 로그인 버튼 -->
                    </button>
                </div>
            </div>
        </div>
    </main>
    <footer>
        <p>© 2025 3부창조. <a href="#">개인정보처리방침</a> | <a href="#">고객 지원</a></p> <!-- 푸터 콘텐츠 -->
    </footer>

    <script>
        function validateForm() {
            const email = document.getElementById("emp_email").value;
            const password = document.getElementById("emp_password").value;
            const errorMessage = document.getElementById("error-message");

            if (!email || !password) {
                errorMessage.textContent = "이메일과 비밀번호를 모두 입력해주세요.";
                errorMessage.classList.add("show");
                return false;
            }

            // Basic email format validation
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                errorMessage.textContent = "유효한 이메일 형식을 입력해주세요.";
                errorMessage.classList.add("show");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>