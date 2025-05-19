<!-- 작성자 : 한찬욱 | 기여자 : 김재겸, 김용호 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 발령 승인 화면</title>
<!-- 폰트 로드 -->
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<!-- Font Awesome for social icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- CSS 파일 링크 -->
<link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/KimYH/CSS_vacation.css">
<style type="text/css">
#standby {
	border: 1px solid #ddd;
	background-color: #fff;
	margin-top: 10px;
	padding: 20px;
	border-radius: 5px;
	min-height: 300px;
}

#standby p {
	text-align: center;
	margin: 15px 0;
	font-size: 18px;
	font-weight: bold;
	color: #333;
}

#complete {
	border: 1px solid #ddd;
	background-color: #fff;
	margin-top: 30px;
	padding: 20px;
	border-radius: 5px;
	min-height: 300px;
}

#complete p {
	text-align: center;
	margin: 15px 0;
	font-size: 18px;
	font-weight: bold;
	color: #333;
}

/* 공통 테이블 스타일 */
table {
	margin: 10px 0;
	border-collapse: collapse;
	width: 100%;
	min-height: 150px;
}

th {
	background-color: #f8f9fa;
	color: #333;
	font-weight: bold;
	height: 50px;
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

td {
	height: 50px;
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

/* 데이터 없을 때 스타일 */
.no-data {
	height: 150px;
	text-align: center;
	color: #666;
	font-size: 16px;
}

tbody tr:hover {
	background-color: #f5f5f5;
}

/* 버튼 스타일 */
input[type="button"] {
	padding: 6px 12px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type="button"]:hover {
	background-color: #0056b3;
}

#button {
	margin: 10px 5px;
	text-align: right;
}

/* 모달 스타일 개선 */
.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0,0,0,0.5);
}

.detail-content {
	background-color: #fff;
	margin: 10% auto;
	padding: 20px;
	border-radius: 5px;
	width: 40%;
	max-width: 600px;
	position: relative;
	box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.button-area {
	text-align: center;
	margin-top: 20px;
	padding: 10px 0;
}

.button-area input[type="button"] {
	margin: 0 5px;
}

/* 입력 필드 스타일 */
input[type="text"] {
	padding: 6px 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	width: 80%;
}

select {
	padding: 6px 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	width: auto;
}

#personChange_detail {
	display: none;
	position: fixed;
}

/* 모달 스타일 */
.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0,0,0,0.4);
}

.detail-content {
	background-color: #fefefe;
	margin: 7% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 30%;
	position: relative;
}

.button-area {
	text-align: center;
	margin-top: 20px;
}

.button-area input[type="button"] {
	margin: 0 10px;
	padding: 5px 15px;
}

