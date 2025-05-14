<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
/* 모달 관련 CSS (별도 CSS 파일에 추가하는 것이 좋음) */
.modal-overlay {
	display: none; /* 초기에는 숨김 */
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5); /* 반투명 검은색 배경 */
	z-index: 10001; /* 헤더나 다른 요소보다 위에 오도록 설정 */
	justify-content: center;
	align-items: center;
}

.modal-content {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	width: 90%;
	max-width: 500px; /* 모달 최대 너비 */
	position: relative;
	box-sizing: border-box;
	max-height: 80vh; /* 모달 최대 높이 */
	overflow-y: auto; /* 내용이 많으면 스크롤 */
}

.modal-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #eee;
	padding-bottom: 10px;
	margin-bottom: 15px;
}

.modal-header h3 {
	margin: 0;
	font-size: 20px;
	color: #333;
}

.modal-close-btn {
	background: none;
	border: none;
	font-size: 24px;
	color: #aaa;
	cursor: pointer;
	padding: 0 5px;
}

.modal-close-btn:hover {
	color: #333;
}

.notification-list {
	list-style: none;
	padding: 0;
	margin: 0;
}

.notification-item {
	padding: 10px 0;
	border-bottom: 1px solid #f5f5f5;
}

.notification-item:last-child {
	border-bottom: none;
}

.notification-item a {
	text-decoration: none;
	color: #555;
	display: block;
}

.notification-item a:hover {
	color: #007bff;
	background-color: #f9f9f9;
}

.notification-item p {
	margin: 0;
	font-size: 14px;
}

.notification-item .timestamp {
	font-size: 12px;
	color: #999;
	margin-top: 5px;
	text-align: right;
}

/* 알림이 없을 때 */
.no-notifications {
	text-align: center;
	color: #666;
	padding: 20px 0;
}

