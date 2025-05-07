<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 메인 페이지</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- CSS 파일 -->
<link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">

<style>
/* 기존 스타일 */
body {
    margin: 0;
    font-family: 'Roboto', sans-serif;
    background-color: #f0f2f5;
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
}

.clock {
    font-size: 48px;
    font-weight: bold;
    color: #2c3e50;
}

.status {
    font-size: 18px;
    margin-top: 0.5rem;
    color: #888;
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
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
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

.time {
    font-size: 20px;
    margin: 0.5rem 0 1rem;
    font-weight: 500;
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

.action-buttons {
    text-align: center;
    margin-top: 2rem;
}

.action-btn {
    background-color: #8e44ad;
    color: white;
    padding: 0.75rem 1.25rem;
    margin: 0 0.5rem;
    font-size: 15px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.3s;
}

.action-btn:hover {
    background-color: #732d91;
}

.summary-section {
    margin-top: 3rem;
    background-color: #fff;
    border-radius: 12px;
    padding: 1.5rem 2rem;
    box-shadow: 0 4px 8px rgba(0,0,0,0.06);
}

.summary-section h3 {
    margin-bottom: 1rem;
    font-size: 20px;
    border-bottom: 2px solid #ddd;
    padding-bottom: 0.5rem;
}

.summary-item {
    font-size: 16px;
    margin: 0.5rem 0;
    color: #555;
}

.weekly-attendance-section {
    margin-top: 3rem;
    background-color: #fff;
    border-radius: 12px;
    padding: 1.5rem 2rem;
    box-shadow: 0 4px 8px rgba(0,0,0,0.06);
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

.status-normal {
    color: #27ae60;
    font-weight: 500;
}

.status-late {
    color: #e74c3c;
    font-weight: 500;
}

.status-absent {
    color: #7f8c8d;
    font-weight: 500;
}
</style>
</head>
<body>

<!-- Header 영역 -->
<jsp:include page="/resources/jsp/Header.jsp" />

<!-- Main 영역 -->
<main>
    <section class="attendance-section">
        <div class="clock-container">
            <div class="clock" id="current-time">00:00:00</div>
            <div class="status" id="status-text">휴식중</div>
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
            <button class="action-btn" id="break-btn" onclick="toggleBreak()">휴식 시작</button>
            <button class="action-btn" onclick="startTask()">업무</button>
        </div>
    </section>

    <section class="summary-section">
        <h3>오늘의 근무 요약</h3>
        <div class="summary-item">출근 시간: <span id="summary-checkin">미등록</span></div>
        <div class="summary-item">퇴근 시간: <span id="summary-checkout">미등록</span></div>
        <div class="summary-item">휴식 시간: <span id="summary-break-hours">0시간 0분</span></div>
    </section>

    <section class="weekly-attendance-section">
        <h3>주간 근태 현황</h3>
        <div class="attendance-table-container">
            <table class="attendance-table">
                <thead>
                    <tr>
                        <th>직원 이름</th>
                        <th>날짜</th>
                        <th>출근 시간</th>
                        <th>퇴근 시간</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody id="weekly-attendance-body">
                    <!-- JavaScript로 동적으로 추가 -->
                </tbody>
            </table>
        </div>
    </section>
</main>

<!-- Footer 영역 -->
<jsp:include page="/resources/jsp/Footer.jsp" />

<!-- JavaScript -->
<script>
$(document).ready(function() {
    // 상태 변수
    let isOnBreak = false;
    let breakStartTime = null;
    let totalBreakTime = 0;
    let checkinTime = null;
    let checkoutTime = null;

    // 실시간 시계 업데이트
    function updateClock() {
        const now = new Date();
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const seconds = String(now.getSeconds()).padStart(2, '0');
        $("#current-time").text(`${hours}:${minutes}:${seconds}`);
    }

    // 시간 포맷팅 (HH:MM:SS)
    function formatTime(date) {
        if (!date) return "00:00:00";
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        const seconds = String(date.getSeconds()).padStart(2, '0');
        return `${hours}:${minutes}:${seconds}`;
    }

    // 시간 차이 계산 (분 단위)
    function calculateTimeDifference(start, end) {
        if (!start || !end) return 0;
        return Math.round((end - start) / 1000 / 60);
    }

    // 휴식 시간 포맷팅
    function formatBreakTime(minutes) {
        const hours = Math.floor(minutes / 60);
        const mins = minutes % 60;
        return `${hours}시간 ${mins}분`;
    }

    // 요약 업데이트
    function updateSummary() {
        $("#summary-checkin").text(checkinTime ? formatTime(checkinTime) : "미등록");
        $("#summary-checkout").text(checkoutTime ? formatTime(checkoutTime) : "미등록");
        $("#summary-break-hours").text(formatBreakTime(totalBreakTime));
    }

    // 샘플 주간 근태 데이터
    const weeklyData = [
        { name: "김민수", date: "2025-05-01", checkin: "09:00", checkout: "18:00", status: "정상" },
        { name: "김민수", date: "2025-04-30", checkin: "09:15", checkout: "17:45", status: "지각" },
        { name: "김민수", date: "2025-04-29", checkin: "-", checkout: "-", status: "결근" },
        { name: "이영희", date: "2025-05-01", checkin: "08:50", checkout: "18:10", status: "정상" },
        { name: "이영희", date: "2025-04-30", checkin: "09:00", checkout: "18:00", status: "정상" },
        { name: "이영희", date: "2025-04-29", checkin: "09:05", checkout: "17:50", status: "정상" },
        { name: "박철수", date: "2025-05-01", checkin: "09:00", checkout: "18:00", status: "정상" },
        { name: "박철수", date: "2025-04-30", checkin: "09:30", checkout: "17:30", status: "지각" },
    ];

    // 주간 근태 테이블 렌더링
    function renderWeeklyAttendance(data) {
        const tbody = $("#weekly-attendance-body");
        tbody.empty();
        data.forEach(item => {
            const statusClass = item.status === "정상" ? "status-normal" :
                              item.status === "지각" ? "status-late" : "status-absent";
            const row = `
                <tr>
                    <td>${item.name}</td>
                    <td>${item.date}</td>
                    <td>${item.checkin}</td>
                    <td>${item.checkout}</td>
                    <td class="${statusClass}">${item.status}</td>
                </tr>
            `;
            tbody.append(row);
        });
    }

    // 출근 등록
    window.recordCheckin = function() {
        if (checkinTime) {
            alert("이미 출근 등록이 완료되었습니다.");
            return;
        }
        checkinTime = new Date();
        $("#checkin-time").text(formatTime(checkinTime));
        $("#status-text").text("업무중");
        updateSummary();
    };

    // 퇴근 등록
    window.recordCheckout = function() {
        if (!checkinTime) {
            alert("출근 등록이 먼저 필요합니다.");
            return;
        }
        if (checkoutTime) {
            alert("이미 퇴근 등록이 완료되었습니다.");
            return;
        }
        checkoutTime = new Date();
        $("#checkout-time").text(formatTime(checkoutTime));
        $("#status-text").text("퇴근");
        updateSummary();
    };

    // 휴식 시작/종료
    window.toggleBreak = function() {
        if (!checkinTime) {
            alert("출근 등록이 먼저 필요합니다.");
            return;
        }
        if (isOnBreak) {
            const breakEndTime = new Date();
            totalBreakTime += calculateTimeDifference(breakStartTime, breakEndTime);
            $("#status-text").text("업무중");
            $("#break-btn").text("휴식 시작");
            isOnBreak = false;
            breakStartTime = null;
        } else {
            breakStartTime = new Date();
            $("#status-text").text("휴식중");
            $("#break-btn").text("휴식 종료");
            isOnBreak = true;
        }
        updateSummary();
    };

    // 업무 시작
    window.startTask = function() {
        if (!checkinTime) {
            alert("출근 등록이 먼저 필요합니다.");
            return;
        }
        if (isOnBreak) {
            toggleBreak(); // 휴식 종료 후 업무 시작
        }
        $("#status-text").text("업무중");
    };

    // 초기화
    updateClock();
    setInterval(updateClock, 1000);
    renderWeeklyAttendance(weeklyData);
    updateSummary();
});
</script>
</body>
</html>