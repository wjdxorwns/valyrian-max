<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>근태 관리 시스템 - 메인 페이지</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- CSS 파일 -->
<link href="<c:url value='/resources/css/Header.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />"
	rel="stylesheet">

<style>
body {
	margin: 0;
	font-family: 'Roboto', sans-serif;
	background-color: #f9f9f9;
	color: #333;
}

main {
	padding: 2rem;
	max-width: 1200px;
	margin: auto;
}

.clock-container {
	text-align: center;
	margin-bottom: 2rem;
	margin-top: 80px;
}

.clock {
	font-size: 48px;
	font-weight: bold;
	color: #2c3e50;
}

.card-container {
	display: flex;
	justify-content: space-around;
	margin-bottom: 2rem;
	flex-wrap: wrap;
	gap: 1.5rem;
}

.attendance-card {
	background-color: #ffffff;
	border-radius: 16px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	padding: 2rem;
	flex: 1;
	min-width: 260px;
	max-width: 360px;
	text-align: center;
	transition: transform 0.2s ease;
}

.attendance-card:hover {
	transform: translateY(-5px);
}

.icon-wrapper {
	margin-bottom: 1rem;
}

.icon {
	font-size: 40px;
	display: inline-block;
	padding: 1rem;
	border-radius: 50%;
	color: white;
}

.checkin-icon {
	background-color: #27ae60;
}

.checkout-icon {
	background-color: #c0392b;
}

.attendance-card h2 {
	margin: 1rem 0;
}

.btn {
	background-color: #3498db;
	color: white;
	padding: 0.75rem 1.5rem;
	font-size: 16px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background 0.3s;
}

.btn:hover {
	background-color: #2980b9;
}

.weekly-attendance-section {
	margin-top: 3rem;
	background-color: #fff;
	border-radius: 12px;
	padding: 1.5rem 2rem;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.06);
}

.weekly-attendance-section h3 {
	margin-bottom: 1rem;
	font-size: 20px;
	border-bottom: 2px solid #ddd;
	padding-bottom: 0.5rem;
}

.attendance-table-container {
	max-height: 400px;
	overflow-y: auto;
	margin-top: 1rem;
}

.attendance-table {
	width: 100%;
	border-collapse: collapse;
}

.attendance-table th, .attendance-table td {
	padding: 0.75rem;
	text-align: left;
	border-bottom: 1px solid #eee;
}

.attendance-table th {
	background-color: #f8f9fa;
	font-weight: 600;
	position: sticky;
	top: 0;
	z-index: 10;
}

.attendance-table tr:hover {
	background-color: #f1f3f5;
}

