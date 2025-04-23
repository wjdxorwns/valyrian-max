<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="3부상조 - 당신의 비즈니스 파트너로 차별화된 서비스와 지원을 제공합니다.">
    <title>3부상조 - 메인 페이지</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="<c:url value="/resources/css/Header.css" />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">

    <style type="text/css">
        /* Reset default styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            line-height: 1.6;
            background-color: #f0f8ff; /* Light sky blue background */
            color: #333;
        }

        /* Hero Section */
        .hero-section {
            position: relative;
            height: 80vh;
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: #fff;
            animation: fadeIn 1s ease-out;
        }

        .hero-content {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 3rem 4rem;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            max-width: 700px;
            animation: slideUp 0.8s ease-out;
        }

        .hero-content h1 {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 1rem;
        }

        .hero-content p {
            font-size: 1.2rem;
            color: #666;
            margin-bottom: 2rem;
        }

        .hero-content .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background-color: #87ceeb;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            margin: 0.5rem;
            transition: all 0.3s ease;
        }

        .hero-content .btn:hover {
            background-color: #6ab7d5;
            transform: scale(1.05);
        }

        .hero-content .btn.secondary {
            background-color: #fff;
            color: #87ceeb;
            border: 1px solid #87ceeb;
        }

        .hero-content .btn.secondary:hover {
            background-color: #e0f4ff;
            color: #6ab7d5;
        }

        /* Features Section */
        .features-section {
            padding: 4rem 2rem;
            background-color: #fff;
            text-align: center;
        }

        .features-section h2 {
            font-size: 2rem;
            margin-bottom: 2rem;
            color: #333;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background-color: #f0f8ff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .feature-card img {
            width: 60px;
            height: 60px;
            margin-bottom: 1rem;
        }

        .feature-card h3 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .feature-card p {
            font-size: 1rem;
            color: #666;
        }

        /* Connection Section (Newsletter Signup) */
        .connection-section {
            background-color: #333;
            padding: 4rem 2rem;
            text-align: center;
            color: #fff;
        }

        .connection-section h2 {
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        .connection-section p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            color: #ccc;
        }

        .newsletter-form {
            display: flex;
            justify-content: center;
            gap: 1rem;
            max-width: 600px;
            margin: 0 auto;
        }

        .newsletter-form input {
            padding: 0.75rem;
            font-size: 1rem;
            border: none;
            border-radius: 4px;
            width: 70%;
            max-width: 400px;
        }

        .newsletter-form button {
            padding: 0.75rem 1.5rem;
            background-color: #87ceeb;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .newsletter-form button:hover {
            background-color: #6ab7d5;
            transform: scale(1.05);
        }

        /* Testimonial Section */
        .testimonial-section {
            padding: 4rem 2rem;
            background-color: #f0f8ff;
            text-align: center;
        }

        .testimonial-section h2 {
            font-size: 2rem;
            margin-bottom: 2rem;
            color: #333;
        }

        .testimonial-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .testimonial-card {
            background-color: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .testimonial-card:hover {
            transform: translateY(-5px);
        }

        .testimonial-card p {
            font-size: 1rem;
            color: #666;
            margin-bottom: 1rem;
            font-style: italic;
        }

        .testimonial-card h4 {
            font-size: 1.2rem;
            color: #333;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .section-animation {
            opacity: 0;
            transform: translateY(20px);
            animation: slideUp 0.8s ease-out forwards;
        }

        /* Responsive Design for Other Sections */
        @media (max-width: 768px) {
            .hero-section {
                height: 60vh;
            }

            .hero-content {
                padding: 2rem;
            }

            .hero-content h1 {
                font-size: 1.8rem;
            }

            .hero-content p {
                font-size: 1rem;
            }

            .features-section, .connection-section, .testimonial-section {
                padding: 2rem 1rem;
            }

            .newsletter-form {
                flex-direction: column;
                align-items: center;
            }

            .newsletter-form input {
                width: 100%;
            }

            .newsletter-form button {
                width: 100%;
                max-width: 200px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div id="logo"><a href="/">3부상조</a></div>
        <nav>
            <ul class="nav-menu">
                <li><a href="#">공지사항</a></li>
                <li><a href="login">로그인</a></li>
                <li><a href="#">개인정보</a></li>
            </ul>
        </nav>
        <button class="mobile-menu-btn">
            <span></span>
            <span></span>
            <span></span>
        </button>
    </header>

    <!-- Mobile Menu -->
    <nav class="mobile-nav">
        <ul>
            <li><a href="#">공지사항</a></li>
            <li><a href="login">로그인</a></li>
            <li><a href="#">개인정보</a></li>
        </ul>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-content">
            <h1>당신의 성공을 위한 최적의 파트너</h1>
            <p>3부상조는 차별화된 시스템과 신뢰할 수 있는 서비스로<br>비즈니스 성장을 지원합니다.</p>
            <a href="#" class="btn">지금 시작하기</a>
            <a href="#features" class="btn secondary">더 알아보기</a>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section section-animation" id="features">
        <h2>최근 게시글</h2>
        <div class="features-grid">
            <div class="feature-card">
                <img src="https://via.placeholder.com/60x60?text=아이콘" alt="">
                <h3>게시글1</h3>
                <p>내용</p>
            </div>
            <div class="feature-card">
                <img src="https://via.placeholder.com/60x60?text=아이콘" alt="">
                <h3>게시글2</h3>
                <p>내용2</p>
            </div>
            <div class="feature-card">
                <img src="https://via.placeholder.com/60x60?text=아이콘" alt="">
                <h3>게시글3</h3>
                <p>내용3</p>
            </div>
        </div>
    </section>

    <!-- Connection Section (Newsletter Signup) -->
    <section class="connection-section section-animation" id="connection">
        <h2>지금 연결하세요</h2>
        <p>최신 소식과 특별 혜택을 받아보세요!</p>
        <form class="newsletter-form">
            <input type="email" placeholder="이메일을 입력하세요" required>
            <button type="submit">구독하기</button>
        </form>
    </section>

    <!-- Testimonial Section -->
    <section class="testimonial-section section-animation">
        <h2>회사 위치</h2>
    </section>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <ul class="footer-links">
                <li><a href="#">회사소개</a></li>
                <li><a href="#">개인정보처리방침</a></li>
                <li><a href="#">이용약관</a></li>
                <li><a href="#connection">문의하기</a></li>
            </ul>
            <div class="social-icons">
                <a href="#" aria-label="페이스북"><i class="fab fa-facebook-f"></i></a>
                <a href="#" aria-label="트위터"><i class="fab fa-twitter"></i></a>
                <a href="#" aria-label="인스타그램"><i class="fab fa-instagram"></i></a>
            </div>
            <p>© 2025 3부상조. 모든 권리 보유.</p>
        </div>
    </footer>

    <script>
    </script>
</body>
</html>