<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <!-- 폰트 로드 -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- CSS 파일 링크 -->
    <link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">

<!-- 페이지 전반적인 스타일 -->
<style type="text/css">
/* Font */
@font-face {
    font-family: "Noto Sans Kr";
    font-weight: 100;
    font-style: normal;
    src: url("../fonts/NotoSans-Thin.eot") format("eot"),
        url("../fonts/NotoSans-Thin.otf") format("opentype"),
        url("../fonts/NotoSans-Thin.woff") format("woff"),
        url("../fonts/NotoSans-Thin.woff2") format("woff2");
}

@font-face {
    font-family: "Noto Sans Kr";
    font-weight: 200;
    font-style: normal;
    src: url("../fonts/NotoSans-Light.eot") format("eot"),
        url("../fonts/NotoSans-Light.otf") format("opentype"),
        url("../fonts/NotoSans-Light.woff") format("woff"),
        url("../fonts/NotoSans-Light.woff2") format("woff2");
}

@font-face {
    font-family: "Noto Sans Kr";
    font-weight: 300;
    font-style: normal;
    src: url("../fonts/NotoSans-Medium.eot") format("eot"),
        url("../fonts/NotoSans-Medium.otf") format("opentype"),
        url("../fonts/NotoSans-Medium.woff") format("woff"),
        url("../fonts/NotoSans-Medium.woff2") format("woff2");
}

/* 공통 스타일 */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans Kr', 'Roboto', sans-serif;
    line-height: 1.6;
    background-color: #f5f7fa;
    color: #333;
}

.clearfix::after {
    content: '';
    display: block;
    clear: both;
}

/* 레이아웃 */
.wrap {
    position: relative;
    width: 100%;
    min-width: 1280px;
}

.container {
    position: relative;
    width: 100%;
    max-width: 1280px;
    margin: 0 auto;
    padding: 0 30px;
}

.content {
    position: relative;
    min-height: 100vh;
    padding-top: 80px;
    padding-bottom: 150px;
}

