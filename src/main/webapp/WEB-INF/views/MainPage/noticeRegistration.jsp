<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 등록 - 3부상조</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Roboto', sans-serif;
            line-height: 1.6;
            background-color: #f0f8ff;
            color: #333;
        }
        main {
            max-width: 1200px;
            margin: 90px auto 2rem;
            padding: 0 2rem;
        }
        .notice-form {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            animation: slideUp 0.8s ease-out;
        }
        .notice-form h1 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 1.5rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            display: block;
            font-size: 1rem;
            color: #333;
            margin-bottom: 0.5rem;
            font-weight: 700;
        }
        .form-group input[type="text"],
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
            font-family: 'Roboto', sans-serif;
        }
        .form-group textarea {
            height: 200px;
            resize: vertical;
        }
        .form-group input[type="file"] {
            padding: 0.5rem 0;
        }
        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-top: 2rem;
        }
        .action-buttons button {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        .submit-btn {
            background-color: #6ab7d5;
            color: #fff;
        }
        .submit-btn:hover {
            background-color: #5aa0c2;
        }
        .cancel-btn {
            background-color: #ccc;
            color: #333;
        }
        .cancel-btn:hover {
            background-color: #bbb;
        }
        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
    </style>
</head>
<body>
    <jsp:include page="/resources/jsp/Header.jsp" />
    <main>
        <section class="notice-form">
            <h1>공지사항 등록</h1>
            <form action="${pageContext.request.contextPath}/notice/register" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" required placeholder="공지사항 제목을 입력하세요">
                </div>
                <div class="form-group">
                    <label for="importance">중요도</label>
                    <select id="importance" name="importance" required>
                        <option value="일반">일반</option>
                        <option value="중요">중요</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" name="content" required placeholder="공지사항 내용을 입력하세요"></textarea>
                </div>
                <div class="form-group">
                    <label for="image">이미지 업로드</label>
                    <input type="file" id="image" name="image" accept="image/*">
                </div>
                <div class="action-buttons">
                    <button type="submit" class="submit-btn">등록</button>
                    <button type="button" class="cancel-btn" onclick="window.location.href='${pageContext.request.contextPath}/notice'">취소</button>
                </div>
            </form>
        </section>
    </main>
    <jsp:include page="/resources/jsp/Footer.jsp" />
</body>
</html>