<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 작성자: 한찬욱 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 직원 정보 조회 찾기</title>
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
<style type="text/css">
	hr{margin: 20px;}
</style>
</head>
<body>
	<header id="main-header">
    <div id="logo"><a href="/">3부상조</a></div>
    <nav>
      <ul class="nav-items">
        <li><a href="/">직원 정보 조회(H)</a></li>
        <li><a href="/cart">근무 지정</a></li>
        <li><a href="/orders">인사 관리</a></li>
        <li><a href="/signup">급여</a></li>
        <li><a href="/login">휴가</a></li>
      </ul>
    </nav>
    <button id="mobile-menu-btn">
      <span></span>
      <span></span>
      <span></span>
    </button>
  </header>

  <!-- Sidebar for Desktop -->
  <aside id="sidebar">
    <nav>
      <ul>
        <li><a href="/">직원등록</a></li>
        <li><a href="/">근무지정</a></li>
        <li><a href="/">인사</a></li>
        <li><a href="/">급여</a></li>
        <li><a href="/">휴가</a></li>
      </ul>
    </nav>
  </aside>
  
	<main>
		<div>
		  <h2>직원 정보 조회</h2>
		  <h4>모든 직원들의 정보를 확인합니다.</h4>
		</div>
			<hr>
			<form method="post">
				<p>
					<input type="button" value="전체 직원 조회" onclick="send_search('/emp_list', this.form)">
				</p>
				<p>
					<input type="text" name="emp_name" >
					<input type="button" value="이름 검색" onclick="send_search('/emp_name', this.form)"> 
				</p>
			  
				<p>
					<input type="text" name="emp_id" > 
					<input type="button" value="사번 검색"  onclick="send_search('/emp_id', this.form)">
				</p>
			</form>
		
			
		<hr>
	
		
	<%@ include file="employeeInforResult.jsp" %>

	<script type="text/javascript">
		function send_search(url,f){
			f.action=url;
			f.submit();
		}
	</script>
	</main> 
</body>
</html>















