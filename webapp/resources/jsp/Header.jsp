<!-- 작성자: 최성현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header>
	<div class="container">
		<!-- 로고 클릭 시 index.jsp로 이동하도록 수정 -->
		<div id="logo">
			<a href="/">3부상조</a>
		</div>
		<nav>
			<ul class="nav-menu">
				<li class="nav-item"><a href="EmployeeRegistration">직원 등록</a>
					<ul class="dropdown-menu">
						<li><a href="/employeesRegister">직원 등록</a></li>
						<li><a href="/employeesList">직원 리스트 조회</a></li>
						<li><a href="/employeesDetails">직원 상세 조회</a></li>
						<!-- 관리자일 때만 회원가입 항목 표시 -->
						<c:if test="${not empty sessionScope.user && sessionScope.user.isAdmin}">
							<li><a href="/authSignup">회원가입</a></li>
						</c:if>
					</ul></li>
				<li class="nav-item"><a href="WorkScheduleAssignment">근무 방식 지정</a>
					<ul class="dropdown-menu">
						<li><a href="/workSchedule">근무 방식 선택</a></li>
						<li><a href="/workLocation">희망 근무지 선택</a></li>
					</ul></li>
				<!-- 관리자일 때만 인사 관리 메뉴 표시 -->
				<c:if test="${not empty sessionScope.user && sessionScope.user.isAdmin}">
					<li class="nav-item"><a href="HumanResourcesManagement">인사 관리</a>
						<ul class="dropdown-menu">
							<li><a href="/hrTransfer">보직 이동</a></li>
							<li><a href="/hrRetirement">퇴직 관리</a></li>
							<li><a href="/hrManagement">인사 관리</a></li>
						</ul></li>
				</c:if>
				<li class="nav-item"><a href="PayrollManagement">급여 관리</a>
					<ul class="dropdown-menu">
						<li><a href="/payrollList">급여 리스트 조회</a></li>
						<li><a href="/payrollGrade">직급별 급여 리스트</a></li>
					</ul></li>
				<li class="nav-item"><a href="VacationManagement">휴가 관리</a>
					<ul class="dropdown-menu">
						<li><a href="/vacationList">휴가 리스트 조회</a></li>
						<li><a href="/vacationApproval">휴가 승인 및 대기</a></li>
						<li><a href="/vacationInquiry">휴가현황</a></li>
					</ul></li>
				<c:if test="${not empty sessionScope.user}">
					<li class="nav-item user-info"><a href="#">${sessionScope.user.emp_name}님 환영합니다!</a>
						<ul class="dropdown-menu">
							<li><a href="/userProfile">내 정보</a></li>
							<li><a href="/authLogout">로그아웃</a></li>
						</ul></li>
				</c:if>
			</ul>
		</nav>
	</div>
</header>