/* Visual Section */
.visual {
    position: relative;
    height: 600px;
    background: linear-gradient(120deg, #4386cc 0%, #54b7d6 98%),
        url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80')
        no-repeat center center/cover;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
}

.visual .txt-box {
    text-align: center;
}

.visual .txt-main {
    position: relative;
    margin-bottom: 40px;
    line-height: 1.2;
    letter-spacing: -0.075em;
    font-weight: 200;
    font-size: 60px;
}

.visual .txt-main span {
    font-weight: 200;
}

.visual .txt-main::after {
    content: '';
    position: absolute;
    left: 50%;
    bottom: -20px;
    margin-left: -13px;
    width: 26px;
    height: 1px;
    background-color: rgba(255, 255, 255, 0.5);
}

.visual .txt-sub {
    line-height: 1.5;
    letter-spacing: -0.05em;
    font-weight: 100;
    font-size: 22px;
}

.visual .strong {
    display: block;
}

/* Shortcut Section */
.shortcut {
    margin-top: -100px;
    position: relative;
    z-index: 99;
}

.shortcut .container {
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}

.shortcut .shortcut-list {
    display: flex;
    justify-content: space-between;
    align-items: stretch;
    list-style: none; /* 불릿 제거 */
}

.shortcut .shortcut-list li {
    flex: 1;
    position: relative;
}

.shortcut-list a {
    position: relative;
    padding: 40px 30px;
    height: 220px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    border-right: 1px solid #e0e5eb;
    transition: transform 0.3s ease, box-shadow 0.3s ease, background-color 0.3s ease;
    text-decoration: none;
    color: #333;
}

.shortcut-list li:last-child a {
    border-right: none;
}

.shortcut-list a:hover {
    transform: translateY(-5px);
    background-color: #f8fafc;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
}

.shortcut .txt-main {
    margin-bottom: 20px;
    font-weight: 400;
    letter-spacing: -0.05em;
    font-size: 24px;
    color: #1a2b49;
    transition: color 0.3s ease;
}

.shortcut-list a:hover .txt-main {
    color: #003399;
}

.shortcut .txt-sub {
    line-height: 1.6;
    letter-spacing: -0.03em;
    font-size: 15px;
    color: #5a6a85;
}

.shortcut .img-box {
    position: absolute;
    right: 20px;
    bottom: 20px;
    width: 48px;
    height: 48px;
    background-color: transparent;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: transform 0.3s ease;
}

.shortcut .img-box::before {
    content: '\f054';
    font-family: 'Font Awesome 5 Free';
    font-weight: 900;
    font-size: 18px;
    color: #003399;
    transition: color 0.3s ease;
}

.shortcut-list a:hover .img-box {
    transform: scale(1.1);
}

.shortcut-list a:hover .img-box::before {
    color: #4386cc;
}

/* Article General Styles */
.article {
    padding: 80px 0;
}

.article .txt-box, .article .graphic-box {
    float: left;
}

.article .txt-box {
    width: 30%;
}

.article .graphic-box {
    width: 70%;
}

.article .txt-main {
    margin-bottom: 20px;
    font-weight: 300;
    letter-spacing: -0.065em;
    font-size: 40px;
    color: #000;
}

.article .txt-sub {
    line-height: 1.5;
    letter-spacing: -0.065em;
    font-size: 18px;
    color: #666;
}

.article .txt-sub2 {
    display: block;
    margin-bottom: 10px;
    font-weight: 100;
    letter-spacing: -0.065em;
    font-size: 18px;
    color: #000;
}

.article .txt-sub3 {
    display: block;
    padding-top: 20px;
    font-size: 16px;
    color: #666;
    letter-spacing: -0.065em;
}

/* Recent Posts Section */
.recent-posts {
    background-color: #fff;
}

.recent-posts .graphic-box {
    padding-left: 40px;
}

.recent-posts .post-list {
    list-style: none;
}

.recent-posts .post-item {
    position: relative;
    padding: 20px 0;
    border-bottom: 1px solid #e5e5e5;
}

.recent-posts .post-item:last-child {
    border-bottom: none;
}

.recent-posts .post-item a {
    text-decoration: none;
    color: #333;
    display: block;
}

.recent-posts .post-item:hover a {
    color: #003399;
}

.recent-posts .post-title {
    font-weight: 300;
    font-size: 20px;
    letter-spacing: -0.05em;
    margin-bottom: 10px;
}

.recent-posts .post-meta {
    font-weight: 200;
    font-size: 14px;
    color: #666;
    letter-spacing: -0.05em;
}

.recent-posts .post-meta span {
    margin-right: 15px;
}

/* Info Step Section */
.info-step {
    background-color: #f5f7fa;
}

.info-step .graphic-box {
    padding-left: 40px;
}

.info-step .div-step {
    position: relative;
    float: left;
    width: 25%;
    text-align: center;
}

.info-step .div-step::after {
    content: '';
    position: absolute;
    right: 0;
    top: 50%;
    margin-top: -16px;
    width: 15px;
    height: 32px;
    background: url('../images/common/icon/icon-arrow-right.png') no-repeat;
}

.info-step .div-step:last-child::after {
    display: none;
}

.info-step .step-txt {
    margin-bottom: 20px;
    line-height: 1.5;
    letter-spacing: -0.025em;
    font-size: 14px;
    color: #003399;
}

.info-step .step-num {
    display: block;
    font-weight: 400;
    font-size: 24px;
}

.info-step .step-txt-sub {
    line-height: 1.5;
    font-weight: 300;
    letter-spacing: -0.075em;
    font-size: 16px;
    color: #222;
}

/* Company Info Section (Info How Section 대체) */
.company-info {
    background-color: #fff;
}

.company-info .graphic-box {
    padding-left: 40px;
}

.company-info .info-details {
    margin-bottom: 30px;
}

.company-info .info-details p {
    font-weight: 300;
    font-size: 16px;
    letter-spacing: -0.05em;
    color: #333;
    margin-bottom: 10px;
}

.company-info .info-details p strong {
    font-weight: 400;
    color: #003399;
}

.company-info .map-container {
    position: relative;
    width: 100%;
    height: 300px;
    border-radius: 10px;
    overflow: hidden;
    -webkit-box-shadow: 0px 1px 10px 1px rgba(0, 0, 0, 0.1);
    -moz-box-shadow: 0px 1px 10px 1px rgba(0, 0, 0, 0.1);
    box-shadow: 0px 1px 10px 1px rgba(0, 0, 0, 0.1);
}

.company-info .map-container iframe {
    width: 100%;
    height: 100%;
    border: none;
}
</style>
</head>
<body>
    <div class="wrap">
        <!-- Header -->
        <jsp:include page="/resources/jsp/Header.jsp" />

        <!-- Content -->
        <div class="content">
            <!-- Visual Section -->
            <div class="visual">
                <div class="container">
                    <div class="txt-box">
                        <h2 class="txt-main">
                            3부상조<span class="strong">비즈니스 플랫폼</span>
                        </h2>
                        <p class="txt-sub">
                            혁신적인 솔루션으로<br>당신의 비즈니스를 성장시키세요.
                        </p>
                    </div>
                </div>
            </div>

            <!-- Shortcut Section -->
            <div class="shortcut">
                <div class="container">
                    <ul class="shortcut-list clearfix">
                        <li class="shortcut-list-item"><a href="">
                                <h3 class="txt-main">시작하기</h3>
                                <p class="txt-sub">
                                    3부상조 플랫폼 테스트를 시작하기 위해<br> 계정을 등록하고 서비스를 경험하세요.
                                </p>
                                <p class="img-box">
                                    <span class="screen-hidden"></span>
                                </p>
                        </a></li>
                        <li class="shortcut-list-item"><a href="">
                                <h3 class="txt-main">출, 퇴근 관리</h3>
                                <p class="txt-sub">
                                    출근과 퇴근 시간을<br> 실시간으로 보고 편하게 등록하세요.
                                </p>
                                <p class="img-box">
                                    <span class="screen-hidden"></span>
                                </p>
                        </a></li>
                        <li class="shortcut-list-item"><a href="">
                                <h3 class="txt-main">전자 결제</h3>
                                <p class="txt-sub">
                                    손쉽고 간편하게<br> 승인 요청을 넣어보세요.
                                </p>
                                <p class="img-box">
                                    <span class="screen-hidden"></span>
                                </p>
                        </a></li>
                        <li class="shortcut-list-item"><a
                            href="">
                                <h3 class="txt-main">게시판</h3>
                                <p class="txt-sub">
                                    자유롭게 하고싶은 얘기나<br> 올리고싶은 파일을 올려보세요
                                </p>
                                <p class="img-box">
                                    <span class="screen-hidden"></span>
                                </p>
                        </a></li>
                    </ul>
                </div>
            </div>

            <!-- Recent Posts Section -->
            <div class="article recent-posts">
                <div class="container clearfix">
                    <div class="txt-box">
                        <span class="txt-sub2">최근 소식</span>
                        <h3 class="txt-main">게시판 업데이트</h3>
                        <p class="txt-sub">3부상조 게시판의 최신 글을 확인하세요.</p>
                        <span class="txt-sub3">최신 업데이트: 2025/04/24 00:00</span>
                    </div>
                    <div class="graphic-box clearfix">
                        <ul class="post-list">
                            <li class="post-item"><a
                                href="${pageContext.request.contextPath}/board/1">
                                    <h4 class="post-title">2025년 상반기 워크숍 안내</h4>
                                    <p class="post-meta">
                                        <span>작성자: 김관리</span> <span>작성일: 2025/04/23</span>
                                    </p>
                            </a></li>
                            <li class="post-item"><a
                                href="${pageContext.request.contextPath}/board/2">
                                    <h4 class="post-title">급여 관리 시스템 업데이트 공지</h4>
                                    <p class="post-meta">
                                        <span>작성자: 박인사</span> <span>작성일: 2025/04/22</span>
                                    </p>
                            </a></li>
                            <li class="post-item"><a
                                href="${pageContext.request.contextPath}/board/3">
                                    <h4 class="post-title">휴가 신청 프로세스 변경 안내</h4>
                                    <p class="post-meta">
                                        <span>작성자: 이인사</span> <span>작성일: 2025/04/20</span>
                                    </p>
                            </a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Info Step Section -->
            <div class="article info-step">
                <div class="container clearfix">
                    <div class="txt-box">
                        <span class="txt-sub2">3부상조</span>
                        <h3 class="txt-main">이용 절차</h3>
                        <p class="txt-sub">
                            간단한 절차로<br> 3부상조의 모든 서비스를<br> 이용할 수 있습니다.
                        </p>
                    </div>
                    <div class="graphic-box clearfix">
                        <div class="div-step">
                            <p class="step-txt">
                                STEP<span class="step-num">01</span>
                            </p>
                            <p class="step-icon">
                                <img src="resources/image/icons8-로그인-50.png" alt="">
                            </p>
                            <p class="step-txt-sub">
                                3부상조 플랫폼에 로그인 및<br> 계정 등록
                            </p>
                        </div>
                        <div class="div-step">
                            <p class="step-txt">
                                STEP<span class="step-num">02</span>
                            </p>
                            <p class="step-icon">
                                <img src="resources/image/icons8-서비스-50.png" alt="">
                            </p>
                            <p class="step-txt-sub">
                                서비스 테스트 및<br> 기능 확인
                            </p>
                        </div>
                        <div class="div-step">
                            <p class="step-txt">
                                STEP<span class="step-num">03</span>
                            </p>
                            <p class="step-icon">
                                <img src="resources/image/icons8-문서-서명-50.png" alt="">
                            </p>
                            <p class="step-txt-sub">
                                3부상조 서비스<br> 약정 체결
                            </p>
                        </div>
                        <div class="div-step">
                            <p class="step-txt">
                                STEP<span class="step-num">04</span>
                            </p>
                            <p class="step-icon">
                                <img src="resources/image/icons8-적용-스킨-타입-7-48.png" alt="">
                            </p>
                            <p class="step-txt-sub">
                                운영 환경 적용 및<br> 서비스 시작
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Company Info Section -->
            <div class="article company-info">
                <div class="container clearfix">
                    <div class="txt-box">
                        <span class="txt-sub2">회사 정보</span>
                        <h3 class="txt-main">3부상조를 찾아오세요</h3>
                        <p class="txt-sub">당신의 비즈니스 파트너, 3부상조의 위치를 확인하세요.</p>
                    </div>
                    <div class="graphic-box clearfix">
                        <div class="info-details">
                            <p>
                                <strong>회사명:</strong> 3부상조 주식회사
                            </p>
                            <p>
                                <strong>주소:</strong> 서울특별시 마포구 백범로 23, 3층 (신수동, 케이터틀)
                            </p>
                            <p>
                                <strong>전화번호:</strong> 02-1234-5678
                            </p>
                            <p>
                                <strong>이메일:</strong> contact@3busangjo.com
                            </p>
                        </div>
                        <div class="map-container">
                            <iframe
                                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.803744693673!2d126.93840231521123!3d37.54999397980272!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357c989d7c7e8b8b%3A0x9f5c8e2b5d9e6f1!2z7ISc7Jq47Yq567OE7IucIOyCrOyaqeygnOq1rCDrsLDsmrXroZwzMe2DkywgM-yKpO2DhOybkA!5e0!3m2!1sko!2skr!4v1698771234567!5m2!1sko!2skr"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="/resources/jsp/Footer.jsp" />
    </div>
</body>
</html>