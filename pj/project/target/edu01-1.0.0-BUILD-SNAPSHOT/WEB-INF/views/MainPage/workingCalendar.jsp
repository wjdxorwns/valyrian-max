<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 할일 달력</title>
    <!-- FullCalendar CSS (CDN) -->
    <link href="<c:url value='/resources/css/KimJK/CSS_working_calendar.css' />" rel="stylesheet">
    <!-- FullCalendar & Plugins (CDN Only버전 라이브러리들) -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js"></script>
    <!-- 프로젝트 CSS -->
    <link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="/resources/jsp/Header.jsp" />
	
	<main>
		<jsp:include page="/resources/jsp/PayAside.jsp" />
		<div class="calendar-container">
			<h2>📅 내 할일 달력</h2>
			<div id="calendar"></div>
			<h3>📋 전체 일정 리스트</h3>
			<div id="event-list"></div>
		</div>
	</main>

	<!-- 사용자 스크립트 -->
    <script type="text/javascript">
    let calendar;

    // 일정 리스트 렌더링 함수
    function renderEventList(events) {
        let html = '<table id="event-list-table">';
        html += '<thead><tr><th>제목</th><th>시작일</th><th>종료일</th><th>설명</th></tr></thead><tbody>';
        if (events.length === 0) {
            html += '<tr><td colspan="4">등록된 일정이 없습니다.</td></tr>';
        } else {
            for (let i = 0; i < events.length; i++) {
                const ev = events[i];
                html += '<tr>'
                    + '<td>' + (ev.title || '') + '</td>'
                    + '<td>' + (ev.start ? ev.start.substring(0,10) : '') + '</td>'
                    + '<td>' + (ev.end ? ev.end.substring(0,10) : '') + '</td>'
                    + '<td>' + (ev.description || '') + '</td>'
                    + '</tr>';
            }
        }
        html += '</tbody></table>';
        document.getElementById('event-list').innerHTML = html;
    }

    // 서버에서 일정 조회
    function fetchAndRenderEventList() {
        fetch('/calendar/list', {
            method: 'GET',
            headers: { 'Accept': 'application/json' }
        })
        .then(resp => resp.json())
        .then(data => renderEventList(data));
    }

    // FullCalendar 초기화
    document.addEventListener('DOMContentLoaded', function () {
        const calendarEl = document.getElementById('calendar');
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek'
            },
            editable: true,
            eventResizableFromStart: true,
            events: {
                url: '/calendar/list',
                method: 'GET',
                headers: { 'Accept': 'application/json' }
            },
            dateClick: function (info) {
                const title = prompt('할 일을 입력하세요:');
                const comment = prompt('설명을 입력하세요 (선택):');
                if (title) {
                    fetch('/add', {
                        method: 'POST',
                        headers: { 
                            'Content-Type': 'application/json',
                            'Accept': 'application/json'
                        },
                        body: JSON.stringify({
                            title: title,
                            comment: comment,
                            start_day: info.dateStr,
                            end_day: info.dateStr
                        })
                    }).then(() => {
                        calendar.refetchEvents();
                        fetchAndRenderEventList();
                    });
                }
            },
            eventClick: function (info) {
                if (confirm("'" + info.event.title + "' 일정을 삭제할까요?")) {
                    fetch(`/delete/${info.event.extendedProps.id}`, {
                        method: 'POST',
                        headers: { 
                            'Content-Type': 'application/json',
                            'Accept': 'application/json'
                        }
                    }).then(() => {
                        calendar.refetchEvents();
                        fetchAndRenderEventList();
                    });
                }
            },
            eventDrop: function (info) {
                const updated = {
                    calendar_idx: info.event.extendedProps.id,
                    title: info.event.title,
                    comment: info.event.extendedProps.description || '',
                    start_day: info.event.startStr,
                    end_day: info.event.endStr || info.event.startStr
                };
                fetch('/update', {
                    method: 'POST',
                    headers: { 
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    },
                    body: JSON.stringify(updated)
                }).then(() => {
                    calendar.refetchEvents();
                    fetchAndRenderEventList();
                });
            },
            eventDidMount: function (info) {
                if (info.event.extendedProps.description) {
                    new Tooltip(info.el, {
                        title: info.event.extendedProps.description,
                        placement: 'top',
                        trigger: 'hover',
                        container: 'body'
                    });
                }
            }
        });
        calendar.render();
        fetchAndRenderEventList();
    });
    </script>

    <jsp:include page="/resources/jsp/Footer.jsp" />
</body>
</html>
