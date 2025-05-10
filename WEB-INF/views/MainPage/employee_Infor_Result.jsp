<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!-- 작성자: 한찬욱 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 직원 정보 조회 테이블</title>

<style type="text/css">
	h3{ 
		margin-top: -70px;
	}
.container{
		overflow : auto;
	}
</style>
	<!-- 화면(CSS) 링크 -->
	<link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
    
    <!-- 폰트 링크 -->
	<link
		href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
		rel="stylesheet">
	<!-- Font Awesome for social icons -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
	<main>

			<h3>검색 결과</h3>
			<div id="container" >
			<c:choose>
				
				<c:when test="${not empty emp_list }">
					<table>
						<thead>
							<tr>
								<th>no</th>
								<th>직원번호</th>
								<th>이메일</th>
								<th>이름</th>
								<th>비밀번호</th>
								<th>주소</th>
								<th>상세 주소</th>
							 	<th>전화번호</th>
							 	<th>생성일</th>
							</tr>
						</thead>
						<tbody>
							<!-- 전체 직원 리스트 -->
							<c:forEach var="k" items="${emp_list}" varStatus="v">
								<tr>
									<td>${v.count }</td>
									<td>${k.user_idx }</td>
									<td>${k.emp_email }</td>
									<td>${k.emp_password }</td>
									<td>${k.emp_name }</td>
									<td>${k.home }</td>
									<td>${k.detail_home }</td>
									<td>${k.phone_number }</td>
									<td>${k.generation_day }</td>
								</tr>
							</c:forEach>
	
						</tbody>
					</table>
				</c:when>
				<c:otherwise>
					<p id="alert" style="color: blue">검색 결과가 없는데용?</p>
				</c:otherwise>
			</c:choose>
		</div>
	</main>
</body>
</html>