.attendance-table td {
	font-size: 14px;
	color: #555;
}
</style>
</head>
<body>

	<!-- 헤더 영역 포함 -->
	<jsp:include page="/resources/jsp/Header.jsp" />

	<!-- 메인 콘텐츠 영역 -->
	<main>
		<section class="attendance-section">
			<!-- 실시간 시계 표시 -->
			<div class="clock-container">
				<div class="clock" id="current-time">00:00:00</div>
			</div>
			<!-- 출근/퇴근 카드 -->
			<div class="card-container">
				<div class="attendance-card">
					<div class="icon-wrapper">
						<span class="icon checkin-icon">↓</span>
					</div>
					<h2>출근하기</h2>
					<button class="btn" onclick="recordCheckin()" aria-label="출근 등록">출근
						등록</button>
				</div>
				<div class="attendance-card">
					<div class="icon-wrapper">
						<span class="icon checkout-icon">↑</span>
					</div>
					<h2>퇴근하기</h2>
					<button class="btn" onclick="recordCheckout()" aria-label="퇴근 등록">퇴근
						등록</button>
				</div>
			</div>
		</section>

		<!-- 주간 근태 테이블 -->
		<section class="weekly-attendance-section">
			<h3>나의 주간 근태 현황</h3>
			<div class="attendance-table-container">
				<table class="attendance-table">
					<thead>
						<tr>
							<th>직원 이름</th>
							<th>날짜</th>
							<th>출근 시간</th>
							<th>퇴근 시간</th>
							<th>출근 타입</th>
						</tr>
					</thead>
					<tbody id="weekly-attendance-body">
						<!-- 주간 근태 데이터가 JavaScript를 통해 동적으로 추가됩니다 -->
					</tbody>
				</table>
			</div>
		</section>

		<!-- 관리자용 오늘의 전체 직원 근태 현황 -->
		<c:if test="${sessionScope['user.admin'] == 'ok'}">
			<section>
				<h2 class="section-title">직원 근태 현황 (오늘)</h2>
				<div class="table-container">
					<table class="attendance-table">
						<thead>
							<tr>
								<th>직원 이름</th>
								<th>출근 시간</th>
								<th>퇴근 시간</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody id="employee-attendance-body">
							<!-- 오늘의 직원 근태 데이터가 JavaScript를 통해 동적으로 추가됩니다 -->
						</tbody>
					</table>
				</div>
			</section>
		</c:if>
	</main>

	<!-- 푸터 영역 포함 -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

	<!-- JavaScript 기능 -->
	<script>
		// 실시간 시계 업데이트
		function updateClock() {
			const now = new Date();
			const hours = String(now.getHours()).padStart(2, '0');
			const minutes = String(now.getMinutes()).padStart(2, '0');
			const seconds = String(now.getSeconds()).padStart(2, '0');
			document.getElementById('current-time').textContent = `${hours}:${minutes}:${seconds}`;
		}
		setInterval(updateClock, 1000);
		updateClock(); // 초기 호출

		// 날짜 포맷팅 함수
		function formatDate(date) {
			const year = date.getFullYear();
			const month = String(date.getMonth() + 1).padStart(2, '0');
			const day = String(date.getDate()).padStart(2, '0');
			return `${year}-${month}-${day}`;
		}

		// 시간 포맷팅 함수
		function formatTime(date) {
			const hours = String(date.getHours()).padStart(2, '0');
			const minutes = String(date.getMinutes()).padStart(2, '0');
			const seconds = String(date.getSeconds()).padStart(2, '0');
			return `${hours}:${minutes}:${seconds}`;
		}

		// CSRF 토큰 가져오기
		const csrfToken = $('meta[name="_csrf"]').attr('content');
		const csrfHeader = $('meta[name="_csrf_header"]').attr('content');

		// 출근 기록 함수
		function recordCheckin() {
			const now = new Date();
			const userName = "${sessionScope.user.name}"; // 세션에서 사용자 이름 가져오기
			const date = formatDate(now);
			const checkinTime = formatTime(now);

			// 서버로 출근 데이터 전송 (예시로 AJAX 사용)
			$.ajax({
				url: '/attendance/checkin',
				type: 'POST',
				data: {
					userName: userName,
					date: date,
					checkinTime: checkinTime,
					attendanceType: '정상'
				},
				beforeSend: function(xhr) {
					xhr.setRequestHeader(csrfHeader, csrfToken);
				},
				success: function(response) {
					// 테이블에 데이터 추가
					const tableBody = document.getElementById('weekly-attendance-body');
					const newRow = document.createElement('tr');
					newRow.innerHTML = `
						<td>${userName}</td>
						<td>${date}</td>
						<td>${checkinTime}</td>
						<td>-</td>
						<td>정상</td>
					`;
					tableBody.prepend(newRow);
					alert('출근이 등록되었습니다.');
				},
				error: function(xhr, status, error) {
					alert('출근 등록에 실패했습니다.');
				}
			});
		}

		// 퇴근 기록 함수
		function recordCheckout() {
			const now = new Date();
			const userName = "${sessionScope.user.name}";
			const date = formatDate(now);
			const checkoutTime = formatTime(now);

			// 서버로 퇴근 데이터 전송
			$.ajax({
				url: '/attendance/checkout',
				type: 'POST',
				data: {
					userName: userName,
					date: date,
					checkoutTime: checkoutTime
				},
				beforeSend: function(xhr) {
					xhr.setRequestHeader(csrfHeader, csrfToken);
				},
				success: function(response) {
					// 테이블에서 오늘의 출근 기록 찾아 퇴근 시간 업데이트
					const tableBody = document.getElementById('weekly-attendance-body');
					const rows = tableBody.getElementsByTagName('tr');
					for (let row of rows) {
						const cells = row.getElementsByTagName('td');
						if (cells[0].textContent === userName && cells[1].textContent === date) {
							cells[3].textContent = checkoutTime;
							break;
						}
					}
					alert('퇴근이 등록되었습니다.');
				},
				error: function(xhr, status, error) {
					alert('퇴근 등록에 실패했습니다.');
				}
			});
		}
	</script>
</body>
</html>