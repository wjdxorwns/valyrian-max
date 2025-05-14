<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 메인 페이지</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- CSS 파일 링크 -->
<link href="<c:url value='/resources/css/Header.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />"
	rel="stylesheet">
<style type="text/css">
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: 'Roboto', sans-serif;
}

html, body {
	margin: 0;
	padding: 0;
	height: auto; /* Ensure body can grow with content */
}

main {
	margin-top: 80px; /* Match header height */
	padding: 2rem 1rem;
	background: #e9f0fd; /* Light blue to match login page */
	display: flex;
	flex-direction: column; /* Stack sections vertically */
	align-items: center;
	justify-content: center;
}

.summary-section {
	max-width: 1200px;
	width: 1200px; /* Fixed width */
	background: #fff;
	border-radius: 10px;
	padding: 1.5rem;
	margin-bottom: 2rem;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	text-align: center;
	margin-left: auto;
	margin-right: auto;
}

.summary-section h3 {
	font-size: 1.5rem;
	color: #333;
	margin-bottom: 1rem;
}

.summary-section .summary-item {
	font-size: 1.1rem;
	color: #666;
	margin-bottom: 0.5rem;
}

.attendance-section {
	max-width: 1200px;
	width: 1200px; /* Fixed width */
	min-height: 600px; /* Added to make the section taller */
	margin-bottom: 2rem; /* Space above footer */
	padding: 3rem; /* Added to increase internal spacing */
	text-align: center;
	margin-left: auto;
	margin-right: auto;
	display: flex; /* Use flex to control layout */
	flex-direction: column; /* Stack children vertically */
	align-items: center; /* Center children horizontally */
}

.clock-container {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 1rem;
	margin-bottom: 2rem;
}

.clock {
	font-size: 3rem;
	color: #333;
	font-weight: 700;
}

.status {
	font-size: 1.2rem;
	color: #666;
	background: #e0f4ff;
	padding: 0.3rem 1rem;
	border-radius: 15px;
}

.card-container {
	display: flex;
	gap: 1.5rem;
	justify-content: center;
	flex-wrap: wrap;
	margin-bottom: 2rem;
}

.attendance-card {
	background: #fff;
	border-radius: 10px;
	padding: 1.5rem;
	width: 220px; /* Slightly smaller to match screenshot */
	text-align: center;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.attendance-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
}

.icon-wrapper {
	background: #e9f0fd;
	border-radius: 50%;
	width: 60px;
	height: 60px;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto 1rem;
}

.icon {
	font-size: 1.5rem;
	color: #1e90ff;
}

.checkin-icon {
	transform: rotate(0deg);
}

.checkout-icon {
	transform: rotate(0deg);
}

.attendance-card h2 {
	font-size: 1.2rem;
	color: #333;
	margin-bottom: 0.8rem;
	font-weight: 500;
}

.attendance-card .time {
	font-size: 1.5rem;
	color: #1e90ff;
	margin-bottom: 1rem;
	font-weight: 700;
}

.attendance-card .btn {
	display: block;
	padding: 0.6rem 1rem;
	background-color: #1e90ff;
	color: #fff;
	text-decoration: none;
	border-radius: 6px;
	border: none;
	cursor: pointer;
	font-size: 0.9rem;
	transition: background 0.3s ease, transform 0.2s ease;
}

.attendance-card .btn:hover {
	background-color: #1c86ee;
	transform: scale(1.02);
}

.action-buttons {
	display: flex;
	gap: 1rem;
	justify-content: center;
}

.action-btn {
	padding: 0.6rem 1.5rem;
	background-color: #e9f0fd;
	color: #333;
	border: 1px solid #ddd;
	border-radius: 6px;
	cursor: pointer;
	font-size: 0.9rem;
	transition: background 0.3s ease, color 0.3s ease;
}

