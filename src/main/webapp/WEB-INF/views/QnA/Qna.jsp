<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>QnA 게시판</title>
<style type="text/css">
/* Write Question Link */
a[href="qnaWrite.jsp"] {
    display: inline-block;
    margin-bottom: 20px;
    padding: 8px 16px;
    background-color: #00498c;
    color: #fff;
    text-decoration: none;
    border-radius: 4px;
    font-size: 14px;
    font-weight: 500;
    transition: background-color 0.3s;
}

a[href="qnaWrite.jsp"]:hover {
    background-color: #00a331;
}

/* Table Styles */
table {
    width: 100%;
    border-collapse: collapse;
    background-color: #fff;
    border: 1px solid #e8ecef;
 
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
}

td {
    color: #555;
}

tr:hover {
    background-color: #f9f9f9;
}

/* Table Links */
td a {
    color: #00c73c;
    text-decoration: none;
    font-weight: 500;
}

td a:hover {
    text-decoration: underline;
}

/* Answer Status */
td:last-child {
    font-weight: 500;
}

td:last-child:contains('답변완료') {
    color: #00c73c;
}

td:last-child:contains('미답변') {
    color: #ff4d4f;
}

</style>
</head>
<link href="<c:url value='/resources/css/JeoungTJ/Main.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css'/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


</head>

<body>
<jsp:include page="/resources/jsp/Header.jsp" />


<main style="margin: 80px auto 200px auto;">
<h2>QnA 게시판</h2>

<a href="qnaWrite.jsp" onclick="window.open('${pageContext.request.contextPath}/qnaWrite', 'qnaPopup', 'width=600,height=600,scrollbars=yes'); return false;">글쓰기</a>

<table border="1">
  <tr><th>번호</th><th>제목</th><th>작성자</th><th>등록일</th><th>날짜</th><th>답변상태</th></tr>
  <c:forEach var="q" items="${qnaList}">
    <tr>
      <td>${q.answer_id}</td>
      <td><a href="view.jsp?id=${q.answer_id}">${q.question_title}</a></td>
      <td>${q.writer}</td>
      <td>${q.emp_name}</td>
      <td>%{q.question_date}</td>
      <td>${q.answer_status}
    </tr>
  </c:forEach>
</table>
</main>
	<jsp:include page="/resources/jsp/Footer.jsp" />
	
<script type="text/javascript">

function showWritePopup(button) {
    const content = button.getAttribute('data-content');
    document.getElementById('writeContent').innerText = content;
    document.getElementById('writeModal').style.display = 'block';
}

function closeWritePopup() {
    document.getElementById('writeModal').style.display = 'none';
}



</script>
</body>
</html>