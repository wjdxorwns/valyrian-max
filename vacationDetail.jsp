<!-- 김용호 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 신청된 휴가 목록 -> 디테일</title>
	<!-- 폰트 로드 -->
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- CSS 파일 링크 -->
<link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Vacation.css' />" rel="stylesheet">
<style type="text/css">
#detail{
border:1px solid black;
margin:10px auto; 
background-color: #fff;
width : 100%;
height:100%;
align-items: center;
justify-content: space-between;
}
table, th, td{
border:1px solid black;
}
th, td{
width:150px;
height:50px;
}
th{
background-color: #e0f4ff;
}
input{
padding:5px;
margin: 10px;
align-items: center;
justify-content: flex-end;
margin-right: 10px;
}
.button-area {
    text-align: right;
    padding: 10px;
}
.button-area input {
    margin-right: 20px;
}
</style>
</head>
<body>


	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />
	
	<main>
		<form action="">
			<div id="title"><h2>${emp_name }  ${position }님의 휴가 신청입니다</h2></div>
			<div id="detail">
				<table>
					<tbody>
						<tr>
							<td rowspan="3">${f_name }</td><th>이름</th><td>${emp_name }</td>
						</tr>
						<tr>
							<th>직원 코드</th><td>${emp_id }</td>
						</tr>
						<tr>
							<th>휴가 ID</th><td>${vacation_id }</td>
						</tr>
						<tr>
							<th>휴가 시작일</th><td colspan="2">${start_date }</td>
						</tr>
						<tr>
							<th>휴가 종료일</th><td colspan="2">${end_date }</td>
						</tr>
						<tr>
							<th>결제</th>
							<td colspan="2">${request_vacation }
								<select>
									<option>승인</option>
									<option>불승인</option>
								</select>
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<th>첨부파일</th><td colspan="2"></td>
						</tr>
					</tfoot>
				</table>
				<div class="button-area">
    				<input type="button" value="적용" onclick="">
				</div>
			</div>
		</form>
	</main>
	
	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

</body>
</html>