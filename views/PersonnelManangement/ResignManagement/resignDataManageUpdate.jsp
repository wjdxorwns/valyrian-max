<!-- 작성자: 김기섭 | 기여자: 김재겸 -->


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="3부상조 - 퇴사 데이터 관리 2">
<title>3부상조 - 퇴사 데이터 관리 2</title>
 <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/KimKS/CSS_origin.css' />" rel="stylesheet">
     <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> 
    <style type="text/css">


</style>
</head>
<body>
	<!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />
	

	<!-- Main Content -->
	<main>
		<section class="employee-section">
			<h2>퇴사 데이터 관리</h2>
			<h4>관리자가 퇴사자의 인사정보 관리 및 계정 동결</h4>

			<div class="container">

				<div class="section">
					<div class="row">
						<label>직원번호</label> <input type="text" value=""readonly>
					</div>

					<div class="row">
						<label>직원명</label> <input type="text" value="" readonly>
					</div>

					<div class="row">
						<label>부서</label> <input type="text" value=""readonly>
					</div>
					<div class="row">
						<label>직책</label> <input type="text" value=""readonly>
					</div>
				</div>

				<div class="section">
				<div class="row">
						<label>입사일자</label> <input type="text" value=""readonly>
					</div>
					<div class="row">
						<label>퇴사일자</label> <input type="date" value="" >
					</div>
					<div class="row">
						<label>계정상태</label> <select>
							<option>정상</option>
							<option>동결</option>
						</select>
					</div>
				</div>
			</div>
			
			<!-- Action Buttons -->
			<div class="action-buttons">
				<button class="update-btn">수정</button>
				<button class="cancel-btn">취소</button>
			</div>
		</section>
	</main>
	  <!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />
</body>
</html>