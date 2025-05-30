<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="3부상조 - 퇴사자 리스트 조회(슈퍼관리자)">
<title>3부상조 - 퇴사자 리스트 조회(슈퍼관리자)</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/KimKS/CSS_origin.css' />"
	rel="stylesheet">
<!-- Font Awesome for social icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style type="text/css">
.employee-section {
	width: 1500px;
	margin: 0 auto;
}

.emp_information {
	overflow-x: auto;
	max-width: 100%;
}

.emp_table {
	min-width: 2000px
}

.btu input {
	margin-right: 5px;
	margin-top: 10px;
}
th, td{
width:200px;
height:50px;
}

</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />

	<!-- Aside -->
	<jsp:include page="/resources/jsp/EmpDataAside.jsp" />

	<!-- Main Content -->
	<main>
		<section class="employee-section">
			<h2>퇴사 데이터 관리</h2>
			<h4>슈퍼관리자가 퇴사자의 계정 동결 및 인사정보 조회</h4>
			<!-- Search and Filter -->
			<div>
				<div class="search-form">
					<!-- Action Buttons -->
					<div>
						<form method="get" action="resignedEmployees">
							<select name="searchType" class="employee">
								<option value="emp_name">직원명</option>
								<option value="emp_id">직원번호</option>
								<option value="team">부서</option>
								<option value="position">직책</option>
								<option value="quitter">계정상태</option>
							</select> <input type="text" name="keyword" placeholder="검색어 입력">
							<button type="submit">검색</button>
						</form>
					</div>
				</div>
			</div>

			<!-- Detail Table -->
		
			<div class=" emp_information">
			<form method="post" action="updateQuitter">
				<table class=" emp_table">
					<thead>
						<tr>
							<th>직원번호</th>
							<th>직원 이름</th>
							<th>부서 이름</th>
							<th>직책</th>
							<th>이메일</th>
							<th>생년월일</th>
							<th>성별</th>
							<th>휴대전화번호</th>
							<th>주소</th>
							<th>상세주소</th>
							<th>입사일</th>
							<th>근무지</th>
							<th>년차</th>
							<th>고용타입</th>
							<th>근무방식</th>
							<th>부서명</th>
							<th>퇴사일자</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="emp" items="${employeeList}">
							<tr>
								<td>${emp.emp_id}</td>
								<td>${emp.emp_name}</td>
								<td>${emp.team}</td>
								<td>${emp.position}</td>
								<td>${emp.emp_email}</td>
								<td>${emp.brithday}</td>
								<td>${emp.gender}</td>
								<td>${emp.phone_number}</td>
								<td>${emp.home}</td>
								<td>${emp.detail_home}</td>
								<td>${emp.hire_date}</td>
								<td>${emp.location}</td>
								<td>${emp.pay_grade}</td>
								<td>${emp.employment_type}</td>
								<td>${emp.attitude_type}</td>
								<td>${emp.dept_name}</td>
								<td>${emp.resignation_date}</td>
								<td><input type="hidden" name="emp_id"
									value="${emp.emp_id}" />
									 <select name="quitter">
										<option value="입사" ${emp.quitter == '입사' ? 'selected' : ''}>입사</option>
										<option value="퇴사대기"
											${emp.quitter == '퇴사대기' ? 'selected' : ''}>퇴사대기</option>
										<option value="퇴사" ${emp.quitter == '퇴사' ? 'selected' : ''}>퇴사</option>
								</select></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="btu">
					<input type="submit" value="저장" class="btn-save" onclick=""> 
				</div>
				</form>
			</div>
		</section>
		
		
	</main>

	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

</body>
</html>