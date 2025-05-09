<!-- 작성자: 최성현  수정자: 정택준, 김재겸 -->
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
				<!-- 관리자일 때만 인사 관리 메뉴 표시 -->

				<li class="nav-item"><a href="HumanResourcesManagement">인사
						관리</a>
					<ul class="dropdown-menu">
						<li><a href="/hrTransfer">직원 근무지 등록</a></li>
						<li><a href="/hrRetirement">직원 리스트 조회 및 관리</a></li>
						<li><a href="/hrManagement">퇴사 데이터 관리</a></li>
						<li><a href="/hrManagement">직원 등록</a></li>
					</ul></li>

				<li class="nav-item"><a href="PayrollManagement?emp_idx=${sessionScope.employeeVO.emp_idx}">급여 관리</a>
					<ul class="dropdown-menu">
						<li><a href="/payrollList?emp_idx=${sessionScope.employeeVO.emp_idx}">본인 급여 조회</a></li>
						<li><a href="/payrollGrade?emp_idx=${sessionScope.employeeVO.emp_idx}">급여 조정 및 지급 명세서 출력</a></li>
					</ul></li>
				<li class="nav-item"><a href="/VacationManagement?emp_idx=${sessionScope.employeeVO.emp_idx}">휴가 관리</a>
					<ul class="dropdown-menu">
						<li><a href="/vacationList?emp_idx=${sessionScope.employeeVO.emp_idx}">휴가 리스트 조회</a></li>
						<li><a href="/vacationInquiry?emp_idx=${sessionScope.employeeVO.emp_idx}">내 휴가 현황</a></li>
						<li><a href="/vacationApproval?emp_idx=${sessionScope.employeeVO.emp_idx}">휴가 조정 및 신청</a></li>
					</ul></li>
				<li class="nav-item">
					<a href="/PermissionRequest?emp_idx=${sessionScope.employeeVO.emp_idx}">권한 관리</a>
					<ul class="dropdown-menu">
						<c:choose>
							<c:when test='${sessionScope.role == "슈퍼관리자"}'>
								<li>
									<a href="/Permission?emp_idx=${sessionScope.employeeVO.emp_idx}">권한 부여</a>
								</li>
								<li>
									<a href="/PermissionRequest?emp_idx=${sessionScope.employeeVO.emp_idx}">요청 승인</a>
								</li>
							</c:when>
							<%-- <c:when test='${sessionScope.role == "관리자"}'>
								<li>
									<a href="/PermissionRequest?emp_idx=${sessionScope.employeeVO.emp_idx}">요청 승인</a>
								</li>
							</c:when> --%>
							<c:otherwise>
								<li>
									<a href="/PermissionRequest?emp_idx=${sessionScope.employeeVO.emp_idx}">요청 승인</a>
								</li>
							</c:otherwise>						
						</c:choose>
					</ul>
				</li>


				<c:if test="${empty sessionScope.userVO}">
					<li class="nav-item"><a href="login">로그인</a></li>
				</c:if>
				<c:if test="${not empty sessionScope.userVO}">
					<li class="nav-item user-info"><a href="#">${sessionScope.userVO.emp_name}님
							환영합니다!</a>
						<ul class="dropdown-menu">
							<li><a href="/userProfile?emp_idx=${sessionScope.employeeVO.emp_idx}">내 정보</a></li>
							<li><a href="/logout">로그아웃</a></li>
							<li><a href="">문의사항</a></li>
						</ul></li>
				</c:if>
			</ul>
		</nav>
	</div>
</header>