.action-btn:hover {
	background-color: #d0e4fd;
	color: #1e90ff;
}
</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />
	<main>
		<section class="attendance-section">
			<div class="clock-container">
				<div class="clock" id="current-time">00:00:00</div>
				<div class="status">휴식중</div>
			</div>
			<div class="card-container">
				<div class="attendance-card">
					<div class="icon-wrapper">
						<span class="icon checkin-icon">↓</span>
					</div>
					<h2>출근하기</h2>
					<div class="time" id="checkin-time">00:00:00</div>
					<button class="btn" onclick="recordCheckin()">출근 등록</button>
				</div>
				<div class="attendance-card">
					<div class="icon-wrapper">
						<span class="icon checkout-icon">↑</span>
					</div>
					<h2>퇴근하기</h2>
					<div class="time" id="checkout-time">00:00:00</div>
					<button class="btn" onclick="recordCheckout()">퇴근 등록</button>
				</div>
			</div>
			<div class="action-buttons">
				<button class="action-btn" id="break-btn" onclick="toggleBreak()">휴식
					시작</button>
				<button class="action-btn" id="work-btn" onclick="startWork()">근무
					시작</button>
				<button class="action-btn" onclick="startTask()">업무</button>
			</div>
		</section>
		<section class="summary-section">
			<h3>오늘의 근무 요약</h3>
			<div class="summary-item">
				출근 시간: <span id="summary-checkin">미등록</span>
			</div>
			<div class="summary-item">
				퇴근 시간: <span id="summary-checkout">미등록</span>
			</div>
			<div class="summary-item">
				근무 시간: <span id="summary-work-hours">0시간 0분</span>
			</div>
			<div class="summary-item">
				휴식 시간: <span id="summary-break-hours">0시간 0분</span>
			</div>
		</section>
		<script>
			// Update clock every second
			function updateClock() {
				const now = new Date();
				const hours = now.getHours().toString().padStart(2, '0');
				const minutes = now.getMinutes().toString().padStart(2, '0');
				const seconds = now.getSeconds().toString().padStart(2, '0');
				document.getElementById('current-time').textContent = `${hours}:${minutes}:${seconds}`;
			}

			// Format time as HH:MM:SS
			function formatTime(date) {
				return date.toTimeString().slice(0, 8);
			}

			// Calculate time difference in hours and minutes
			function calculateTimeDifference(startTime, endTime) {
				if (!startTime || !endTime) return "0시간 0분";
				const start = new Date("1970-01-01T" + startTime + "Z");
				const end = new Date("1970-01-01T" + endTime + "Z");
				const diffMs = end - start;
				if (diffMs < 0) return "0시간 0분"; // If end is before start
				const diffMins = Math.floor(diffMs / 1000 / 60);
				const hours = Math.floor(diffMins / 60);
				const minutes = diffMins % 60;
				return `${hours}시간 ${minutes}분`;
			}

			// Record check-in time
			function recordCheckin() {
				const now = new Date();
				const time = formatTime(now);

				// Update display
				document.getElementById('checkin-time').textContent = time;
				document.getElementById('summary-checkin').textContent = time;

				// Save to localStorage
				localStorage.setItem('checkin-time', time);

				// Update work hours if checkout exists
				const checkoutTime = localStorage.getItem('checkout-time');
				if (checkoutTime) {
					const workHours = calculateTimeDifference(time, checkoutTime);
					document.getElementById('summary-work-hours').textContent = workHours;
				}
			}

			// Record check-out time
			function recordCheckout() {
				const now = new Date();
				const time = formatTime(now);

				// Update display
				document.getElementById('checkout-time').textContent = time;
				document.getElementById('summary-checkout').textContent = time;

				// Save to localStorage
				localStorage.setItem('checkout-time', time);

				// Update work hours if checkin exists
				const checkinTime = localStorage.getItem('checkin-time');
				if (checkinTime) {
					const workHours = calculateTimeDifference(checkinTime, time);
					document.getElementById('summary-work-hours').textContent = workHours;
				}
			}

			// Toggle break start/end
			function toggleBreak() {
				const now = new Date();
				const time = formatTime(now);
				const breakBtn = document.getElementById('break-btn');
				const status = document.querySelector('.status');
				const isBreaking = breakBtn.textContent === "휴식 종료";

				if (!isBreaking) {
					// Start break
					localStorage.setItem('break-start', time);
					breakBtn.textContent = "휴식 종료";
					status.textContent = '휴식중';
				} else {
					// End break
					const breakStart = localStorage.getItem('break-start');
					localStorage.setItem('break-end', time);
					breakBtn.textContent = "휴식 시작";
					status.textContent = '휴식종료';

					// Calculate break duration
					const breakDuration = calculateTimeDifference(breakStart, time);
					document.getElementById('summary-break-hours').textContent = breakDuration;

					// Optionally reset break times
					localStorage.removeItem('break-start');
					localStorage.removeItem('break-end');
				}
			}

			// Toggle work start/end
			function startWork() {
				const now = new Date();
				const time = formatTime(now);
				const workBtn = document.getElementById('work-btn');
				const status = document.querySelector('.status');
				const isWorking = workBtn.textContent === "근무 종료";

				if (!isWorking) {
					// Start work
					localStorage.setItem('work-start', time);
					workBtn.textContent = "근무 종료";
					status.textContent = '근무중';
				} else {
					// End work
					const workStart = localStorage.getItem('work-start');
					localStorage.setItem('work-end', time);
					workBtn.textContent = "근무 시작";
					status.textContent = '근무종료';

					// Calculate work duration
					const workDuration = calculateTimeDifference(workStart, time);
					document.getElementById('summary-work-hours').textContent = workDuration;

					// Optionally reset work times
					localStorage.removeItem('work-start');
					localStorage.removeItem('work-end');
				}
			}

			// Update status for task button
			function startTask() {
				const status = document.querySelector('.status');
				status.textContent = '업무중';
			}

			// Load saved times and start clock on page load
			window.onload = function() {
				const checkinTime = localStorage.getItem('checkin-time');
				const checkoutTime = localStorage.getItem('checkout-time');
				const breakStart = localStorage.getItem('break-start');
				const workStart = localStorage.getItem('work-start');

				if (checkinTime) {
					document.getElementById('checkin-time').textContent = checkinTime;
					document.getElementById('summary-checkin').textContent = checkinTime;
				}

				if (checkoutTime) {
					document.getElementById('checkout-time').textContent = checkoutTime;
					document.getElementById('summary-checkout').textContent = checkoutTime;
				}

				if (checkinTime && checkoutTime) {
					const workHours = calculateTimeDifference(checkinTime, checkoutTime);
					document.getElementById('summary-work-hours').textContent = workHours;
				}

				// Restore break button state
				if (breakStart) {
					document.getElementById('break-btn').textContent = "휴식 종료";
					document.querySelector('.status').textContent = '휴식중';
				}

				// Restore work button state
				if (workStart) {
					document.getElementById('work-btn').textContent = "근무 종료";
					document.querySelector('.status').textContent = '근무중';
				}

				// Start clock
				updateClock();
				setInterval(updateClock, 1000);
			};
		</script>
	</main>
	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />
</body>
</html>