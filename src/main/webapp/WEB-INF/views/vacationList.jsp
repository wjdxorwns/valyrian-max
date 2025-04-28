<!-- 작성자 : 김용호 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서장 - 휴가 현황 리스트</title>
	<!-- 폰트 로드 -->
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- CSS 파일 링크 -->
    <link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
    
<link rel="stylesheet" 
	href="${pageContext.request.contextPath}/resources/css/CSS_vacation.css">
<style type="text/css">
#list{
border:1px solid black;
background-color: #fff;
text-align: center;

margin-top: 10px;
}
#list p{
margin-top:10px;
}
/* 공통 */
table{
margin-top:10px;
border-bottom: 1px solid black;
border-top: 2px solid black;
}

th, td{
width:150px;
height:50px;
text-align: center;
border:1px solid black;
}
</style>
</head>
<body>

	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />
	
	<main>
		<form action="" method="">
			<div id="title"><h2>직원 휴가 현황</h2></div>
			<div id="list">
				<p>휴가 현황</p>
				<table>
					<thead>
						<tr>
							<th>No.</th><th>직급</th><th>이름</th><th>휴가기간</th><th>근무상태</th><th>승인결과</th><th>비고</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${count }</td>
							<td>${position }</td> <!-- employee(직원) 테이블 -->
							<td>${emp_name }</td> <!-- user(회원가입) 테이블 -->
							<td>${start_date } ~ ${end_date }</td> <!-- vacation(휴가) 테이블 -->
							<td>
								<c:choose>
									<c:when test="${empty request_vacation or request_vacation eq '거절' or request_vacation eq '대기'}">
										근무중
									</c:when>
									<c:otherwise>
										휴가중
									</c:otherwise>
								</c:choose>
							</td> <!-- request(승인요청) 테이블 -->
							<td>${request_vacation }</td> <!-- request(승인요청) 테이블 -->
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
	</main>
	
	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

</body>
</html>