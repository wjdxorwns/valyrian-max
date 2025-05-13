<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="description" content="3부상조 공지사항 - 최신 소식과 업데이트를 확인하세요.">
<title>3부상조 - 공지사항</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
<style>
/* 기존 스타일 유지 */
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
    margin: 2rem auto;
    padding: 0 2rem;
}
.main-notice {
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-bottom: 2rem;
    overflow: hidden;
    animation: slideUp 0.8s ease-out;
}
.main-notice img {
    width: 100%;
    height: 300px;
    object-fit: cover;
}
.main-notice-content {
    padding: 2rem;
}
.main-notice-content h2 {
    font-size: 2rem;
    color: #333;
    margin-bottom: 1rem;
}
.main-notice-content p {
    font-size: 1rem;
    color: #666;
    margin-bottom: 1rem;
}
.notice-list {
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 1rem;
    animation: slideUp 0.8s ease-out;
}
.notice-list-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
    padding: 0 1rem;
}
.notice-list h2 {
    font-size: 2rem;
    color: #333;
}
.write-post-button {
    background-color: #87ceeb;
    color: #fff;
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 4px;
    font-size: 1rem;
    cursor: pointer;
    transition: background-color 0.3s ease;
}
.write-post-button:hover {
    background-color: #4682b4;
}
.edit-button {
    background-color: #ffa500;
    color: #fff;
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 4px;
    font-size: 0.9rem;
    cursor: pointer;
    transition: background-color 0.3s ease;
}
.edit-button:hover {
    background-color: #cc8400;
}
.notice-item {
    border-bottom: 1px solid #eee;
    padding: 1rem;
    display: flex;
    gap: 1rem;
    transition: background-color 0.3s ease;
    cursor: pointer;
}
.notice-item:last-child {
    border-bottom: none;
}
.notice-item:hover {
    background-color: #f0f8ff;
}
/* 중요 공지사항 스타일 추가 */
.notice-item.important {
    background-color: #fff0f0;
    border-left: 4px solid #ff6b6b;
}
.notice-item.important:hover {
    background-color: #ffe0e0;
}
.notice-item .user-icon {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: #ccc;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    color: #fff;
}
/* 중요 공지의 아이콘 색상 변경 */
.notice-item.important .user-icon {
    background-color: #ff6b6b;
}
.notice-item .content-wrapper {
    flex: 1;
}
.notice-item .user-info {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0.5rem;
}
.notice-item .user-info .username {
    font-weight: bold;
    color: #333;
}
.notice-item .user-info .date {
    font-size: 0.9rem;
    color: #666;
}
/* 중요 태그 추가 */
.importance-badge {
    background-color: #ff6b6b;
    color: #fff;
    padding: 0.2rem 0.5rem;
    border-radius: 4px;
    font-size: 0.8rem;
    margin-left: auto;
}
.importance-badge.normal {
    background-color: #6ab7d5;
}
.notice-item .post-content span {
    color: #333;
    font-size: 1.1rem;
    display: block;
    margin-bottom: 0.5rem;
    font-weight: bold;
}
.notice-item .post-content p {
    font-size: 0.95rem;
    color: #666;
    margin-bottom: 0.5rem;
}
.notice-item .post-image {
    max-width: 100%;
    border-radius: 8px;
    margin: 0.5rem 0;
}
.notice-item .action-buttons {
    display: flex;
    gap: 0.5rem;
    align-items: center;
}
.pagination {
    text-align: center;
    margin: 2rem 0;
}
.pagination a {
    display: inline-block;
    padding: 0.5rem 1rem;
    margin: 0 0.2rem;
    border-radius: 4px;
    text-decoration: none;
    color: #333;
    background-color: #fff;
    border: 1px solid #ddd;
    transition: all 0.3s ease;
}
.pagination a:hover {
    background-color: #87ceeb;
    color: #fff;
    border-color: #87ceeb;
}
.pagination a.active {
    background-color: #4682b4;
    color: #fff;
    border-color: #4682b4;
}
.pagination a.disabled {
    color: #ccc;
    pointer-events: none;
}
@keyframes slideUp {
    from {
        transform: translateY(20px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}
</style>
</head>
<body>
<jsp:include page="/resources/jsp/Header.jsp" />

<main>

    <!-- 메인 공지사항 -->
    <section class="main-notice">
        <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80" alt="공지사항 이미지">
        <div class="main-notice-content">
            <h2>공지사항</h2>
            <p>특별한 이벤트와 최신 소식을 놓치지 마세요!</p>
        </div>
    </section>

    <!-- 공지사항 리스트 -->
    <section class="notice-list">
        <div class="notice-list-header">
            <h2>공지사항</h2>
            
            <!-- 글쓰기 버튼: 관리자 및 슈퍼관리자만 표시 -->
            <c:if test="${sessionScope['admin'] == 'ok'}">
                <button class="write-post-button">
                    <a href="${pageContext.request.contextPath}/notice/write" style="text-decoration: none; color: white;">글쓰기</a>
                </button>
            </c:if>
        </div>

        <!-- 중요 공지사항 먼저 출력 -->
        <c:forEach var="notice" items="${noticeList}">
            <c:if test="${notice.importance == '중요'}">
                <div class="notice-item important" data-notice-id="${notice.board_id}" onclick="goToDetail(this)">
                    <div class="user-icon">${notice.username.charAt(0)}</div>
                    <div class="content-wrapper">
                        <div class="user-info">
                            <span class="username">${notice.username}</span>
                            <span class="date">${notice.created_at}</span>
                            <span class="importance-badge">중요</span>
                        </div>
                        <div class="post-content">
                            <span>${notice.title}</span>
                            <p>${notice.content}</p>
                            <c:if test="${not empty notice.f_name}">
                                <img src="${pageContext.request.contextPath}/Uploads/${notice.f_name}" alt="공지사항 이미지" class="post-image">
                            </c:if>
                        </div>
                        
                        <!-- 수정 버튼: 관리자 및 슈퍼관리자만 표시 -->
                        <c:if test="${sessionScope['admin'] == 'ok'}">
                            <div class="action-buttons">
                                <button class="edit-button" onclick="goToEdit('${notice.board_id}'); event.stopPropagation();">
                                    수정
                                </button>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>
        </c:forEach>

        <!-- 일반 공지사항 출력 -->
        <c:forEach var="notice" items="${noticeList}">
            <c:if test="${notice.importance != '중요'}">
                <div class="notice-item" data-notice-id="${notice.board_id}" onclick="goToDetail(this)">
                    <div class="user-icon">${notice.username.charAt(0)}</div>
                    <div class="content-wrapper">
                        <div class="user-info">
                            <span class="username">${notice.username}</span>
                            <span class="date">${notice.created_at}</span>
                            <span class="importance-badge normal">일반</span>
                        </div>
                        <div class="post-content">
                            <span>${notice.title}</span>
                            <p>${notice.content}</p>
                            <c:if test="${not empty notice.f_name}">
                                <img src="${pageContext.request.contextPath}/Uploads/${notice.f_name}" alt="공지사항 이미지" class="post-image">
                            </c:if>
                        </div>
                        
                        <!-- 수정 버튼: 관리자 및 슈퍼관리자만 표시 -->
                        <c:if test="${sessionScope['admin'] == 'ok'}">
                            <div class="action-buttons">
                                <button class="edit-button" onclick="goToEdit('${notice.board_id}'); event.stopPropagation();">
                                    수정
                                </button>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>
        </c:forEach>

        <!-- 페이징 -->
        <div class="pagination">
            <c:if test="${paging.nowBlock > 1}">
                <a href="?nowPage=${paging.beginBlock - 1}">« 이전</a>
            </c:if>
            <c:if test="${paging.nowBlock <= 1}">
                <a href="#" class="disabled">« 이전</a>
            </c:if>
            <c:forEach begin="${paging.beginBlock}" end="${paging.endBlock}" var="i">
                <c:choose>
                    <c:when test="${i == paging.nowPage}">
                        <a href="#" class="active">${i}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="?nowPage=${i}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${paging.nowBlock < paging.totalBlock}">
                <a href="?nowPage=${paging.endBlock + 1}">다음 »</a>
            </c:if>
            <c:if test="${paging.nowBlock >= paging.totalBlock}">
                <a href="#" class="disabled">다음 »</a>
            </c:if>
        </div>
    </section>
</main>

<jsp:include page="/resources/jsp/Footer.jsp" />

<script>
function goToDetail(element) {
    const noticeId = element.dataset.noticeId;
    if (noticeId) {
        window.location.href = '${pageContext.request.contextPath}/notice/detail?id=' + noticeId;
    }
}

function goToEdit(noticeId) {
    window.location.href = '${pageContext.request.contextPath}/notice/edit?id=' + noticeId;
}
</script>
</body>
</html>