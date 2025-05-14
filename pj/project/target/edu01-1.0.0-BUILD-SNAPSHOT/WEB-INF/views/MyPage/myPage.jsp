<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 작성자: 한찬욱 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 정보(MyPage)</title>

	<!-- 화면(CSS) 링크 -->
    <link href="<c:url value='/resources/css/HanCW/CSS_mypage.css' />" rel="stylesheet">
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
	<!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />
    
    <jsp:include page="/resources/jsp/PayAside.jsp" /> 
	

	<main>	<!-- 사진, 이메일, 직원 이름, 집주소, 상세 집주소, 휴대전화번호, 부서명, 직책, 호봉, 입사일, 직원 고유코드, 휴가일  -->

		<div class="container" style="margin-top: 120px;" >
			 <div class="main_body">
		  <h2>내 정보 조회</h2>
			  <h4>본인의 개인 정보를 확인 및 수정합니다.</h4>
			  	<!-- 전체 테이블 -->
					<div class="container_left">
						<jsp:include page="myPageLeft.jsp" />
					</div>
					<div class="buttons">
					    <form action="/myPageUp" method="post">
					        <input type="hidden" name="emp_idx" value="${eVO.emp_idx}">
					        <button type="submit">수정하러가기</button>
					    </form>
					    <form action="/index" method="get">
					        <button type="submit">메인돌아가기</button>
					        
					    </form>
					</div>					
			 </div>
		</div>	  		  	
	</main>
		
	<!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />
	</body>
</html>



