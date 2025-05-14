<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 작성자: 한찬욱 | 기여자: 김재겸-->
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>권한 요청</title>

<!-- 화면(CSS) 링크 -->

<link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />"
	rel="stylesheet">


<!-- 폰트 링크 -->
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<!-- Font Awesome for social icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style type="text/css">
/* 기본 스타일 */
.main_body {
	margin-top: 50px;
	margin-left: 200px;
}

table {
	width: 100%
}

table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	text-align: center;
	padding: 2px;
}

tr, th, td {
	width: 100px;
}

tr {
	background-color: skyblue;
}

button {
	width: 70px;
	padding: 2px;
	margin-top: 5px;
	margin-bottom: 5px;
}

.select_box {
	border: none;
	background: none;
	font-size: inherit;
}

.buttons {
	text-align: right;
	margin-right: 50px;
}

/* 모달 스타일 - 네임스페이스 적용 */
.perm-request-modal {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 9999;
	opacity: 0;
	transition: opacity 0.3s ease-in-out;
}

.perm-request-modal.show {
	opacity: 1;
}

.perm-request-modal .modal-content {
	background: #fff;
	margin: 5% auto;
	padding: 20px;
	width: 80%;
	max-width: 700px;
	border-radius: 8px;
	position: relative;
	max-height: 80vh;
	overflow: hidden;
}

.perm-request-modal .close-btn {
	position: absolute;
	top: 10px;
	right: 20px;
	cursor: pointer;
	font-size: 24px;
	z-index: 10000;
}