.close {
	cursor: pointer;
}
</style>
</head>
<body>

	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />

	<!-- Aside -->
	<jsp:include page="/resources/jsp/EmpDataAside.jsp" />
	<main>
		<h2>직원 근무지 이동 신청 사항</h2>
			<div id="title">
			</div>
			<!-- 발령 대기 목록 Request Table Request_idx, request_personnelchange, request_text, team, position, emp_name, user_email -->
			<div id="standby">
				<p>근무지 이동 신청 목록</p>
				<table>
					<thead>
						<tr>
							<th>NO</th>
							<th>사원 번호</th>
							<th>부서</th>
							<th>직급</th>
							<th>이름</th>
							<th>e-mail</th>
							<th>이전 근무지</th>
							<th>새 근무지</th>
							<th>결제</th>
							<th>비고(사유)</th>
						</tr>
					</thead>
					<% int waitCount = 0; %>
					<tbody>
						<c:choose>
							<c:when test="${empty personChangeList}">
								<tr>
									<td colspan="9" class="no-data">근무지 이동 신청 내역이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="request" items="${personChangeList}">
									<c:if test="${request.request_personnelchange == 1  and empty request.logging_personnelchange }">
										<% waitCount++; %>
										<tr onclick="showModal(${request.request_idx}, event)">
											<td><%= waitCount %></td>
											<td>${request.emp_id}</td>
											<td>${request.team}</td>
											<td>${request.position}</td>
											<td>${request.emp_name}</td>
											<td>${request.emp_email}</td>
											<td>${request.prev_dept_id}</td>
											<td>${request.new_dept_id}</td>
											<td>대기</td>
											<td>${request.request_text}</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
			</div>
			<div id="complete">
				<p>근무지 이동 승인 목록</p>
				<table>
					<thead>
						<tr>
							<th>NO</th>
							<th>사원 번호</th>
							<th>부서</th>
							<th>직급</th>
							<th>이름</th>
							<th>e-mail</th>
							<th>이전 근무지</th>
							<th>새 근무지</th>
							<th>결제</th>
							<th>비고(사유)</th>
						</tr>
					</thead>	
					<% int endorseCount = 0; %>
					<tbody>
						<c:choose>
							<c:when test="${empty personChangeList}">
								<tr>
									<td colspan="9" class="no-data">발령 승인 내역이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="request" items="${personChangeList}">
									<c:if test="${request.logging_personnelchange == 1}">
										<% endorseCount++; %>
										<tr>
											<td><%= endorseCount %></td>
											<td>${request.emp_id}</td>
											<td>${request.team}</td>
											<td>${request.position}</td>
											<td>${request.emp_name}</td>
											<td>${request.emp_email}</td>
											<td>${request.prev_dept_id}</td>
											<td>${request.new_dept_id}</td>
											<td>승인</td>
											<td>${request.request_text}</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div id="complete">
				<p>근무지 이동 거절 목록</p>
				<table>
					<thead>
						<tr>
							<th>NO</th>
							<th>사원 번호</th>
							<th>부서</th>
							<th>직급</th>
							<th>이름</th>
							<th>e-mail</th>
							<th>이전 근무지</th>
							<th>새 근무지</th>
							<th>결제</th>
							<th>비고(사유)</th>
						</tr>
					</thead>	
					<% int declineCount = 0; %>
					<tbody>
						<c:choose>
							<c:when test="${empty personChangeList}">
								<tr>
									<td colspan="9" class="no-data">발령 거절 내역이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="request" items="${personChangeList}">
									<c:if test="${request.logging_personnelchange == 0 }">
										<% declineCount++; %>
										<tr>
											<td><%= declineCount %></td>
											<td>${request.emp_id}</td>
											<td>${request.team}</td>
											<td>${request.position}</td>
											<td>${request.emp_name}</td>
											<td>${request.emp_email}</td>
											<td>${request.prev_dept_id}</td>
											<td>${request.new_dept_id}</td>
											<td>반려</td>
											<td>${request.request_text}</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div class="buttons">
					<button onclick="goMain()">메인으로</button>
				</div>	
			</div>


			<div id="personChange_detail" class="modal">
				<div class="detail-content">
					<input type="hidden" id="modal_request_idx" value="">
					<div id="title">
						<h2>근무지 이동 신청 상세</h2>
					</div>
					<table>
						<tbody>
							<tr>
								<th>NO</th>
								<td id="detail_request_idx"></td>
							</tr>
							<tr>
								<th>사원번호</th>
								<td id="detail_emp_id"></td>
							</tr>
							<tr>
								<th>부서</th>
								<td id="detail_team"></td>
							</tr>
							<tr>
								<th>직급</th>
								<td id="detail_position"></td>
							</tr>
							<tr>
								<th>이름</th>
								<td id="detail_emp_name"></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td id="detail_emp_email"></td>
							</tr>
							<tr>
								<th>이전 근무지</th>
								<td id="detail_prev_dept"></td>
							</tr>
							<tr>
								<th>새 근무지</th>
								<td id="detail_new_dept"></td>
							</tr>
							<tr>
								<th>결제</th>
								<td><select name="modal_logging_personnelchange">
										<option value="1">승인</option>
										<option value="0">반려</option>
								</select></td>
							</tr>
							<tr>
								<th>비고(사유)</th>
								<td><input type="text" name="modal_request_text" value=""></td>
							</tr>
						</tbody>
					</table>
					<div class="button-area">
						<input type="button" value="적용" onclick="Approval_ok()">
						<input type="button" value="취소" class="close">
					</div>
				</div>
			</div>
	</main>

	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

	<script type="text/javascript">
	
		// 모달 관련 변수
		const modal = document.getElementById("personChange_detail");
		const closeBtn = document.getElementsByClassName("close")[0];

		// 테이블 행 클릭 이벤트
		document.querySelectorAll("#standby tbody tr").forEach(row => {
			row.addEventListener("click", function() {
				const cells = row.getElementsByTagName("td");
				
				// 모달 내용 업데이트
				document.getElementById("detail_request_idx").textContent = cells[0].textContent;
				document.getElementById("detail_emp_id").textContent = cells[1].textContent;
				document.getElementById("detail_team").textContent = cells[2].textContent;
				document.getElementById("detail_position").textContent = cells[3].textContent;
				document.getElementById("detail_emp_name").textContent = cells[4].textContent;
				document.getElementById("detail_emp_email").textContent = cells[5].textContent;
				document.getElementById("detail_prev_dept").textContent = cells[6].textContent;
				document.getElementById("detail_new_dept").textContent = cells[7].textContent;
				
				// select 값 설정 - 기본값 1(승인)으로 설정
				const modalSelect = document.querySelector("select[name='modal_logging_personnelchange']");
				modalSelect.value = "1";
				
				// input 값 설정
				const modalInput = document.querySelector("input[name='modal_request_text']");
				modalInput.value = cells[9].textContent;
				
				// 모달 표시
				modal.style.display = "block";
			});
		});

		// 모달 닫기 버튼
		closeBtn.onclick = function() {
			modal.style.display = "none";
		};

		// 모달 외부 클릭시 닫기
		window.onclick = function(event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}
		};

		function Approval_ok() {
			const requestData = {
				request_idx: parseInt(document.getElementById("modal_request_idx").value),
				request_personnelchange: parseInt(document.querySelector("select[name='modal_request_personnelchange']").value),
				request_text: document.querySelector("input[name='modal_request_text']").value
			};
			
			console.log('Sending data:', requestData); // 디버깅용 로그
			
			fetch('/updatePersonChangeStatus', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify(requestData)
			})
			.then(response => {
				console.log('Response status:', response.status); // 응답 상태 로그
				if (!response.ok) {
					return response.text().then(text => {
						console.log('Error response:', text); // 에러 응답 내용 로그
						throw new Error('Network response was not ok: ' + text);
					});
				}
				const contentType = response.headers.get("content-type");
				if (contentType && contentType.indexOf("application/json") !== -1) {
					return response.json();
				}
				throw new TypeError("Response was not JSON");
			})
			.then(data => {
				if(data && data.success) {
					alert("처리가 완료되었습니다.");
					location.reload();
				} else {
					alert("처리 중 오류가 발생했습니다: " + (data.message || "알 수 없는 오류"));
				}
			})
			.catch(error => {
				console.error('Error:', error);
				alert("처리 중 오류가 발생했습니다: " + error.message);
			});
		}
		
		function showModal(request_idx, event) {
			if (!event) event = window.event;
			const row = event.target.closest('tr');
			const cells = row.getElementsByTagName("td");
			
			// request_idx를 hidden input에 저장
			document.getElementById("modal_request_idx").value = request_idx;
			
			// 모달 내용 업데이트
			document.getElementById("detail_request_idx").textContent = cells[0].textContent;
			document.getElementById("detail_emp_id").textContent = cells[1].textContent;
			document.getElementById("detail_team").textContent = cells[2].textContent;
			document.getElementById("detail_position").textContent = cells[3].textContent;
			document.getElementById("detail_emp_name").textContent = cells[4].textContent;
			document.getElementById("detail_emp_email").textContent = cells[5].textContent;
			document.getElementById("detail_prev_dept").textContent = cells[6].textContent;
			document.getElementById("detail_new_dept").textContent = cells[7].textContent;
			
			// select 값 설정 - 기본값 1(승인)으로 설정
			const modalSelect = document.querySelector("select[name='modal_logging_personnelchange']");
			modalSelect.value = "1";
			
			// input 값 설정
			const modalInput = document.querySelector("input[name='modal_request_text']");
			modalInput.value = cells[9].textContent;
			
			// 모달 표시
			modal.style.display = "block";
		}
		
			/* 메인화면으로 */
			function goMain() {
				window.location.href = "/index";
			}
		
	</script>

</body>
</html>