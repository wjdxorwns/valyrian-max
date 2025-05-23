<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

.h2{
	margin: 0 auto;
}
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
    textarea {
  padding: 8px;
  line-height: 1.4;
  vertical-align: top;
  resize: vertical;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/resources/css/KimYH/adminpay.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/JeoungTJ/Main2.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css'/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>

<c:set var="dept_name" value="${sessionScope.dept_name}" />
<c:set var="emp_idx" value="${sessionScope.emp_idx}" />

<jsp:include page="/resources/jsp/Header.jsp" />

<main>
<div class="h2"><h2>QnA 내용</h2></div>
<form method="post" action="${pageContext.request.contextPath}/qnaUpdate">
  <input type="hidden" name="answer_id" value="${qna.answer_id}" />
  <table>
    <tr>
      <th>제목</th>
      <td>
        <c:choose>
          <c:when test="${dept_name eq '직원' && emp_idx eq qna.emp_idx}">
            <input type="text" name="question_title" value="${qna.question_title}" style="width: 1070px" />
          </c:when>
          <c:otherwise>
          ${qna.question_title}
          <input type="hidden" name="question_title" value="${qna.question_title}" />
          </c:otherwise>
        </c:choose>
      </td>
    </tr>
	<tr>
		<th>이름</th>
		<td>${qna.emp_name}</td>
	</tr>
	<tr>
		<th>날짜</th>
		<td>${qna.question_date}</td>
	</tr>
    <tr>
      <th>내용</th>
      <td>
        <c:choose>
          <c:when test="${dept_name eq '직원' && emp_idx eq qna.emp_idx}">
            <textarea name="question_details" rows="30" cols="130">${qna.question_details}</textarea>
          </c:when>
          <c:otherwise>
			<textarea name="question_details" rows="30" cols="130" readonly>${qna.question_details}</textarea>          </c:otherwise>
        </c:choose>
      </td>
    </tr>

    <tr>
      <th>답변</th>
      <td>
        <c:choose>
          <c:when test="${dept_name eq '관리자' || dept_name eq '슈퍼관리자'}">
            <textarea name="answer_comment" rows="5" style="width:100%;">${qna.answer_comment}</textarea>
          </c:when>
          <c:otherwise>
            ${qna.answer_comment}
            <input type="hidden" name="answer_status" value="${qna.answer_comment}" />
          </c:otherwise>
        </c:choose>
      </td>
    </tr>

    <tr>
      <th>답변 상태</th>
      <td>
        <c:choose>
          <c:when test="${dept_name eq '관리자' || dept_name eq '슈퍼관리자'}">
            <select name="answer_status">
              <option value="대기" <c:if test="${qna.answer_status eq '대기'}">selected</c:if>>대기</option>
              <option value="완료" <c:if test="${qna.answer_status eq '완료'}">selected</c:if>>완료</option>
            </select>
          </c:when>
          <c:otherwise>
            ${qna.answer_status}
           <input type="hidden" name="answer_status" value="${qna.answer_status}" />
          </c:otherwise>
        </c:choose>
      </td>
    </tr>
  </table>

  <div class="button-container">
    <button type="submit" class="edit-button">수정</button>
    <button type="button" onclick="deleteQna(${qna.answer_id})" class="edit-button">삭제</button>
    <a href="qna" class="back-link">목록</a>
  </div>
</form>

</main>
	<jsp:include page="/resources/jsp/Footer.jsp" />
</body>

<script>
function deleteQna(answer_id) {
  if (confirm("정말 삭제하시겠습니까?")) {
    location.href = '/qnaDelete?answer_id=' +answer_id;
  }
}
</script>

</html>