<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 관리 시스템 - 메인 페이지</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">

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
    <jsp:include page="/resources/jsp/Header.jsp" />
    <main>
        <section class="attendance-section">
            <div class="clock-container">
                <div class="clock" id="current-time">00:00:00</div>
            </div>
            <div class="card-container">
                <div class="attendance-card">
                    <div class="icon-wrapper">
                        <span class="icon checkin-icon">↓</span>
                    </div>
                    <h2>출근하기</h2>
                    <button class="btn" onclick="recordCheckin()" aria-label="출근 등록">출근 등록</button>
                </div>
                <div class="attendance-card">
                    <div class="icon-wrapper">
                        <span class="icon checkout-icon">↑</span>
                    </div>
                    <h2>퇴근하기</h2>
                    <button class="btn" onclick="recordCheckout()" aria-label="퇴근 등록">퇴근 등록</button>
                </div>
            </div>
        </section>
        <section class="weekly-attendance-section">
            <h3>나의 근태 현황</h3>
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
                    <tbody id="weekly-attendance-body"></tbody>
                </table>
            </div>
        </section>
        <c:if test="${sessionScope['user.admin'] == 'ok'}">
            <section>
                <h2 class="section-title">직원 근태 현황 (오늘)</h2>
                <div class="table-container">
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
                        <tbody id="employee-attendance-body"></tbody>
                    </table>
                </div>
            </section>
        </c:if>
    </main>
    <jsp:include page="/resources/jsp/Footer.jsp" />
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
        updateClock();

        // 근태 데이터 가져오기
        function fetchAttendanceData(url, tableBodyId) {
    $.ajax({
        url: url,
        type: 'GET',
        xhrFields: { withCredentials: true },
        success: function(data) {
            console.log('서버에서 받은 데이터:', data); // 디버깅용 로그 추가
            
            const tableBody = document.getElementById(tableBodyId);
            tableBody.innerHTML = '';

            // 데이터 형식 검증: 배열인지 확인
            if (!Array.isArray(data)) {
                console.warn('데이터가 배열 형식이 아닙니다. 데이터를 배열로 변환합니다.');
                data = [data]; // 객체를 배열로 변환
            }

            // 데이터가 비어 있는 경우 처리
            if (data.length === 0) {
                console.warn('데이터가 비어있습니다.');
                const emptyRow = document.createElement('tr');
                emptyRow.innerHTML = `<td colspan="5" style="text-align:center;">데이터가 없습니다.</td>`;
                tableBody.appendChild(emptyRow);
                return;
            }

            // 데이터 렌더링
            data.forEach(record => {
                console.log('현재 데이터 레코드:', record); // 각 레코드 디버깅용 로그

                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${record.emp_name || '-'}</td>
                    <td>${record.work_date || '-'}</td>
                    <td>${record.start_time ? record.start_time.substring(0, 8) : '-'}</td>
                    <td>${record.end_time ? record.end_time.substring(0, 8) : '-'}</td>
                    <td>${record.worktype || '-'}</td>
                `;
                tableBody.appendChild(row);
            });
        },
        error: function(xhr, status, error) {
            console.error('데이터 가져오기 실패:', error, xhr.status, xhr.responseJSON);

            // 에러 메시지를 사용자에게 명확히 전달
            const errorMessage = xhr.responseJSON?.error || `HTTP 상태 코드: ${xhr.status}`;
            alert(`데이터를 가져오는데 실패했습니다: ${errorMessage}`);
        }
    });
}

        // 출근 기록 함수
        function recordCheckin() {
            $.ajax({
                url: '/attendance/checkin',
                type: 'POST',
                xhrFields: { withCredentials: true },
                success: function(response) {
                    alert('출근이 등록되었습니다.');
                    fetchAttendanceData('/attendance/weekly', 'weekly-attendance-body');
                },
                error: function(xhr, status, error) {
                    console.error('출근 등록에 실패했습니다:', error, xhr.status, xhr.responseJSON);
                    alert('출근 등록에 실패했습니다: ' + (xhr.responseJSON?.error || xhr.status));
                }
            });
        }

        // 퇴근 기록 함수
        function recordCheckout() {
            $.ajax({
                url: '/attendance/checkout',
                type: 'POST',
                xhrFields: { withCredentials: true },
                success: function(response) {
                    alert('퇴근이 등록되었습니다.');
                    fetchAttendanceData('/attendance/weekly', 'weekly-attendance-body');
                },
                error: function(xhr, status, error) {
                    console.error('퇴근 등록에 실패했습니다:', error, xhr.status, xhr.responseJSON);
                    alert('퇴근 등록에 실패했습니다: ' + (xhr.responseJSON?.error || xhr.status));
                }
            });
        }

        // 페이지 로드 시 데이터 가져오기
        $(document).ready(function() {
            fetchAttendanceData('/attendance/weekly', 'weekly-attendance-body');
            if ("${sessionScope['user.admin']}" === "ok") {
                fetchAttendanceData('/attendance/today', 'employee-attendance-body');
            }
        });
    </script>
</body>
</html>