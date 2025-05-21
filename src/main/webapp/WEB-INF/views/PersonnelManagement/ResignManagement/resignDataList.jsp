<!-- 작성자: 김기섭 | 기여자: 김재겸, 김용호 -->


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

<link href="<c:url value='/resources/css/KimYH/resign.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/KimYH/re.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">

<!-- Font Awesome for social icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
<style type="text/css">

.container1{
	margin: 30px;
	padding: 20px;
	border-radius: 10px;
	background-color: #fff;
	min-width: 950px;
	
}
.text{
	margin:10px;
	margin-left: 0px;
	margin-bottom:40px;
}
.text h1{
margin-bottom: 10px;
}
.search-form{
margin-bottom:10px;
}
.employee{
padding: 5px;
margin-right: 10px;
}
.textbox{
padding: 5px;
}
.serach{
padding:2.5px;
}

.emp_information{
	overflow-x: auto;
	width:100%;
	max-width: 100%;
}
.emp_table{
	min-width: 1200px;
}
th, td{
min-width: 150px;
height: 50px;
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
		<div class="container1">
			<section class="employee-section">
				<div class="text">
					<h1>퇴사 데이터 관리</h2>
					<h4>슈퍼관리자가 퇴사자의 계정 동결 및 인사정보 조회</h4>
				</div>
				<!-- Search and Filter -->
				<div class="search-form">
					<!-- Action Buttons -->
					<select class="employee">
						<option>직원명</option>
						<option>직원번호</option>
						<option>부서</option>
						<option>직책</option>
					</select> 
					<input type="text" placeholder="검색" class="textbox">
					<button class="serach">검색</button>
				</div>
				

				<!-- Detail Table -->
				<div class=" emp_information">
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
								<th>퇴사자</th>
								<th>퇴사일자</th>
								<th>계정상태</th>
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
									<td>${emp.birthday}</td>
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
									<td>${emp.quitter}</td>
									<td>${emp.resignation_date}</td>
									<td>${emp.remove}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</section>
		</div>
	</main>
	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />
	<script type="text/javascript">
		
	</script>
</body>
</html>