/* 기존 헤더 CSS는 여기에 포함되지 않습니다. */
/* .nav-item.notification-icon a의 href 속성을 제거했으므로, */
/* 이 스타일은 필요하지 않습니다. */
/* .nav-item.notification-icon a { cursor: pointer; } */
</style>
</head>
<body>
	<header>
		<div class="container">
			<div id="logo">
				<a href="/">3부상조</a>
			</div>
			<nav>
				<ul class="nav-menu">
					<c:choose>
						<c:when test='${sessionScope.permissionvo.can_access_employee eq 1 or sessionScope.employeeVO.dept_name eq "슈퍼관리자"}'>
							<li class="nav-item"><a href="/personnelChange">인사
									관리</a>
								<ul class="dropdown-menu">
									<li><a href="/personnelChange">근무지 정보 관리</a></li>
									<li><a href="/empDataList">직원 현황 관리</a></li>
									<li><a href="/hrManagement">퇴직자 정보 관리</a></li>
									<li><a href="/empDataRegister">신규 직원 등록</a></li>
								</ul></li>
						</c:when>
						<c:otherwise>
							<li class="nav-item">
								<a href="#" onclick="alert('인사 관리 권한이 없습니다.'); return false;">인사 관리</a>
								<ul class="dropdown-menu">
									<li><a href="#" onclick="alert('인사 관리 권한이 없습니다.'); return false;">근무지 정보 관리</a></li>
									<li><a href="#" onclick="alert('인사 관리 권한이 없습니다.'); return false;">직원 현황 관리</a></li>
									<li><a href="#" onclick="alert('인사 관리 권한이 없습니다.'); return false;">퇴직자 정보 관리</a></li>
									<li><a href="#" onclick="alert('인사 관리 권한이 없습니다.'); return false;">신규 직원 등록</a></li>
								</ul>
							</li>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test='${sessionScope.permissionvo.can_access_salary eq 1 or sessionScope.employeeVO.dept_name eq "슈퍼관리자"}'>
							<li class="nav-item"><a href="/pay">급여 관리</a>
								<ul class="dropdown-menu">
									<li><a href="/pay">직원 급여 리스트</a></li>
									<li><a href="/adminPay">개인 급여 지급 및 수정</a></li>
								</ul>
							</li>
						</c:when>
						<c:otherwise>
							<li class="nav-item">
								<a href="/pay" onclick="alert('급여 관리 권한이 없습니다.'); return false;">급여 관리</a>
								<ul class="dropdown-menu">
									<li><a href="/paylist" onclick="alert('급여 관리 권한이 없습니다.'); return false;">직원 급여 리스트</a></li>
									<li><a href="${pageContext.request.contextPath}/adminPay" onclick="alert('급여 관리 권한이 없습니다.'); return false;">개인 급여 명세서 조회</a></li>
								</ul>
							</li>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test='${sessionScope.permissionvo.can_access_vacation eq 1 or sessionScope.employeeVO.dept_name eq "슈퍼관리자"}'>
							<li class="nav-item"><a href="/vacationInquiry">휴가 관리</a>
								<ul class="dropdown-menu">
									<li><a href="/vacationList">휴가 리스트 조회</a></li>
									<li><a href="/vacationApproval">휴가 승인 및 대기</a></li>
									<li><a href="/vacationInquiry">휴가현황</a></li>
								</ul></li>
						</c:when>
						<c:otherwise>
							<li class="nav-item">
								<a href="#" onclick="alert('휴가 관리 권한이 없습니다.'); return false;">휴가 관리</a>
								<ul class="dropdown-menu">
									<li><a href="#" onclick="alert('휴가 관리 권한이 없습니다.'); return false;">휴가 리스트 조회</a></li>
									<li><a href="#" onclick="alert('휴가 관리 권한이 없습니다.'); return false;">휴가 승인 및 대기</a></li>
									<li><a href="#" onclick="alert('휴가 관리 권한이 없습니다.'); return false;">휴가현황</a></li>
								</ul>
							</li>
						</c:otherwise>
					</c:choose>
					<li class="nav-item">
						<a href="/PermissionRequest?emp_idx=${sessionScope.employeeVO.emp_idx}">권한 관리</a>
						<ul class="dropdown-menu">
							<c:choose>
								<c:when test='${sessionScope.employeeVO.dept_name == "슈퍼관리자"}'>
									<li>
										<a href="/Permission?emp_idx=${sessionScope.employeeVO.emp_idx}">권한 부여</a>
									</li>
									<li>
										<a href="/PermissionRequest?emp_idx=${sessionScope.employeeVO.emp_idx}">승인 요청</a>
									</li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="/PermissionRequest?emp_idx=${sessionScope.employeeVO.emp_idx}">승인 요청</a>
									</li>
								</c:otherwise>						
							</c:choose>
						</ul>
					</li>

					<c:if test="${empty sessionScope.userVO}">
						<li class="nav-item"><a href="login">로그인</a></li>
					</c:if>
					<c:if test="${not empty sessionScope.userVO}">
						<li class="nav-item notification-icon"><a href="#" title="알림"
							onclick="openNotificationModal(event);"> <i
								class="fas fa-bell"></i> <span class="notification-badge">3</span>
						</a></li>
					</c:if>
					<c:if test="${not empty sessionScope.userVO}">
						<li class="nav-item user-info"><a href="#">마이 페이지</a>
							<ul class="dropdown-menu">
								<li><a href="/myPage">내 프로필</a></li>
								<li><a href="/logout">로그아웃</a></li>
								<li><a href="/qna">문의 사항</a></li>
							</ul></li>
					</c:if>
				</ul>
			</nav>
		</div>
	</header>

	<div id="notificationModal" class="modal-overlay">
		<div class="modal-content">
			<div class="modal-header">
				<h3>알림</h3>
				<button class="modal-close-btn" onclick="closeNotificationModal();">&times;</button>
			</div>
			<div class="modal-body">
				<ul class="notification-list">
					<li class="notification-item"><a href="/notification/123">
							<p>새로운 휴가 신청이 접수되었습니다.</p> <span class="timestamp">2025-05-09
								14:30</span>
					</a></li>
					<li class="notification-item"><a href="/notification/124">
							<p>급여 명세서가 발행되었습니다.</p> <span class="timestamp">2025-05-08
								10:00</span>
					</a></li>
					<li class="notification-item"><a href="/notification/125">
							<p>인사팀에서 보낸 공지사항을 확인하세요.</p> <span class="timestamp">2025-05-07
								09:15</span>
					</a></li>
				</ul>
			</div>
		</div>
	</div>
	<script>
		function openNotificationModal(event) {
			event.preventDefault(); // <a> 태그의 기본 동작 (페이지 이동) 방지
			const modal = document.getElementById('notificationModal');
			modal.style.display = 'flex'; // 모달을 보이게 함 (flexbox를 사용하여 중앙 정렬)

			// 모달 바깥 클릭 시 닫기
			modal.addEventListener('click', function(e) {
				if (e.target === modal) { // 정확히 오버레이를 클릭했을 때만 닫히도록
					closeNotificationModal();
				}
			});
		}

		function closeNotificationModal() {
			const modal = document.getElementById('notificationModal');
			modal.style.display = 'none'; // 모달을 숨김
		}

		// 선택 사항: ESC 키를 눌렀을 때 모달 닫기
		document.addEventListener('keydown', function(e) {
			if (e.key === 'Escape' || e.key === 'Esc') {
				const modal = document.getElementById('notificationModal');
				if (modal.style.display === 'flex') {
					closeNotificationModal();
				}
			}
		});
	</script>
</body>
</html>