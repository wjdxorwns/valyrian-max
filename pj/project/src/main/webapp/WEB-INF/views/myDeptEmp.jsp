<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 작성자: 한찬욱 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출근 확인</title>

	<!-- 화면(CSS) 링크 -->
    <link href="<c:url value='/resources/css/HanCW/CSS_mydeptemp.css' />" rel="stylesheet">
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
	
	table,tr,td,th {
		border: 1px solid black;
		border-collapse: collapse;
	}
	th{
		width: 120px;
	}
	table {
	   		
		text-align: center;
		overflow: auto scroll;
		margin-top: 50px;
		margin-bottom: 50px;
		margin-left: 50px;
		}
</style>
  

</head>
<body>
	<!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />
    <!-- Aside -->
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
		<div style="margin-left: 50px">
			<div style="display: flex; gap: 1800px;">
				<div>
				  <h2>직원 출근 확인</h2>
				  <h4>직원들의 주간별 근무 확인</h4>
				</div>
				<div>
					<br>
					<label for="yearSelect"> 연도 : </label>
						<select id="yearSelect">
							<!-- JavaScript로 동적 생성 -->
						</select>
					<label for="monthSelect" style="margin-left: 15px;"> 월  : </label>
						<select id="monthSelect">
							<option value="1">1월</option>
							<option value="2">2월</option>
							<option value="3">3월</option>
							<option value="4">4월</option>
							<option value="5">5월</option>
							<option value="6">6월</option>
							<option value="7">7월</option>
							<option value="8">8월</option>
							<option value="9">9월</option>
							<option value="10">10월</option>
							<option value="11">11월</option>
							<option value="12">12월</option>						
						</select>	
						<button style="margin-left: 15px; width: 35px;" onclick="searchAttendance()">검색</button>
					
				</div>
			</div>
			<div id="resultContainer">
			<!-- 결과 출력 -->				
			<jsp:include page="/resources/jsp/myDeptEmpResult.jsp" /> 	
				
						
			</div>	
		</div>
	</main>
		
	<!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />
	</body>
	
		<script type="text/javascript">
			// 페이지 로드 시 연도 옵션 생성
			document.addEventListener('DOMContentLoaded', function() {
				const yearSelect = document.getElementById('yearSelect');
				const currentYear = new Date().getFullYear();
				
				// 현재 연도부터 5년 전까지의 옵션 생성
				for (let year = currentYear; year >= currentYear - 5; year--) {
					const option = document.createElement('option');
					option.value = year;
					option.textContent = year + '년';
					yearSelect.appendChild(option);
				}
				
				// 현재 월 선택
				const currentMonth = new Date().getMonth() + 1;
				document.getElementById('monthSelect').value = currentMonth;
			});

			function searchAttendance() {
				const year = document.getElementById('yearSelect').value;
				const month = document.getElementById('monthSelect').value;
				
				// 로딩 표시
				document.getElementById('resultContainer').innerHTML = '<div style="text-align: center;">데이터를 불러오는 중...</div>';
				
				fetch(`/attendance/search?year=${year}&month=${month}`, {
					method: 'GET',
					headers: {
						'Content-Type': 'application/json'
					}
				})
				.then(response => {
					if (!response.ok) {
						throw new Error('Network response was not ok');
					}
					return response.text();
				})
				.then(html => {
					document.getElementById('resultContainer').innerHTML = html;
				})
				.catch(error => {
					console.error('Error:', error);
					document.getElementById('resultContainer').innerHTML = 
						'<div style="color: red; text-align: center;">데이터를 불러오는 중 오류가 발생했습니다.</div>';
				});
			}
		</script>		
		
</html>




