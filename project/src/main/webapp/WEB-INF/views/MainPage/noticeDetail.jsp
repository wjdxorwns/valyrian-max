<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세 - 3부상조</title>
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
.notice-detail {
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 2rem;
    animation: slideUp 0.8s ease-out;
}
.notice-detail h1 {
    font-size: 2rem;
    color: #333;
    margin-bottom: 1rem;
}
.notice-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
    font-size: 0.9rem;
    color: #666;
    margin-bottom: 1.5rem;
    border-bottom: 1px solid #eee;
    padding-bottom: 1rem;
}
.notice-meta span {
    display: flex;
    align-items: center;
    gap: 0.3rem;
}
.importance-badge {
    background-color: #ff6b6b;
    color: #fff;
    padding: 0.2rem 0.5rem;
    border-radius: 4px;
    font-size: 0.8rem;
}
.importance-badge.normal {
    background-color: #6ab7d5;
}
.notice-content {
    font-size: 1rem;
    color: #333;
    margin-bottom: 1.5rem;
    line-height: 1.8;
    white-space: pre-wrap;
}
.notice-image {
    max-width: 100%;
    border-radius: 8px;
    margin: 1rem 0;
}
.action-buttons {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
    margin-bottom: 2rem;
}
.action-buttons button, .action-buttons a {
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1rem;
    text-decoration: none;
    transition: all 0.3s ease;
}
.edit-btn {
    background-color: #ffa500;
    color: #fff;
}
.edit-btn:hover {
    background-color: #cc8400;
}
.back-btn {
    background-color: #ccc;
    color: #333;
}
.back-btn:hover {
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

        <section class="notice-detail">
            <h1>${board.title}</h1>
            <div class="notice-meta">
                <span>📧 ${board.username}</span>
                <span>📅 ${board.created_at}</span>
                <span>👁️ ${board.view_count}</span>
                <span class="importance-badge ${board.importance == '중요' ? '' : 'normal'}">${board.importance}</span>
            </div>
            <div class="notice-content">${board.content}</div>
            <c:if test="${not empty board.f_name}">
                <img src="${pageContext.request.contextPath}/Uploads/${board.f_name}" alt="공지사항 이미지" class="notice-image">
            </c:if>
            <div class="action-buttons">
                <c:if test="${not empty sessionScope.user.dept_name and sessionScope.user.dept_name == '슈퍼관리자'}">
                    <a href="${pageContext.request.contextPath}/notice/edit?id=${board.board_id}" class="edit-btn">수정</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/notice" class="back-btn">목록으로</a>
            </div>
        </section>
    </main>
    <jsp:include page="/resources/jsp/Footer.jsp" />
</body>
</html>