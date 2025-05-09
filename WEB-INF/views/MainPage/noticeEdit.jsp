<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정 - 3부상조</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link href="<c:url value='/resources/css/Header.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />"
	rel="stylesheet">
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

.form-group input[type="text"], .form-group textarea, .form-group select
	{
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

.current-image {
	margin-top: 0.5rem;
	display: flex;
	flex-direction: column;
	gap: 0.5rem;
}

.current-image img {
	max-width: 200px;
	border-radius: 4px;
	border: 1px solid #ddd;
}

.current-image .image-options {
	display: flex;
	align-items: center;
	gap: 1rem;
}

.keep-image-checkbox {
	display: flex;
	align-items: center;
	gap: 0.5rem;
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

.delete-btn {
	background-color: #ff6b6b;
	color: #fff;
}

.delete-btn:hover {
	background-color: #e74c3c;
}

.cancel-btn {
	background-color: #ccc;
	color: #333;
}

.cancel-btn:hover {
	background-color: #bbb;
}
/* 알림 메시지 스타일 */
.alert {
	padding: 1rem;
	border-radius: 4px;
	margin-bottom: 1.5rem;
	font-weight: 500;
}

.alert-success {
	background-color: #d4edda;
	color: #155724;
	border: 1px solid #c3e6cb;
}

.alert-danger {
	background-color: #f8d7da;
	color: #721c24;
	border: 1px solid #f5c6cb;
}

@
keyframes slideUp {from { transform:translateY(20px);
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

		<section class="notice-form">
			<h1>공지사항 수정</h1>

			<!-- 성공 또는 오류 메시지 표시 영역 -->
			<c:if test="${not empty message}">
				<div class="alert alert-${messageType}">${message}</div>
			</c:if>

			<form action="${pageContext.request.contextPath}/notice/update"
				method="post" enctype="multipart/form-data" id="editForm">
				<input type="hidden" name="board_id" value="${board.board_id}">
				<div class="form-group">
					<label for="title">제목</label> <input type="text" id="title"
						name="title" required value="${board.title}">
				</div>
				<div class="form-group">
					<label for="importance">중요도</label> <select id="importance"
						name="importance" required>
						<option value="일반"
							<c:if test="${board.importance == '일반'}">selected</c:if>>일반</option>
						<option value="중요"
							<c:if test="${board.importance == '중요'}">selected</c:if>>중요</option>
					</select>
				</div>
				<div class="form-group">
					<label for="content">내용</label>
					<textarea id="content" name="content" required>${board.content}</textarea>
				</div>
				<div class="form-group">
					<label for="image">이미지 업로드</label> <input type="file" id="image"
						name="image" accept="image/*">

					<c:if test="${not empty board.f_name}">
						<div class="current-image">
							<p>현재 이미지:</p>
							<img
								src="${pageContext.request.contextPath}/Uploads/${board.f_name}"
								alt="현재 이미지" />
							<div class="image-options">
								<div class="keep-image-checkbox">
									<input type="checkbox" id="keepImage" name="keepImage"
										value="true" checked> <label for="keepImage">현재
										이미지 유지</label>
								</div>
								<p class="hint">(체크 해제 시 이미지가 삭제됩니다. 새 이미지를 업로드하면 기존 이미지는
									대체됩니다.)</p>
							</div>
						</div>
					</c:if>
				</div>
				<div class="action-buttons">
					<button type="submit" class="submit-btn">수정 완료</button>
					<button type="button" class="delete-btn"
						onclick="confirmDelete(${board.board_id})">삭제</button>
					<button type="button" class="cancel-btn"
						onclick="window.location.href='${pageContext.request.contextPath}/notice'">취소</button>
				</div>
			</form>
		</section>
	</main>

	<jsp:include page="/resources/jsp/Footer.jsp" />

	<script>
    function confirmDelete(boardId) {
        if (confirm('정말로 이 공지사항을 삭제하시겠습니까?')) {
            window.location.href = '${pageContext.request.contextPath}/notice/delete?id=' + boardId;
        }
    }
    
    // 파일 업로드 시 기존 이미지 체크박스 비활성화
    document.getElementById('image').addEventListener('change', function() {
        const keepImageCheckbox = document.getElementById('keepImage');
        if (keepImageCheckbox && this.files.length > 0) {
            keepImageCheckbox.checked = false;
            keepImageCheckbox.disabled = true;
        }
    });
    </script>
</body>
</html>