.perm-request-modal .modal-body-wrapper {
	position: relative;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.perm-request-modal .modal-content-inner {
	position: relative;
	width: 100%;
	height: 100%;
	overflow: auto;
	/* 모달 내부 컨텐츠 스타일 초기화 */
	all: initial;
	display: block;
	font-family: inherit;
}

.perm-request-modal .loading {
	text-align: center;
	padding: 20px;
	font-size: 18px;
	color: #666;
}

/* 모달 내부 컨텐츠 스타일 격리 */
.perm-request-modal .modal-content-inner * {
	box-sizing: border-box;
	font-family: inherit;
}

.perm-request-modal .modal-content-inner table {
	width: 100%;
	border-collapse: collapse;
}

.perm-request-modal .modal-content-inner th, .perm-request-modal .modal-content-inner td
	{
	padding: 8px;
	border: 1px solid #ddd;
}

/* workingArrangement.jsp 스타일 통합 */
.perm-request-modal .modal-content-inner .working_arrange_main {
	padding: 20px;
}

.perm-request-modal .modal-content-inner .style_input {
	margin-bottom: 20px;
}

.perm-request-modal .modal-content-inner .style_input input {
	width: 100%;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.perm-request-modal .modal-content-inner .container_table {
	width: 100%;
	overflow-x: auto;
}

.perm-request-modal .modal-content-inner .style_table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

.perm-request-modal .modal-content-inner .style_table thead {
	background-color: #003399;
	color: white;
}

.perm-request-modal .modal-content-inner .style_table th,
	.perm-request-modal .modal-content-inner .style_table td {
	padding: 12px;
	text-align: center;
	border: 1px solid #ddd;
}

.perm-request-modal .modal-content-inner .style_table select {
	width: 100%;
	padding: 6px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.perm-request-modal .modal-content-inner .style_button {
	text-align: right;
	margin-top: 20px;
}

.perm-request-modal .modal-content-inner .style_button button {
	padding: 8px 20px;
	background-color: #003399;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.perm-request-modal .modal-content-inner .style_button button:hover {
	background-color: #002266;
}
</style>


</head>

<body>
	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />

	<jsp:include page="/resources/jsp/PermissionAside.jsp" />

	<main>
		<div class="main_body">
			<div>
				<div>
					<!-- 1. 전자 결제 요청 테이블 -->
					<h2>전자 결제</h2>
					<h4>관리자에게 결제 요청</h4>
				</div>
				<br>
				<c:if test="${not empty message}">
					<div class="alert alert-info" role="alert">
						${message}
					</div>
				</c:if>
				<table>
					<thead>
						<tr>
							<th>부서</th>
							<th>이름</th>
							<th>권한 종류</th>
							<th>상태</th>
							<th style="width: 150px;">본인 사인</th>
							<th style="width: 150px;">관리자 사인</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<!-- 부서 선택 -->
							<td><input class="insert_box" type="text" name="team"
								value="${sessionScope.employeeVO.team}"
								placeholder="${sessionScope.employeeVO.team}" readonly required></td>
							<!-- 이름 작성 -->
							<td><input class="insert_box" type="text" name="name"
								value="${sessionScope.userVO.emp_name}"
								placeholder="${sessionScope.userVO.emp_name}" readonly required></td>
							<!-- 권한 종류 선택 -->
							<td><select name="permission">
									<c:choose>
										<c:when test="${sessionScope.role == '관리자'}">
											<option>휴가 요청</option>
											<option>근무지 이동 요청</option>
											<option>보직 이동 요청</option>
											<option>퇴사 요청</option>
										</c:when>
										<c:when test="${sessionScope.role == '슈퍼관리자'}">
											<option>휴가 요청</option>
											<option>근무지 이동 요청</option>
											<option>퇴사 요청</option>
										</c:when>
										<c:otherwise>
											<option>휴가 요청</option>
											<option>근무지 이동 요청</option>
											<option>보직 이동 요청</option>
											<option>퇴사 요청</option>
										</c:otherwise>
									</c:choose>
							</select></td>
							<!-- 상태 자동 지정정 -->
							<td><input type="hidden" name="agree" value="대기"> <span>대기</span>
								</input></td>
							<td rowspan="2"></td>
							<td rowspan="2"></td>
						</tr>

					</tbody>
				</table>
				<br>
				<!-- 팝업창으로 이동 -->
				<div class="buttons">
					<button type="button" onclick="submitForm()">신 청</button>
				</div>
				<br> <br>

				<c:if
					test="${sessionScope.role == '관리자' or sessionScope.role == '슈퍼관리자'}">
					<!-- 2. 나의 전자 결제 요청 현황 테이블 -->
					<h2>신청 현황</h2>
					<h4>관리자에게 요청한 현황</h4>
					<div>
						<table>
							<thead>
								<tr>
									<th>부서</th>
									<th>이름</th>
									<th>권한 종류</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty permissionRequestList}">
										<c:forEach items="${permissionRequestList}" var="request">
											<c:if test="${request.permissionVO.can_access_employee == 1}">
												<tr>
													<td><input class="select_box" type="text"
														value="${request.employeeVO.team}" readonly></td>
													<td><input class="select_box" type="text"
														value="${request.userVO.emp_name}" readonly></td>
													<td><input class="select_box" type="text"
														value="직원 정보" readonly></td>
													<td><input class="select_box" type="text" value="대기"
														readonly></td>
												</tr>
											</c:if>
											<c:if test="${request.permissionVO.can_access_worktype == 1}">
												<tr>
													<td><input class="select_box" type="text"
														value="${request.employeeVO.team}" readonly></td>
													<td><input class="select_box" type="text"
														value="${request.userVO.emp_name}" readonly></td>
													<td><input class="select_box" type="text"
														value="근무 방식" readonly></td>
													<td><input class="select_box" type="text" value="대기"
														readonly></td>
												</tr>
											</c:if>
											<c:if
												test="${request.permissionVO.can_access_personnel == 1}">
												<tr>
													<td><input class="select_box" type="text"
														value="${request.employeeVO.team}" readonly></td>
													<td><input class="select_box" type="text"
														value="${request.userVO.emp_name}" readonly></td>
													<td><input class="select_box" type="text"
														value="인사 발령" readonly></td>
													<td><input class="select_box" type="text" value="대기"
														readonly></td>
												</tr>
											</c:if>
											<c:if test="${request.permissionVO.can_access_salary == 1}">
												<tr>
													<td><input class="select_box" type="text"
														value="${request.employeeVO.team}" readonly></td>
													<td><input class="select_box" type="text"
														value="${request.userVO.emp_name}" readonly></td>
													<td><input class="select_box" type="text"
														value="급여 권한" readonly></td>
													<td><input class="select_box" type="text" value="대기"
														readonly></td>
												</tr>
											</c:if>
											<c:if test="${request.permissionVO.can_access_vacation == 1}">
												<tr>
													<td><input class="select_box" type="text"
														value="${request.employeeVO.team}" readonly></td>
													<td><input class="select_box" type="text"
														value="${request.userVO.emp_name}" readonly></td>
													<td><input class="select_box" type="text"
														value="휴가 권한" readonly></td>
													<td><input class="select_box" type="text" value="대기"
														readonly></td>
												</tr>
											</c:if>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="6">신청 중인 내역이 없습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					<br>
				</c:if>
			</div>

			<div class="buttons">
				<button type="button" onclick="goToMain()">돌아가기</button>
			</div>

		</div>
		<br>
	</main>

	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />
</body>

<script type="text/javascript">
			// 권한 종류에 따른 팝업 내용 매핑
			const permissionModalMap = {
				'휴가 요청': '/vacationApproval?emp_idx=${sessionScope.employeeVO.emp_idx}',
				'근무지 이동 요청': '/workingArrangement?emp_idx=${sessionScope.employeeVO.emp_idx}',
				'보직 이동 요청': '~~~보직이동 요청 경로~~~~',
				'퇴사 요청': '~~~퇴사 요청 경로~~~~'	
			};
		
			// submitForm 함수
			function submitForm() {
				const container = document.querySelector('.main_body');
				const nameInput = container.querySelector('input[name="name"]');
				const permissionSelect = container.querySelector('select[name="permission"]');
				const selectedPermission = permissionSelect.options[permissionSelect.selectedIndex].text;

				if (nameInput && nameInput.value.trim() !== '') {
					openPopup(permissionModalMap[selectedPermission]);
				} else {
					alert('모든 필수 입력값을 입력해주세요.');
				}
			}
		
			// openPopup 함수
			function openPopup(url) {
				window.open(url, '근무지이동', 'width=900,height=700,scrollbars=yes');
			}
		
			// goToMain 함수
			function goToMain() {
				window.location.href = "/index?emp_idx=${sessionScope.employeeVO.emp_idx}";
			}
		
			// DOM이 로드된 후 이벤트 리스너 등록
			document.addEventListener('DOMContentLoaded', function() {
				// ESC 키로 팝업 닫기
				document.addEventListener('keydown', function(event) {
					if (event.key === 'Escape') {
						closeModal();
					}
				});

				// 팝업 외부 클릭시 닫기
				document.getElementById('modalOverlay').addEventListener('click', function(event) {
					if (event.target === this) {
						closeModal();
					}
				});
			});
			</script>

</html>