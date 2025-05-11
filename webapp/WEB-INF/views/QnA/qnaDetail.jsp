<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #fff;
        border: 1px solid #e8ecef;
        margin-bottom: 20px;
    }

    th, td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #e8ecef;
        font-size: 14px;
    }

    th {
        background-color: #f8fafc;
        color: #333;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        width: 20%;
    }

    td {
        color: #555;
    }

    .content-cell {
        white-space: pre-wrap;
        min-height: 200px;
    }

    .button-container {
        display: flex;
        gap: 10px;
        justify-content: flex-end;
    }

    .edit-button, .back-link {
        padding: 8px 16px;
        border: none;
        border-radius: 4px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        text-decoration: none;
        text-align: center;
        transition: background-color 0.3s;
    }

    .edit-button {
        background-color: #00498c;
        color: #fff;
    }

    .edit-button:hover {
        background-color: #00a331;
    }

    .back-link {
        background-color: #e8ecef;
        color: #555;
        display: inline-block;
    }

    .back-link:hover {
        background-color: #d8dfe6;
    }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/resources/css/JeoungTJ/Main.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css'/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>

<jsp:include page="/resources/jsp/Header.jsp" />
<main style="margin: 80px auto 200px auto;">
<h2>QnA 내용</h2>
<table>
    <tr>
        <th>제목</th>
        <td>${q.question_title}</td>
    </tr>
    <tr>
        <th>작성자</th>
        <td>${q.writer}</td>
    </tr>
    <tr>
        <th>등록일</th>
        <td>${q.question_date}</td>
    </tr>
    <tr>
        <th>내용</th>
        <td class="content-cell">${q.question_content}</td>
    </tr>
    <tr>
    	<th>답변</th>
        <td class="content-cell">${q.question_content}</td>
    </tr>
    <tr>
        <th>답변 상태</th>
        <td>${q.answer_status}</td>
    </tr>
</table>
<div class="button-container">
    <a href="${pageContext.request.contextPath}/qnaWrite?answer_id=${q.answer_id}" class="edit-button">수정</a>
    <a href="qna.jsp" class="back-link">목록</a>
</div>
</main>
	<jsp:include page="/resources/jsp/Footer.jsp" />




</body>
</html>