<!-- 작성자 : 김용호 | 기여자 : 김재겸 -->
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
							<th>연차</th>
							<th>월차</th>
							<th>반차</th>
							<th>미사용 월차</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th style="background-color: #e0f4ff;">가용 가능</th>
							<td><c:forEach var="v" items="${vacation.request_idx}">
									<!-- Employee(직원) 테이블 -->
									<c:if test="${v.vacation_type == '연차'}">
										${v.vacation_day}일<br>
									</c:if>
								</c:forEach></td>
							<td><c:forEach var="v" items="${vacation.request_idx}">
									<!-- Employee(직원) 테이블 -->
									<c:if test="${v.vacation_type == '월차'}">
										${v.vacation_day}일<br>
									</c:if>
								</c:forEach></td>
							<td><c:forEach var="v" items="${vacation.request_idx}">
									<!-- Employee(직원) 테이블 -->
									<c:if test="${v.vacation_type == '반차'}">
										${v.vacation_day}회<br>
									</c:if>
								</c:forEach></td>
							<td><c:forEach var="v" items="${usedList}">
									<c:if test="${v.vacation_type == '미사용 월차'}">
										${v.vacation_day}일<br>
									</c:if>
								</c:forEach></td>
							<td></td>
						</tr>

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
							<th>종류</th>
							<th>기간</th>
							<th>반차</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th style="background-color:#e0f4ff;">사용 내역</th>
							<td colspan="3">ex) 1h2hb342 / 연차 / 2025.00.00 ~ 2025.00.00</td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
	</main>

	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

<script>

	function changeDateType(selectElement) {
		// 현재 선택한 값 읽기
		var selectedValue = selectElement.value;
	    
		// 같은 행(tr) 안에 있는 startDate, endDate input을 찾아야 함
		var tr = selectElement.closest('tr'); // select 태그가 속한 tr
		var startDateInput = tr.querySelector('input[name="startDate"]');
		var endDateInput = tr.querySelector('input[name="endDate"]');

		if (selectedValue === '반차') {
			startDateInput.type = 'time';
			endDateInput.type = 'time';
		} else {
			startDateInput.type = 'date';
			endDateInput.type = 'date';
		}
	}
</script>
</body>
</html>