<!-- 작성자 : 한찬욱 / 기여자 : 김용호 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 화면(CSS) 링크 -->

    <link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/KimYH/CSS_vacation.css">
    
    <!-- 폰트 링크 -->
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
	<!-- Font Awesome for social icons -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<style type="text/css">

</style>
</head>
<body>
	<!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />
    
    <jsp:include page="/resources/jsp/PayAside.jsp" /> 
<main>
	<div>
		<h2>내 정보 조회</h2>
		<h4>본인의 개인 정보를 확인 및 수정합니다.</h4>
		
	</div>
</main>
 
	<!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />

</body>
</html>