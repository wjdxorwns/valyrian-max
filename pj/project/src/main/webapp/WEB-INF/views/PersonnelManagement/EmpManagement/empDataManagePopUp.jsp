<!-- 작성자: 김기섭 | 기여자: 김재겸 -->


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="3부상조 - 인사 데이터 관리 3">
<title>3부상조 - 인사 데이터 관리 3</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/KimKS/CSS_pop_up.css' />" rel="stylesheet">
    <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> 
    <style type="text/css">
/* Override and enhance styles for payroll info page */
body {
	font-family: 'Roboto', sans-serif; /* Use Roboto for consistency */
}

main {
	margin-top: 60px;
	margin-left: 200px;
	padding: 2rem;
	max-width: calc(100% - 200px);
	min-height: calc(100vh - 60px);
	background: none; /* Remove background image for clarity */
	color: #333;
	text-align: left;
}

.employee-section {
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 2rem;
	max-width: 100%;
}

.employee-section h2 {
	font-size: 2rem;
	color: #333;
	margin-bottom: 1rem;
	margin-left: 0; /* Override CSS_working_ways.css */
}

.employee-section h4 {
	font-size: 1.2rem;
	color: #666;
	margin-bottom: 2rem;
	margin-left: 0; /* Override CSS_working_ways.css */
}

/* Search and Filter Area */
.search-filter {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 2rem;
	flex-wrap: wrap;
	gap: 1rem;
}

.search-filter input[type="text"] {
	padding: 0.5rem;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 1rem;
	width: 200px;
}

.search-filter select {
	padding: 0.5rem;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 1rem;
	width: 150px;
	appearance: none;
	padding-right: 2rem;
}

.search-filter .total-cost {
	font-size: 1rem;
	color: #333;
	font-weight: bold;
}

/* Table Styles (Enhanced from CSS.css) */
table {
	width: 100%;
	border-collapse: collapse;
	margin: 0;
	font-size: 1rem;
	text-align: center;
}

table th, table td {
	padding: 1rem;
	border: 1px solid #ddd;
}

table thead {
	background-color: #87ceeb; /* Sky blue theme */
	color: #fff;
}

table tbody tr:nth-child(even) {
	background-color: #f9f9f9;
}

table tbody tr:hover {
	background-color: #e0f4ff; /* Light sky blue on hover */
}

table input[type="checkbox"] {
	cursor: pointer;
}

/* form-section */
.container {
	display: flex;
	gap: 20px;
	margin-top: 20px;
}

.section {
	display: flex;
	align-items: center;
	margin-bottom: 2rem;
	flex-wrap: wrap;
	border-style: solid #333 1px;
	gap: 1rem;
	padding: 20px;
	width: 350px;
	border-radius: 10px;
	
}

/* form-row */
.row {
	margin-bottom: 15px;
	display: flex;
	align-items: center;
}

.row label {
	width: 100px;
	font-weight: bold;
}

input, button {
	padding: 5px 10px;
	
	
}
	button {
	width : 75px;
	height: 30px;
	margin-left: 5px;
	}

.input[readonly], .input:disabled {
	background-color: #ddd;
}

/* Action Buttons */
.action-buttons {
	margin-top: 1rem;
	display: flex;
	justify-content: flex-end;
	gap: 1rem;
}

.action-buttons button {
	padding: 0rem 1rem;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 1rem;
	transition: all 0.3s ease;
}

.download-btn {
	background-color: #87ceeb;
	color: #fff;
}

.download-btn:hover {
	background-color: #6ab7d5;
}

.cancel-btn {
	background-color: #ccc;
	color: #333;
}

.cancel-btn:hover {
	background-color: #bbb;
}


</style>
</head>
<body>
		<!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />
	<header id="main-header">
		<div id="logo">
			<a href="/">3부상조</a>
		</div>
		<nav>
			<ul class="nav-items">
				<li><a href="/">직원등록</a></li>
				<li><a href="/">근무 지정</a></li>
				<li><a href="/">인사 관리</a></li>
				<li><a href="/">급여</a></li>
				<li><a href="/">휴가</a></li>
			</ul>
		</nav>
	</header>

	<!-- Sidebar -->
	<aside id="sidebar">
		<nav>
			<ul>
				<li><a href="/">인사관리</a></li>
				<li><a href="/payrollInfo">인사 데이터 관리</a></li>
				<li><a href="/payrollInfo">퇴사 데이터 관리</a></li>
				<li><a href="/payrollInfo">보직 이동</a></li>
			</ul>
		</nav>
	</aside>

	<!-- Main Content -->
	<main>
		<section class="employee-section">
			<h2>인사 데이터 관리</h2>
			<h4>관리자가 임직원의 호봉, 부서 등 인사정보 관리</h4>

			<div class="container">

				<div class="section">
					<div class="row">
						<label>직원번호</label> <input type="text" value="">
						<button>중복확인</button>
					</div>

					<div class="row">
						<label>직원명</label> <input type="text" value="" readonly>
					</div>

					<div class="row">
						<label>부서</label> <input type="text" value="">
					</div>
					<div class="row">
						<label>직책</label> <input type="text" value="">
					</div>
					<div class="row">
						<label>호봉</label> <input type="text" value="">
					</div>

				</div>

				<div class="section">
					<div class="row">
						<label>근무형태</label> <input type="text" value="" readonly>
					</div>

					<div class="row">
						<label>입사일자</label> <input type="text" value="">
					</div>

					<div class="row">
						<label>퇴사일자</label> <input type="text">
					</div>

					<div class="row">
						<label>계정상태</label> <input type="text" value="" readonly>
					</div>
				</div>
			</div>
			
			<!-- Action Buttons -->
			<div class="action-buttons">
				<button class="update-btn">수정</button>
				<button class="cancel-btn">취소</button>
			</div>
		</section>
	
	
	<!-- 모달 팝업 -->
	<div id="popup" class="modal hidden">
  	<div class="modal-content">
    <p>해당 직원의 인사정보를 최신화 하겠습니까?</p>
    <div class="btn-group">
      <button onclick="confirmUpdate()">확인</button>
      <button onclick="closePopup()">취소</button>
    </div>
  </div>
</div>

</main>
  <!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />
	<script type="text/javascript">
  function openPopup() {
    document.getElementById('popup').classList.remove('hidden');
  }

  function closePopup() {
    document.getElementById('popup').classList.add('hidden');
  }

  function confirmUpdate() {
    alert("직원 정보가 업데이트되었습니다.");
    closePopup();
  }
</script>	
</body>
</html>