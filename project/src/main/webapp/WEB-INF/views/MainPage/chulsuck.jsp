<!-- 최성현 -->


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

        main {
            margin-top: 80px; /* Match header height */
            padding: 2rem 1rem;
            min-height: calc(100vh - 80px - 200px); /* Header (80px) + Footer (~200px) */
            background: #e9f0fd; /* Light blue to match login page */
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .attendance-section {
            max-width: 900px;
            width: 100%;
            margin-bottom: 2rem; /* Space above footer */
            text-align: center;
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
            <button class="action-btn" onclick="toggleBreak()">휴식</button>
            <button class="action-btn" onclick="startWork()">근무</button>
            <button class="action-btn" onclick="startTask()">업무</button>
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

    // Record check-in time
    function recordCheckin() {
        const now = new Date();
        const time = formatTime(now);

        // Update display
        document.getElementById('checkin-time').textContent = time;

        // Save to localStorage
        localStorage.setItem('checkin-time', time);
    }

    // Record check-out time
    function recordCheckout() {
        const now = new Date();
        const time = formatTime(now);

        // Update display
        document.getElementById('checkout-time').textContent = time;

        // Save to localStorage
        localStorage.setItem('checkout-time', time);
    }

    // Placeholder functions for additional buttons
    function toggleBreak() {
        const status = document.querySelector('.status');
        status.textContent = status.textContent === '휴식중' ? '근무중' : '휴식중';
    }

    function startWork() {
        alert('근무 시작 기능이 실행되었습니다.');
    }

    function startTask() {
        alert('업무 시작 기능이 실행되었습니다.');
    }

    // Load saved times and start clock on page load
    window.onload = function() {
        const checkinTime = localStorage.getItem('checkin-time');
        const checkoutTime = localStorage.getItem('checkout-time');

        if (checkinTime) {
            document.getElementById('checkin-time').textContent = checkinTime;
        }

        if (checkoutTime) {
            document.getElementById('checkout-time').textContent = checkoutTime;
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