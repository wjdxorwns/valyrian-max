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
	border: 1px solid black;
	background-color: #fff;
	margin-top: 10px;
	overflow: hidden;
}

#standby p {
	text-align: center;
	margin-top: 10px;
}

#complete {
	border: 1px solid black;
	background-color: #fff;
	margin-top: 50px;
	overflow: hidden;
}

#complete p {
	text-align: center;
	margin-top: 10px;
}

/* 공통 */
table {
	margin-top: 10px;
	border-bottom: 2px solid black;
	border-top: 2px solid black;
	width: 100%;
}

th, td {
	height: 50px;
	text-align: center;
	border: 1px solid black;
	padding: 8px;
}

#button {
	margin: 5px;
	padding: 5px;
	align-items: flex-end;
	justify-content: flex-end;
	float: right;
}

tbody tr:hover {
	background-color: #f5f5f5; /* 마우스 오버 시 배경색 */
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
	margin: 15% auto;
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
	<jsp:include page="/resources/jsp/VacationAside.jsp" />

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
							<th style="width: 150px;">사원 번호</th>
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
					<tbody>
						<c:choose>
							<c:when test="${empty personChangeList}">
								<tr>
									<td colspan="9" class="no-data">근무지 이동 신청 내역이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="request" items="${personChangeList}">
									<c:if test="${request.status == 0 or empty request.status}">
										<tr>
											<td>${request.emp_id}</td>
											<td>${request.team}</td>
											<td>${request.position}</td>
											<td>${request.emp_name}</td>
											<td>${request.emp_email}</td>
											<td>${request.prev_dept_id}</td>
											<td>${request.new_dept_id}</td>
											<td><input type="button" value="승인/반려" onclick="showModal(${request.request_idx}, event)"></td>
											<td><input type="text" name="comment_${request.request_idx}" value="${request.request_text}"></td>
										</tr>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<input id="button" type="button" value="변경" onclick="showModal()">
			</div>

			<div id="complete">
				<p>근무지 이동 승인 목록</p>
				<table>
					<thead>
						<tr>
							<th style="width: 150px;">사원 번호</th>
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
					<tbody>
						<c:choose>
							<c:when test="${empty personChangeList}">
								<tr>
									<td colspan="9" class="no-data">발령 승인 내역이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="request" items="${personChangeList}">
									<c:if test="${request.status == 1}">
										<tr>
											<td>${request.emp_id}</td>
											<td>${request.team}</td>
											<td>${request.position}</td>
											<td>${request.emp_name}</td>
											<td>${request.emp_email}</td>
											<td>${request.prev_dept_id}</td>
											<td>${request.new_dept_id}</td>
											<td>
												<select name="status_${request.change_id}">
													<option value="승인">승인</option>
													<option value="반려">반려</option>
												</select>
											</td>
											<td>${request.request_text}</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
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
								<td><select name="modal_status">
										<option value="1">승인</option>
										<option value="0">반려</option>
								</select></td>
							</tr>
							<tr>
								<th>비고(사유)</th>
								<td><input type="text" name="modal_comment" value=""></td>
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
				document.getElementById("detail_emp_idx").textContent = cells[0].textContent;
				document.getElementById("detail_team").textContent = cells[1].textContent;
				document.getElementById("detail_position").textContent = cells[2].textContent;
				document.getElementById("detail_emp_name").textContent = cells[3].textContent;
				document.getElementById("detail_emp_email").textContent = cells[4].textContent;
				
				// select 값 설정
				const modalSelect = document.querySelector("select[name='modal_status']");
				modalSelect.value = cells[5].querySelector("select").value;
				
				// input 값 설정
				const modalInput = document.querySelector("input[name='modal_comment']");
				modalInput.value = cells[6].querySelector("input").value;
				
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

		// Approval_ok 함수 수정
		function Approval_ok(f) {
			const approvals = [];
			
			if (modal.style.display === "block") {
				// 모달이 열려있을 때는 모달의 데이터만 처리
				approvals.push({
					request_idx: document.getElementById("modal_request_idx").value,
					status: document.querySelector("select[name='modal_status']").value === "승인" ? "승인" : "반려",
					comment: document.querySelector("input[name='modal_comment']").value
				});
			} else {
				// 모달이 닫혀있을 때는 테이블의 모든 행 처리
				const rows = document.querySelectorAll("#standby tbody tr");
				rows.forEach(row => {
					const button = row.querySelector("input[type='button']");
					const request_idx = button.getAttribute("onclick").match(/\d+/)[0];
					
					approvals.push({
						request_idx: request_idx,
						status: row.querySelector("select").value === "승인" ? "승인" : "반려",
						comment: row.querySelector("input[type='text']").value
					});
				});
			}
			
			// AJAX로 서버에 전송
		    fetch('/updatePersonChangeStatus', {
		        method: 'POST',
		        headers: {
		            'Content-Type': 'application/json'
		        },
		        body: JSON.stringify(approvals)
		    })
		    .then(response => response.json())
		    .then(data => {
		        if (data.success) {
		            alert("승인 처리가 완료되었습니다.");
		            location.reload();
		        } else {
		            alert("오류가 발생했습니다.");
		        }
		    })
		    .catch(error => console.error('Error:', error));
		}
		
		function showModal(request_idx, event) {
			if (!event) event = window.event;
			const row = event.target.closest('tr');
			const cells = row.getElementsByTagName("td");
			
			// request_idx를 hidden input에 저장
			document.getElementById("modal_request_idx").value = request_idx;
			
			// 모달 내용 업데이트
			document.getElementById("detail_emp_id").textContent = cells[0].textContent;
			document.getElementById("detail_team").textContent = cells[1].textContent;
			document.getElementById("detail_position").textContent = cells[2].textContent;
			document.getElementById("detail_emp_name").textContent = cells[3].textContent;
			document.getElementById("detail_emp_email").textContent = cells[4].textContent;
			document.getElementById("detail_prev_dept").textContent = cells[5].textContent;
			document.getElementById("detail_new_dept").textContent = cells[6].textContent;
			
			// 모달 표시
			modal.style.display = "block";
		}
		
	</script>

</body>
</html>