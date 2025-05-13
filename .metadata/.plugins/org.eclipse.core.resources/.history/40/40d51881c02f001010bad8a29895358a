<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

td:last-child:contains( '답변완료 ') {
	color: #00c73c;
}

td:last-child:contains( '미답변 ') {
	color: #ff4d4f;
}




table tfoot ol.paging {
	list-style: none;
}

table tfoot ol.paging li {
	float: left;
	margin-right: 8px;
}

table tfoot ol.paging li a {
	display: block;
	padding: 3px 7px;
	border: 1px solid #00B3DC;
	color: #2f313e;
	font-weight: bold;
}

table tfoot ol.paging li a:hover {
	background: #00B3DC;
	color: white;
	font-weight: bold;
}

.disable {
	padding: 3px 7px;
	border: 1px solid silver;
	color: silver;
}

.now {
	padding: 3px 7px;
	border: 1px solid #4682b4;
	background: #4682b4;
	color: white;
	font-weight: bold;
}
a { text-decoration: none; }




</style>
</head>
<link href="<c:url value='/resources/css/JeoungTJ/Main.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css'/>" rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


</head>

<body>
	<jsp:include page="/resources/jsp/Header.jsp" />


	<main style="margin: 80px auto 200px auto;">
		<h2 style="margin-top: 80px;">QnA 게시판</h2>
	
		<a href="qnaWrite.jsp"
			onclick="window.open('${pageContext.request.contextPath}/qnaWrite', 'qnaPopup', 'width=600,height=600,scrollbars=yes'); return false;">글쓰기</a>

		<table border="1">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>답변상태</th>
				</tr>
			</thead>
			<tbody>
			<c:set var="count" value="${paging.totalRecord - (paging.nowPage - 1) * paging.numPerPage}" />
				<c:forEach var="q" items="${qnaList}" varStatus="v">
					<tr>
						<td>${count}</td>
						<td><a href="qnaDetail?answer_id=${q.answer_id}">${q.question_title}</a></td>
						<td>${q.emp_name}</td>
						<td>${q.question_date}</td>
						<td>${q.answer_status}</td>
					</tr>
					 <c:set var="count" value="${count - 1}" />
				</c:forEach>
			</tbody>
<tfoot>
  <tr>
    <td colspan="5" style="text-align: center;">
      <ol class="paging">

        <!-- 이전 페이지 (1페이지보다 작아지면 비활성화) -->
        <c:choose>
          <c:when test="${paging.nowPage <= 1}">
            <li class="disable">«</li>
          </c:when>
          <c:otherwise>
            <li><a href="/qna?nowPage=${paging.nowPage - 1}">«</a></li>
          </c:otherwise>
        </c:choose>

        <!-- 페이지 번호 -->
        <c:forEach begin="${paging.beginBlock}" end="${paging.endBlock}" var="k">
          <c:choose>
            <c:when test="${k == paging.nowPage}">
              <li class="now">${k}</li>
            </c:when>
            <c:otherwise>
              <li><a href="/qna?nowPage=${k}">${k}</a></li>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <!-- 다음 페이지 (마지막 페이지 이상이면 비활성화) -->
        <c:choose>
          <c:when test="${paging.nowPage >= paging.totalPage}">
            <li class="disable">»</li>
          </c:when>
          <c:otherwise>
            <li><a href="/qna?nowPage=${paging.nowPage + 1}">»</a></li>
          </c:otherwise>
        </c:choose>

      </ol>
    </td>
  </tr>
</tfoot>
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