<!-- 작성자 : 김용호 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 휴가 승인 화면</title>
    <!-- 폰트 로드 -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- CSS 파일 링크 -->
    <link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
    
<link rel="stylesheet" 
	href="${pageContext.request.contextPath}/resources/css/Vacation.css">
<style type="text/css">
#standby{
border: 1px solid black;
background-color: #fff;

margin-top: 10px;
overflow: hidden;
}
#standby p{
text-align: center;
margin-top: 10px;
}
#complete{
border: 1px solid black;
background-color: #fff;

margin-top: 50px;
overflow: hidden;
}
#complete p{
text-align: center;
margin-top: 10px;
}

/* 공통 */
table{
margin-top:10px;
border-bottom: 2px solid black;
border-top: 2px solid black;
}

th, td{
width:150px;
height:50px;
text-align: center;
border:1px solid black;
}
#button{
margin:5px;
padding:5px;
align-items: flex-end;
justify-content: flex-end;
float: right;
}
tbody tr:hover {
    background-color: #f5f5f5; /* 마우스 오버 시 배경색 */
}


</style>
</head>
<body>

	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />
	
	<main>
		<form action="">
			<div id="title">
				<h2>직원 휴가 신청 사항</h2>
			</div>
			
			<div id="standby">
				<p>승인 대기 목록</p>
				<table>
					<thead>
						<tr>
							<th>no.</th><th>부서</th><th>직급</th><th>이름</th><th>사원id</th><th>기간</th><th>결제</th><th>비고(사유)</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${count }</td>
							<td></td>
							<td>${position }</td> <!-- employee(직원) 테이블 -->
							<td>${emp_name }</td> <!-- user(회원가입) 테이블 -->
							<td>${emp_idx }</td> <!-- employee(직원) 테이블 -->
							<td>${start_date } ~ ${end_date }</td> <!-- vacation(휴가) 테이블 -->
							<td>
								<select>
									<option>승인</option>
									<option>불승인</option>
								</select>
							</td>
							<td><input type="text" value="불승인 사유"></td>
						</tr>
					</tbody>
				</table>
				<input id="button" type="button" value="적용" onclick="Approval_go">
			</div>
			
			<div id="complete">
				<p>승인 완료 목록</p>
				<table>
					<thead>
						<tr>
							<th>no.</th><th>부서</th><th>직급</th><th>이름</th><th>사원id</th><th>기간</th><th>결제</th><th>비고(사유)</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${count }</td>
							<td></td>
							<td>${position }</td> <!-- employee(직원) 테이블 -->
							<td>${emp_name }</td> <!-- user(회원가입) 테이블 -->
							<td>${emp_idx }</td> <!-- employee(직원) 테이블 -->
							<td>${start_date } ~ ${end_date }</td> <!-- vacation(휴가) 테이블 -->
							<td>
								<select>
									<option>승인</option>
									<option>불승인</option>
								</select>
							</td>
							<td><input type="text" value="불승인 사유"></td>
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