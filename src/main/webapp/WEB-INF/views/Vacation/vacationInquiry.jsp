<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 - 휴가 조회 및 신청 화면</title>
<!-- 폰트 로드 -->
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<!-- Font Awesome for social icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- CSS 파일 링크 -->
<link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Aside.css' />" rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/KimYH/CSS_vacation.css">
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

/* 남은 휴가 정보 */
#possible {
	border: 1px solid black;
	background-color: #fff;
	text-align: center;
	margin-top: 10px;
	margin-bottom: 20px;
}

#possible p {
	margin: 10px auto;
}

/* 휴가 신청 */
#apply {
	border: 1px solid black;
	text-align: center;
	background-color: #fff;
	overflow: hidden;
}

#apply p {
	margin: 10px;
}

#apply table {
	border-bottom: 2px solid black;
}

#button {
	margin: 5px;
	padding: 5px;
	float: right;
}

/* 사용한 휴가 */
#complete {
	border: 1px solid black;
	background-color: #fff;
	text-align: center;
	margin-top: 20px;
	margin-bottom: 20px;
}

#complete p {
	margin: 10px auto;
}

#complete th, td {
	width: 150px;
	height: 50px;
	text-align: center;
}

/* 공통 */
table{
	margin-top: 10px;
	border-top: 2px solid black;
}

th, td {
	width: 150px;
	height: 50px;
	text-align: center;
	border: 1px solid black;
}

tbody td input {
	padding: 5px;
}
</style>
</head>
<body>

	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />
	
	<!-- Aside -->
	<jsp:include page="/resources/jsp/VacationAside.jsp" />

	<main>
		<form action="" method="post">
			<div id="title">
				<h2>휴가 신청 및 현황 조회</h2>
			</div>
			<div id="possible">
				<p>신청가능 휴가 정보</p>
				<table>
					<thead>
						<tr>
							<th>휴가 구분</th>
							<th>직원ID</th>
							<th>이름</th>
							<th>직급</th>
							<th>년차</th>
							<th>잔여 연차</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${not empty vacationDays}">
						<tr>
							<th style="background-color: #e0f4ff;">가용 가능</th>
							<td>${vacationDays.emp_idx }</td>
							<td>${vacationDays.emp_name }</td>
							<td>${vacationDays.position }</td>
							<td>${vacationDays.pay_grade }</td>
							<td>${vacationDays.vacation_balance }</td>
						</tr>
						</c:if>
					</tbody>
				</table>
			</div>

			<div id="complete">
				<p>신청완료 휴가 정보</p>
				<table>
					<thead>
						<tr>
							<th>휴가 구분</th>
							<th>휴가ID</th>
							<th>분류</th>
							<th>기간</th>
							<th>결재자</th>
							<th>결재</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="entry" items="${vacationMap}">
							<tr>
								<th style="background-color:#e0f4ff;">사용 내역</th>
								<td>${entry.value.vacation_id }</td>
								<td>${entry.value.vacation_type }</td>
								<td>${entry.value.start_date } ~ ${entry.value.end_date }</td>
								<td>${entry.value.emp_name }</td>
								<td>${entry.value.status }</td>
								<td>${entry.value.comment }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</form>
	</main>

	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

<script>

	
</script>
</body>
</html>