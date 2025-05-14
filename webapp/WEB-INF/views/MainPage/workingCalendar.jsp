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
		<div class="calendar-wrapper">
			<div class="calendar-container">
				<h2>📅 내 할일 달력</h2>
				<div id="calendar"></div>
			</div>
			<div class="event-list-container">
				<h3>📋 전체 일정 리스트</h3>
				<div id="event-list"></div>
			</div>
		</div>

		<!-- 일정 추가/상세보기 모달 -->
		<div id="eventModal" class="modal">
			<div class="modal-overlay"></div>
			<div class="modal-content">
				<div class="modal-header">
					<h3 id="modalTitle">일정 추가</h3>
					<span class="close">&times;</span>
				</div>
				<div class="modal-body">
					<form id="eventForm">
						<input type="hidden" id="eventId">
						<div class="form-group">
							<label for="eventTitle">제목</label>
							<input type="text" id="eventTitle" required>
						</div>
						<div class="form-group">
							<label for="eventStart">시작일</label>
							<input type="date" id="eventStart" required>
						</div>
						<div class="form-group">
							<label for="eventEnd">종료일</label>
							<input type="date" id="eventEnd" required>
						</div>
						<div class="form-group">
							<label for="eventDescription">설명</label>
							<textarea id="eventDescription" rows="3"></textarea>
						</div>
						<div class="btn-group">
							<button type="button" class="btn btn-danger" id="deleteBtn" style="display: none;">삭제</button>
							<button type="submit" class="btn btn-primary">추가</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>

	<!-- 사용자 스크립트 -->
    <script type="text/javascript">
    let calendar;
    const modal = document.getElementById('eventModal');
    const closeBtn = document.getElementsByClassName('close')[0];
    const eventForm = document.getElementById('eventForm');
    const deleteBtn = document.getElementById('deleteBtn');

    // 디버깅을 위한 로그 함수
    function debugLog(message, data = null) {
        console.log(`[Calendar Debug] ${message}`, data || '');
    }

    // 에러 처리 함수
    function handleError(error, message) {
        console.error(`[Calendar Error] ${message}:`, error);
        alert('오류가 발생했습니다. 다시 시도해주세요.');
    }

    // 모달 닫기
    function closeModal() {
        debugLog('모달 닫기');
        modal.style.display = "none";
        document.body.style.overflow = '';
        resetForm();
    }

    // 폼 초기화
    function resetForm() {
        debugLog('폼 초기화');
        eventForm.reset();
        deleteBtn.style.display = 'none';
        document.getElementById('modalTitle').textContent = '일정 추가';
        document.querySelector('button[type="submit"]').textContent = '추가';
    }

    // 일정 리스트 렌더링 함수
    function renderEventList(events) {
        debugLog('일정 리스트 렌더링', events);
        let html = '<table id="event-list-table">';
        html += '<thead><tr><th>제목</th><th>시작일</th><th>종료일</th><th>설명</th></tr></thead><tbody>';
        if (!events || events.length === 0) {
            html += '<tr><td colspan="4">등록된 일정이 없습니다.</td></tr>';
        } else {
            for (let i = 0; i < events.length; i++) {
                const ev = events[i];
                html += '<tr onclick="openDetailModal(' + JSON.stringify(ev).replace(/"/g, '&quot;') + ')" style="cursor: pointer;">'
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
        debugLog('일정 목록 조회 시작');
        fetch('/calendar/list', {
            method: 'GET',
            headers: { 'Accept': 'application/json' }
        })
        .then(resp => {
            if (!resp.ok) {
                throw new Error('일정 목록 조회 실패');
            }
            return resp.json();
        })
        .then(data => {
            debugLog('일정 목록 조회 성공', data);
            renderEventList(data);
        })
        .catch(error => handleError(error, '일정 목록 조회 중 오류 발생'));
    }

    // 일정 추가 모달 열기
    function openModal(event = null) {
        debugLog('모달 열기', event);
        try {
            const modal = document.getElementById('eventModal');
            const modalTitle = document.getElementById('modalTitle');
            const eventTitle = document.getElementById('eventTitle');
            const eventStart = document.getElementById('eventStart');
            const eventEnd = document.getElementById('eventEnd');
            const eventDescription = document.getElementById('eventDescription');
            const deleteBtn = document.getElementById('deleteBtn');
            const submitBtn = document.querySelector('button[type="submit"]');

            // 모달 초기화
            modalTitle.textContent = '일정 추가';
            eventTitle.value = '';
            eventStart.value = '';
            eventEnd.value = '';
            eventDescription.value = '';
            
            // 입력 필드 활성화
            eventTitle.disabled = false;
            eventStart.disabled = false;
            eventEnd.disabled = false;
            eventDescription.disabled = false;
            
            // 버튼 상태 설정
            deleteBtn.style.display = 'none';
            submitBtn.style.display = 'inline-block';
            submitBtn.textContent = '추가';
            
            modal.style.display = "block";
            document.body.style.overflow = 'hidden';
        } catch (error) {
            handleError(error, '모달 열기 중 오류 발생');
        }
    }

 // 일정 상세보기 모달 열기
    function openDetailModal(event) {
        debugLog('상세보기 모달 열기', event);
        try {
            // ... (필드 세팅 부분 동일)
            const eventTitle = document.getElementById('eventTitle');
            const eventStart = document.getElementById('eventStart');
            const eventEnd = document.getElementById('eventEnd');
            const eventDescription = document.getElementById('eventDescription');
            const deleteBtn = document.getElementById('deleteBtn');
            const submitBtn = document.querySelector('button[type="submit"]');
            const modalTitle = document.getElementById('modalTitle');

            modalTitle.textContent = '일정 상세보기';

            // 날짜 형식 변환
            const startDate = event.start instanceof Date ? event.start.toISOString().split('T')[0] : event.start;
            const endDate = event.end instanceof Date ? event.end.toISOString().split('T')[0] : event.end;
            eventTitle.value = event.title || '';
            eventStart.value = startDate;
            eventEnd.value = endDate;
            eventDescription.value = event.description || '';

            // 입력 필드 비활성화
            eventTitle.disabled = true;
            eventStart.disabled = true;
            eventEnd.disabled = true;
            eventDescription.disabled = true;

            // 버튼 상태 설정
            deleteBtn.style.display = 'inline-block';
            submitBtn.style.display = 'none';

            // 기존 수정 버튼 제거
            const existingEditBtn = deleteBtn.parentNode.querySelector('.btn-edit');
            if (existingEditBtn) existingEditBtn.remove();

            // 수정 버튼 생성 및 추가
            const editBtn = document.createElement('button');
            editBtn.className = 'btn btn-primary btn-edit';
            editBtn.textContent = '수정';
            editBtn.type = 'button';
            editBtn.style.marginRight = '10px';
            deleteBtn.parentNode.insertBefore(editBtn, deleteBtn);

            // 수정 버튼 클릭 시
            editBtn.onclick = function() {
                // 입력 필드 활성화
                eventTitle.disabled = false;
                eventStart.disabled = false;
                eventEnd.disabled = false;
                eventDescription.disabled = false;

                // 버튼 상태 변경
                editBtn.style.display = 'none';
                deleteBtn.style.display = 'none';
                submitBtn.style.display = 'inline-block';
                submitBtn.textContent = '저장';

                // 기존 폼 핸들러 제거 후 새로 등록 (중복 방지)
                eventForm.onsubmit = function(e) {
                    e.preventDefault();
                    const formData = {
                        calendar_idx: event.id,
                        title: eventTitle.value,
                        start_day: eventStart.value,
                        end_day: eventEnd.value,
                        comment: eventDescription.value
                    };

                    if (new Date(formData.start_day) > new Date(formData.end_day)) {
                        alert('종료일은 시작일보다 이후여야 합니다.');
                        return;
                    }

                    fetch('/calendar/update', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json'
                        },
                        body: JSON.stringify(formData)
                    })
                    .then(resp => {
                        if (!resp.ok) throw new Error('일정 수정 실패');
                        return resp;
                    })
                    .then(() => {
                        calendar.refetchEvents();
                        fetchAndRenderEventList();
                        modal.style.display = "none";
                        alert('일정이 수정되었습니다.');
                        // 폼 핸들러를 다시 추가 모드로 복원
                        eventForm.onsubmit = addFormHandler;
                    })
                    .catch(error => {
                        handleError(error, '일정 수정 중 오류 발생');
                        calendar.refetchEvents();
                    });
                };
            };

            // 삭제 버튼 이벤트 핸들러
            deleteBtn.onclick = function() {
                if (confirm('정말로 이 일정을 삭제하시겠습니까?')) {
                    var deleteUrl = '/calendar/delete/' + event.id; // 백틱 대신 + 연산자
                    fetch(deleteUrl, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json'
                        }
                    })
                    .then(resp => {
                        if (!resp.ok) throw new Error('일정 삭제 실패');
                        return resp;
                    })
                    .then(() => {
                        calendar.refetchEvents();
                        fetchAndRenderEventList();
                        modal.style.display = "none";
                        alert('일정이 삭제되었습니다.');
                    })
                    .catch(error => {
                        handleError(error, '일정 삭제 중 오류 발생');
                        calendar.refetchEvents();
                    });
                }
            };

            modal.style.display = "block";
            document.body.style.overflow = 'hidden';
        } catch (error) {
            handleError(error, '상세보기 모달 열기 중 오류 발생');
        }
    }

    // 새 일정 추가용 폼 핸들러(최초 1회만 등록)
    function addFormHandler(e) {
        e.preventDefault();
        debugLog('폼 제출');
        try {
            const formData = {
                title: document.getElementById('eventTitle').value,
                start_day: document.getElementById('eventStart').value,
                end_day: document.getElementById('eventEnd').value,
                comment: document.getElementById('eventDescription').value
            };

            if (new Date(formData.start_day) > new Date(formData.end_day)) {
                alert('종료일은 시작일보다 이후여야 합니다.');
                return;
            }

            const url = '/calendar/add';
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(formData)
            })
            .then(resp => {
                if (!resp.ok) throw new Error('일정 저장 실패');
                return resp;
            })
            .then(() => {
                calendar.refetchEvents();
                fetchAndRenderEventList();
                modal.style.display = "none";
                resetForm();
                alert('일정이 저장되었습니다.');
            })
            .catch(error => handleError(error, '일정 저장 중 오류 발생'));
        } catch (error) {
            handleError(error, '폼 제출 중 오류 발생');
        }
    }
    // 최초 한 번만 등록
    eventForm.onsubmit = addFormHandler;


    window.onclick = function(event) {
        const modal = document.getElementById('eventModal');
        if (event.target == modal) {
            closeModal();
        }
    }

    // FullCalendar 초기화
    document.addEventListener('DOMContentLoaded', function () {
        debugLog('FullCalendar 초기화 시작');
        try {
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
                    headers: { 'Accept': 'application/json' },
                    failure: function(error) {
                        handleError(error, '일정 로드 중 오류 발생');
                    }
                },
                dateClick: function (info) {
                    debugLog('날짜 클릭', info);
                    openModal();
                    document.getElementById('eventStart').value = info.dateStr;
                    document.getElementById('eventEnd').value = info.dateStr;
                },
                eventClick: function (info) {
                    console.log('일정 클릭 이벤트 발생');
                    console.log('클릭된 일정 정보:', {
                        id: info.event.id,
                        calendar_idx: info.event.extendedProps?.calendar_idx,
                        title: info.event.title,
                        start: info.event.start,
                        end: info.event.end,
                        description: info.event.extendedProps?.description
                    });
                    
                    const event = {
                        id: info.event.extendedProps?.calendar_idx || info.event.id,
                        title: info.event.title,
                        start: info.event.start,
                        end: info.event.end,
                        description: info.event.extendedProps?.description || ''
                    };
                    console.log('변환된 일정 정보:', event);
                    openDetailModal(event);
                },
                eventDrop: function (info) {
                    debugLog('일정 드래그', info);
                    const updated = {
                        calendar_idx: info.event.id,
                        title: info.event.title,
                        comment: info.event.extendedProps?.description || '',
                        start_day: info.event.startStr,
                        end_day: info.event.endStr || info.event.startStr
                    };
                    fetch('/calendar/update', {
                        method: 'POST',
                        headers: { 
                            'Content-Type': 'application/json',
                            'Accept': 'application/json'
                        },
                        body: JSON.stringify(updated)
                    })
                    .then(resp => {
                        if (!resp.ok) throw new Error('일정 업데이트 실패');
                        return resp;
                    })
                    .then(() => {
                        calendar.refetchEvents();
                        fetchAndRenderEventList();
                    })
                    .catch(error => {
                        handleError(error, '일정 드래그 중 오류 발생');
                        calendar.refetchEvents();
                    });
                }
            });
            calendar.render();
            fetchAndRenderEventList();
            debugLog('FullCalendar 초기화 완료');
        } catch (error) {
            handleError(error, 'FullCalendar 초기화 중 오류 발생');
        }
    });
    </script>

    <jsp:include page="/resources/jsp/Footer.jsp" />
</body>
</html>