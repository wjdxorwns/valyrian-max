<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 작성자: 김재겸 | 기여자: 한찬욱, 김용호 -->
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>권한 요청</title>

<!-- 화면(CSS) 링크 -->

<link href="<c:url value='/resources/css/KimYH/permission.css' />"
	rel="stylesheet">
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

</head>

<body>
	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />


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
					<div class="alert alert-info" role="alert">${message}</div>
				</c:if>
				<table>
					<thead>
						<tr>
							<th>부서</th>
							<th>이름</th>
							<th>권한 종류</th>
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
											<option>퇴사 요청</option>
										</c:otherwise>
									</c:choose>
							</select></td>
							<!-- 본인 사인 -->
							<td><span>사인 없음</span></td>
							<!-- 관리자 사인 -->
							<td><span>사인 없음</span></td>
						</tr>

					</tbody>
				</table>
				<br>
				<!-- 팝업창으로 이동 -->
				<div class="buttons">
					<button type="button" onclick="submitForm()">신 청</button>
					<button type="button" onclick="goToMain()">돌아가기</button>
				</div>

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
					// 팝업창이 열린 후 사인 삽입 버튼 표시
					showSignatureUploadButton();
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