<!-- 최성현 -->


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="3부상조 공지사항 등록 - 관리자용 공지사항 작성 페이지">
    <title>3부상조 - 공지사항 등록</title>
        <!-- CSS 경로 지정: Header, Footer 스타일 -->
    <link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
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

        /* Register Form */
        .register-form {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            animation: slideUp 0.8s ease-out;
        } /* 공지사항 등록 폼 스타일 */

        .register-form h1 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 1.5rem;
        } /* 폼 제목 스타일 */

        .form-group {
            margin-bottom: 1.5rem;
        } /* 폼 그룹 스타일 */

        .form-group label {
            display: block;
            font-size: 1rem;
            color: #333;
            margin-bottom: 0.5rem;
            font-weight: 500;
        } /* 라벨 스타일 */

        .form-group input[type="text"],
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
            font-family: 'Roboto', sans-serif;
        } /* 입력 필드 스타일 */

        .form-group textarea {
            min-height: 250px;
            resize: vertical;
        } /* 텍스트 영역 스타일 */

        .form-group input[type="file"] {
            padding: 0.5rem 0;
        } /* 파일 입력 스타일 */

        .form-group select {
            appearance: none;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="6"><path fill="%23333" d="M0 0h12L6 6z"/></svg>') no-repeat right 0.75rem center/12px 6px;
            padding-right: 2rem;
        } /* 셀렉트 박스 스타일 */

        .form-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: flex-end;
        } /* 버튼 컨테이너 스타일 */

        .form-buttons button {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.3s ease;
        } /* 버튼 기본 스타일 */

        .submit-btn {
            background-color: #87ceeb;
            color: #fff;
        } /* 등록 버튼 스타일 */

        .submit-btn:hover {
            background-color: #6ab7d5;
        } /* 등록 버튼 호버 효과 */

        .cancel-btn {
            background-color: #ccc;
            color: #333;
        } /* 취소 버튼 스타일 */

        .cancel-btn:hover {
            background-color: #bbb;
        } /* 취소 버튼 호버 효과 */

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
    </header>

    <!-- Main Content -->
    <main>
        <section class="register-form">
            <h1>공지사항 등록</h1> <!-- 폼 제목 -->
            <form id="noticeForm" enctype="multipart/form-data" onsubmit="submitNotice(event)">
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" required placeholder="공지사항 제목을 입력하세요">
                </div>
                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" name="content" required placeholder="공지사항 내용을 입력하세요"></textarea>
                </div>
                <div class="form-group">
                    <label for="importance">우선순위</label>
                    <select id="importance" name="importance">
                        <option value="일반">일반</option>
                        <option value="중요">중요</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="f_name">이미지 업로드</label>
                    <input type="file" id="f_name" name="f_name" accept="image/*">
                </div>
                <div class="form-buttons">
                    <button type="submit" class="submit-btn">등록</button>
                    <button type="button" class="cancel-btn" onclick="window.location.href='${pageContext.request.contextPath}/notice'">취소</button>
                </div>
            </form>
        </section>
    </main>

    <script>
        // Form submission with AJAX
        function submitNotice(event) {
            event.preventDefault();
            const form = document.getElementById('noticeForm');
            const formData = new FormData(form);

            fetch('${pageContext.request.contextPath}/addNotice', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('공지사항이 성공적으로 등록되었습니다.');
                    window.location.href = '${pageContext.request.contextPath}/notice';
                } else {
                    alert('공지사항 등록에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다.');
            });
        } /* 공지사항 등록 기능 */
    </script>
</body>
</html>