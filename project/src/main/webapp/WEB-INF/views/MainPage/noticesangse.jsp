<!-- 최성현 -->


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="3부상조 공지사항 상세 - 공지사항의 세부 내용을 확인하세요.">
    <title>3부상조 - 공지사항 상세</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        } /* 기본 스타일 초기화 */

        body {
            font-family: 'Roboto', sans-serif;
            line-height: 1.6;
            background-color: #f0f8ff; /* Light sky blue background */
            color: #333;
        } /* 전체 페이지 스타일 */

        /* Header */
        header {
            background-color: #87ceeb; /* Light sky blue */
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        } /* 헤더 스타일 정의 */

        #logo a {
            color: #fff;
            text-decoration: none;
            font-size: 1.8rem;
            font-weight: 700;
        } /* 로고 스타일 */

        .nav-menu {
            display: flex;
            list-style: none;
            gap: 1.5rem;
        } /* 네비게이션 메뉴 컨테이너 */

        .nav-menu li a {
            color: #fff;
            text-decoration: none;
            font-size: 1rem;
            padding: 0.5rem 1rem;
            transition: all 0.3s ease;
        } /* 네비게이션 메뉴 링크 스타일 */

        .nav-menu li a:hover {
            background-color: #6ab7d5;
            border-radius: 4px;
        } /* 네비게이션 링크 호버 효과 */
        
        /* Main Content */
        main {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        } /* 메인 콘텐츠 레이아웃 */

        /* Notice Detail */
        .notice-detail {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            animation: slideUp 0.8s ease-out;
        } /* 공지사항 상세 섹션 스타일 */

        .notice-detail h1 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 1rem;
        } /* 공지사항 제목 스타일 */

        .notice-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 1.5rem;
            border-bottom: 1px solid #eee;
            padding-bottom: 1rem;
        } /* 메타 정보 (작성자, 날짜, 조회수, 좋아요) 스타일 */

        .notice-meta span {
            display: flex;
            align-items: center;
            gap: 0.3rem;
        } /* 메타 정보 항목 스타일 */

        .importance-badge {
            background-color: #ff6b6b;
            color: #fff;
            padding: 0.2rem 0.5rem;
            border-radius: 4px;
            font-size: 0.8rem;
        } /* 중요 공지 배지 스타일 */

        .importance-badge.normal {
            background-color: #6ab7d5;
        } /* 일반 공지 배지 스타일 */

        .notice-content {
            font-size: 1rem;
            color: #333;
            margin-bottom: 1.5rem;
            line-height: 1.8;
        } /* 공지사항 본문 스타일 */

        .notice-image {
            max-width: 100%;
            border-radius: 8px;
            margin: 1rem 0;
        } /* 공지사항 이미지 스타일 */

        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-bottom: 2rem;
        } /* 액션 버튼 컨테이너 */

        .action-buttons button {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.3s ease;
        } /* 버튼 기본 스타일 */

        .like-btn {
            background-color: #87ceeb;
            color: #fff;
        } /* 좋아요 버튼 스타일 */

        .like-btn:hover {
            background-color: #6ab7d5;
        } /* 좋아요 버튼 호버 효과 */

        .back-btn {
            background-color: #ccc;
            color: #333;
        } /* 목록으로 버튼 스타일 */

        .back-btn:hover {
            background-color: #bbb;
        } /* 목록으로 버튼 호버 효과 */

        /* Comment Section */
        .comment-section {
            margin-top: 2rem;
            border-top: 1px solid #eee;
            padding-top: 2rem;
        } /* 댓글 섹션 스타일 */

        .comment-section h2 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 1rem;
        } /* 댓글 섹션 제목 스타일 */

        .comment-form {
            margin-bottom: 2rem;
        } /* 댓글 작성 폼 스타일 */

        .comment-form textarea {
            width: 100%;
            min-height: 100px;
            padding: 0.5rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
            resize: vertical;
            margin-bottom: 0.5rem;
        } /* 댓글 입력 textarea 스타일 */

        .comment-form button {
            padding: 0.5rem 1rem;
            background-color: #87ceeb;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.3s ease;
        } /* 댓글 제출 버튼 스타일 */

        .comment-form button:hover {
            background-color: #6ab7d5;
        } /* 댓글 제출 버튼 호버 효과 */

        .comment-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        } /* 댓글 목록 스타일 */

        .comment-item {
            border-bottom: 1px solid #eee;
            padding: 1rem 0;
        } /* 개별 댓글 스타일 */

        .comment-item:last-child {
            border-bottom: none;
        } /* 마지막 댓글의 하단 테두리 제거 */

        .comment-meta {
            display: flex;
            gap: 1rem;
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 0.5rem;
        } /* 댓글 메타 정보 (작성자, 날짜) 스타일 */

        .comment-content {
            font-size: 1rem;
            color: #333;
        } /* 댓글 본문 스타일 */

        /* Animations */
        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        } /* 슬라이드 업 애니메이션 */
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div id="logo"><a href="${pageContext.request.contextPath}/">3부상조</a></div> <!-- 로고 -->
        <nav>
            <ul class="nav-menu">
                <li><a href="${pageContext.request.contextPath}/notice">공지사항</a></li> <!-- 공지사항 링크 -->
                <li><a href="${pageContext.request.contextPath}/login">로그인</a></li> <!-- 로그인 링크 -->
                <li><a href="#">개인정보</a></li> <!-- 개인정보 링크 -->
            </ul>
        </nav>
        <button class="mobile-menu-btn">
            <span></span> <!-- 모바일 메뉴 버튼 라인 -->
            <span></span> <!-- 모바일 메뉴 버튼 라인 -->
            <span></span> <!-- 모바일 메뉴 버튼 라인 -->
        </button>
    </header>

    <!-- Mobile Menu -->
    <nav class="mobile-nav">
        <ul>
            <li><a href="${pageContext.request.contextPath}/notice">공지사항</a></li> <!-- 모바일 공지사항 링크 -->
            <li><a href="${pageContext.request.contextPath}/login">로그인</a></li> <!-- 모바일 로그인 링크 -->
            <li><a href="#">개인정보</a></li> <!-- 모바일 개인정보 링크 -->
        </ul>
    </nav>

    <!-- Main Content -->
    <main>
        <section class="notice-detail">
            <h1>${board.title}</h1> <!-- 게시글 제목 -->
            <div class="notice-meta">
                <span>📧 ${board.emp_email}</span> <!-- 작성자 이메일 -->
                <span>📅 ${board.created_at}</span> <!-- 작성일 -->
                <span>👁️ ${board.view_count}</span> <!-- 조회수 -->
                <span>❤️ ${board.like_count}</span> <!-- 좋아요 수 -->
                <span class="importance-badge ${board.importance == '중요' ? '' : 'normal'}">${board.importance}</span> <!-- 중요도 -->
            </div>
            <div class="notice-content">
                ${board.content} <!-- 게시글 본문 -->
            </div>
            <c:if test="${not empty board.f_name}">
                <img src="${pageContext.request.contextPath}/uploads/${board.f_name}" alt="공지사항 이미지" class="notice-image"> <!-- 게시글 이미지 -->
            </c:if>
            <div class="action-buttons">
                <button class="like-btn" onclick="incrementLike(${board.board_id})">좋아요</button> <!-- 좋아요 버튼 -->
                <button class="back-btn" onclick="window.location.href='${pageContext.request.contextPath}/notice'">목록으로</button> <!-- 목록으로 버튼 -->
            </div>

            <!-- Comment Section -->
            <section class="comment-section">
                <h2>댓글</h2> <!-- 댓글 섹션 제목 -->
                <div class="comment-form">
                    <form id="commentForm" onsubmit="submitComment(event, ${board.board_id})">
                        <textarea name="comment_content" placeholder="댓글을 입력하세요..." required></textarea> <!-- 댓글 입력 -->
                        <button type="submit">댓글 작성</button> <!-- 댓글 제출 버튼 -->
                    </form>
                </div>
                <div class="comment-list">
                    <!-- 댓글 목록 (빈 상태로 유지) -->
                </div>
            </section>
        </section>
    </main>

    <script>
    </script>
</body>
</html>