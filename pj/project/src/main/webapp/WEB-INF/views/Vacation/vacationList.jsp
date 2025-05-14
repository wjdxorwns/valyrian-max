<!-- 작성자 : 김용호 | 기여자 : 김재겸 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서장 - 휴가 현황 리스트</title>
<!-- 폰트 로드 -->
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<!-- Font Awesome for social icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- CSS 파일 링크 -->
<link href="<c:url value='/resources/css/Header.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />"
	rel="stylesheet">
<link href="<c:url value='resources/css/Aside.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/KimYH/CSS_vacation.css' />"
	rel="stylesheet">
<style type="text/css">
#list {
	border: 1px solid black;
	background-color: #fff;
	text-align: center;
	margin-top: 10px;
}

#list p {
	margin-top: 10px;
}

.no-data {
	font-size: 2rem;
	margin: 0 20px;
}
/* 공통 */
table {
	margin-top: 10px;
	border-bottom: 1px solid black;
	border-top: 2px solid black;
}

th, td {
	width: 150px;
	height: 50px;
	text-align: center;
	border: 1px solid black;
}
</style>
</head>
<body>

	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />
	<!-- Aside -->
	<jsp:include page="/resources/jsp/VacationAside.jsp" />

	<main>
		<form action="/leaveList" method="post">
			<div id="title">
				<h2>직원 휴가 현황</h2>
			</div>
			<div id="list">
				<p>휴가 현황</p>

				<jsp:useBean id="now" class="java.util.Date" />
				<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />

				<!-- start_date, end_date 포맷 맞춰주기 -->
				<fmt:formatDate value="${start_date}" pattern="yyyy-MM-dd"
					var="start_date" />
				<fmt:formatDate value="${end_date}" pattern="yyyy-MM-dd"
					var="end_date" />

				<table>
					<thead>
						<tr>
							<th style="width: 150px;">휴가 ID</th>
							<th>직급</th>
							<th>이름</th>
							<th>휴가기간</th>
							<th>근무상태</th>
							<th>승인결과</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty vacationMap}">
								<tr>
									<td colspan="7" class="no-data">휴가 신청 내역이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="entry" items="${vacationMap}">
									<tr>
										<td>${entry.value.vacation_id }</td>
										<td>${entry.value.position }</td>
										<%--  employee(직원) 테이블 --%>
										<td>${entry.value.emp_name }</td>
										<!-- user(회원가입) 테이블 -->
										<td>${entry.value.start_date }~${entry.value.end_date }</td>
										<!-- vacation(휴가) 테이블 -->
										<td><c:choose>
												<%-- "승인"일 때 현재 날짜에 따라 값이 변하게끔 --%>
												<c:when test="${entry.value.status eq '승인'}">
													<c:choose>
														<c:when test="${today < entry.value.start_date}">
													휴가 예정
												</c:when>
														<c:when
															test="${today >= entry.value.start_date and today <= entry.value.end_date}">
													휴가중
												</c:when>
														<c:otherwise>
													근무중
												</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
											근무중
										</c:otherwise>
											</c:choose></td>
										<!-- vacation(휴가) 테이블 -->
										<td>
											<!-- request(승인요청) 테이블 --> <c:choose>
												<c:when test="${entry.value.status eq '대기'}">
													<!-- null일 때 -->
											대기 
										</c:when>
												<c:when test="${entry.value.status eq '반려'}">
											반려 
										</c:when>
												<c:when test="${entry.value.status eq '승인'}">
											승인
										</c:when>
												<c:otherwise>
											-
										</c:otherwise>
											</c:choose>
										</td>
										<td>${entry.value.comment}</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</form>
	</main>

	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

</body>
</html>