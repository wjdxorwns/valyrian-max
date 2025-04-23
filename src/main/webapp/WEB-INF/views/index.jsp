<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 메인 페이지</title>
<style type="text/css">
/* Reset default styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Arial', sans-serif;
    line-height: 1.6;
    background-color: #f0f8ff; /* Light sky blue background */
    color: #333;
}

/* Header Styles */
header {
    background-color: #87ceeb; /* Light sky blue theme */
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

#logo a {
    color: #fff;
    text-decoration: none;
    font-size: 1.5rem;
    font-weight: bold;
}

.header-links a {
    color: #fff;
    text-decoration: none;
    margin-left: 1rem;
    font-size: 1rem;
    transition: all 0.3s ease;
}

.header-links a:hover {
    color: #e0f4ff; /* Very light sky blue on hover */
}

/* Hero Section */
.hero-section {
    position: relative;
    height: 70vh;
    background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80') no-repeat center center/cover;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    color: #fff;
}

.hero-content {
    background-color: rgba(255, 255, 255, 0.9);
    padding: 2rem 3rem;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    max-width: 600px;
}

.hero-content h1 {
    font-size: 2rem;
    color: #333;
    margin-bottom: 1rem;
}

.hero-content p {
    font-size: 1.1rem;
    color: #666;
    margin-bottom: 1.5rem;
}

.hero-content .btn {
    display: inline-block;
    padding: 0.75rem 1.5rem;
    background-color: #87ceeb; /* Light sky blue theme */
    color: #fff;
    text-decoration: none;
    border-radius: 4px;
    transition: all 0.3s ease;
}

.hero-content .btn:hover {
    background-color: #6ab7d5; /* Slightly darker sky blue on hover */
}

/* Connection Section */
.connection-section {
    background-color: #333;
    padding: 3rem 2rem;
    text-align: center;
    color: #fff;
}

.connection-section h2 {
    font-size: 1.5rem;
    margin-bottom: 2rem;
}

.connection-box {
    background-color: #555;
    height: 200px;
    max-width: 800px;
    margin: 0 auto;
    border-radius: 8px;
}

/* Footer */
footer {
    background-color: #87ceeb; /* Light sky blue theme */
    padding: 1rem;
    text-align: center;
    color: #fff;
}

footer p {
    font-size: 1rem;
}

/* Responsive Design */
@media (max-width: 768px) {
    header {
        flex-direction: column;
        gap: 1rem;
    }

    .header-links {
        display: flex;
        gap: 1rem;
    }

    .hero-section {
        height: 50vh;
    }

    .hero-content {
        padding: 1.5rem;
    }

    .hero-content h1 {
        font-size: 1.5rem;
    }

    .hero-content p {
        font-size: 1rem;
    }

    .connection-section {
        padding: 2rem 1rem;
    }

    .connection-box {
        height: 150px;
    }
}
</style>
</head>
<body>
    <!-- Header -->
    <header>
        <div id="logo"><a href="/">3부상조</a></div>
        <div class="header-links">
            <a href="#">품목상세</a>
            <a href="login">로그인</a>
            <a href="#">회원가입</a>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-content">
            <h1>차별화된 시스템으로 우수한 서비스를 지원</h1>
            <p>3부상조<br>완벽한 비즈니스 파트너</p>
            <a href="#" class="btn">시작하기</a>
        </div>
    </section>

    <!-- Connection Section -->
    <section class="connection-section">
        <h2>connection</h2>
        <div class="connection-box"></div>
    </section>

    <!-- Footer -->
    <footer>
        <p>푸터</p>
    </footer>
</body>
</html>