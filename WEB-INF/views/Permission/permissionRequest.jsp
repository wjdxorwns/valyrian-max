<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 작성자: 한찬욱 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>권한 요청</title>

	<!-- 화면(CSS) 링크 -->
    <link href="<c:url value='/resources/css/HanCW/CSS_permissionrequest.css' />" rel="stylesheet">
	<link href="<c:url value='/resources/css/index.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Aside.css' />" rel="stylesheet">
    
    <!-- 폰트 링크 -->
	<link
		href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
		rel="stylesheet">
	<!-- Font Awesome for social icons -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
		
<style type="text/css">
	main{
		max-width: 1200px;
		margin: 0 auto;
		padding: 20px;
		margin-top: -80px;
		}
 	table, th, td {
    	border: 1px solid black;
   		border-collapse: collapse;
   		text-align: center;
   		padding: 2px;
		}
	tr, th, td	{
		width: 100px;
		}
	button	{
		width: 70px;
		padding: 2px;
		margin-top: 5px;
		margin-bottom: 5px;
		}

	.select_box	{
		border: none;
		background: none;
		font-size: inherit;
		}
	.buttons{
		text-align: right;
		margin-right: 50px;
		}
</style>
  

</head>
<body>
	<!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />
    
    <jsp:include page="/resources/jsp/PayAside.jsp" /> 
	


	
	  <!-- Mobile Menu -->
	  <aside id="mobile-menu">
	    <nav>
	      <ul class="nav-items">
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
			<div>
				<div>
				  <h2>권한 요청</h2>
				  <h4>슈퍼 관리자에게 권한 요청</h4>
				</div>
				<br>			
				<form action="/submit" method="post">
					<table>
						<thead>
							<tr>
								<th>부서</th><th>이름</th><th>권한 종류</th><th>신청일</th><th>상태</th><th style="width: 150px;">본인 사인</th><th style="width: 150px;">관리자 사인</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<input class="insert_box" type="text" name="team" required>
								</td>
								<td>
									<input class="insert_box" type="text" name="name" required>
								</td>
								<td>
									<input class="insert_box" type="text" name="permission" required>
								</td>		
								<td>
									<input class="insert_box" type="text" name="today" required>
								</td>	
								<td>
									<input class="insert_box"  type="text" name="condition" required>
								</td>	
								<td rowspan="2"></td>
								<td rowspan="2"></td>
							</tr>
							<tr>
								<td rowspan="2">신청 사유</td>
								<td colspan="4" rowspan="2">
									<input class="insert_box" style="width: 100%; height: 100px;" type="text" name="comment" required>
								</td>	
							</tr>
																																			
						</tbody>
					</table>
					<div class="buttons">
						<button type="button" id="apply_button">신 청</button>
					</div>
					
				</form>
					<br><br>
				<h2>신청 현황</h2>	
				<h4>슈퍼 관리자에게 요청한 현황</h4>	
				<div>
					<table>
						<thead>
							<tr>
								<th>부서</th><th>이름</th><th>권한 종류</th><th>신청일</th><th>상태</th><th>신청 사유</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<input class="select_box" type="text" name="team" readonly>
								</td>
								<td>
									<input class="select_box" type="text" name="name" readonly>
								</td>
								<td>
									<input class="select_box" type="text" name="permission" readonly>
								</td>		
								<td>
									<input class="select_box" type="text" name="today" readonly>
								</td>	
								<td>
									<input class="select_box" type="text" name="condition" readonly>
								</td>	
								<td>
									<input class="select_box"  style="width: 500px;" type="text" name="comment" readonly>
								</td>																												
							</tr>
						</tbody>
					</table>
				</div>
					<br><br>
				<h2>나의 신청 리스트</h2>	
				<h4>슈퍼 관리자의 답변</h4>	
				<div>
					<table>
						<thead>
							<tr>
								<th>부서</th><th>이름</th><th>권한 종류</th><th>신청일</th><th>상태</th><th>신청 사유</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<input class="select_box" type="text" name="team" readonly>
								</td>
								<td>
									<input class="select_box" type="text" name="name" readonly>
								</td>
								<td>
									<input class="select_box" type="text" name="permission" readonly>
								</td>		
								<td>
									<input class="select_box" type="text" name="today" readonly>
								</td>	
								<td>
									<input class="select_box" type="text" name="condition" readonly>
								</td>	
								<td>
									<input class="select_box"  style="width: 500px;" type="text" name="comment" readonly>
								</td>																												
							</tr>
						</tbody>
					</table>
				</div>				
			</div>
			<br><br>
			<div class="buttons">
				<button type="button" id="returnMain">돌아가기</button>
			</div>
			
		</div>
		<br>
	</main>
		
	<!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />
	</body>
	
		<script type="text/javascript">

		</script>		
		
</html>



