<!-- 작성자 : 김용호 | 기여자 : 김재겸 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 휴가 승인 화면</title>
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
}

th, td {
	width: 150px;
	height: 50px;
	text-align: center;
	border: 1px solid black;
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

#vacation_detail {
	display: none;
	position: fixed;
}
</style>
</head>
<body>

	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />

	<!-- Aside -->
	<jsp:include page="/resources/jsp/VacationAside.jsp" />

	<main>
		<form action="">
			<div id="title">
				<h2>직원 휴가 신청 사항</h2>
			</div>

			<div id="standby">
				<p>승인 대기 목록</p>
				<table>
					<thead>
						<tr>
							<th style="width: 150px;">휴가ID</th>
							<th>부서</th>
							<th>직급</th>
							<th>이름</th>
							<th>사원id</th>
							<th>기간</th>
							<th>결제</th>
							<th>비고(사유)</th>
						</tr>
					</thead>
					<tbody>

						<c:choose>
							<c:when test="${empty vacationMap}">
								<tr>
									<td colspan="8" class="no-data">휴가 신청 내역이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="entry" items="${vacationMap}">
									<c:if
										test="${entry.value.status eq '대기' or empty entry.value.status}">


										<tr onclick="modal">
											<td>${entry.value.vacation_id }</td>
											<td>${entry.value.team }</td>
											<td>${entry.value.position }</td>
											<!-- employee(직원) 테이블 -->
											<td>${entry.value.emp_name }</td>
											<!-- user(회원가입) 테이블 -->
											<td>${entry.value.emp_idx }</td>
											<!-- employee(직원) 테이블 -->
											<td>${entry.value.start_date }~ ${entry.value.end_date }</td>
											<!-- vacation(휴가) 테이블 -->
											<td><select name="status_${entry.value.vacation_id }">
													<option value="승인">승인</option>
													<option value="반려">반려</option>
											</select></td>
											<td><input type="text"
												naem="comment_${entry.value.vacation_id}"
												value="${entry.value.comment }"></td>
										</tr>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<input id="button" type="button" value="적용" onclick="Approval_ok">
			</div>

			<div id="complete">
				<p>승인 완료 목록</p>
				<table>
					<thead>
						<tr>
							<th style="width: 150px;">휴가ID</th>
							<th>부서</th>
							<th>직급</th>
							<th>이름</th>
							<th>사원id</th>
							<th>기간</th>
							<th>결제</th>
							<th>비고(사유)</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty vacationMap}">
								<tr>
									<td colspan="8" class="no-data">휴가 승인 내역이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="entry" items="${vacationMap}">
									<c:if
										test="${entry.value.status eq '승인' or entry.value.status eq '반려'}">
										<tr>
											<td>${entry.value.vacation_id }</td>
											<td>${entry.value.team }</td>
											<td>${entry.value.position }</td>
											<!-- employee(직원) 테이블 -->
											<td>${entry.value.emp_name }</td>
											<!-- user(회원가입) 테이블 -->
											<td>${entry.value.emp_idx }</td>
											<!-- employee(직원) 테이블 -->
											<td>${entry.value.start_date }~ ${entry.value.end_date }</td>
											<!-- vacation(휴가) 테이블 -->
											<td>${entry.value.status }</td>
											<td><input type="text" value="불승인 사유">${entry.value.comment }</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>


			<div id="vacation_detail" class="modal">
				<div class="detail-content">
					<div id="title">
						<h2>${emp_name }${position }님의휴가신청입니다</h2>
					</div>
					<table>
						<tbody>
							<tr>
								<td rowspan="3" id="detail_f_name"></td>
								<th>이름</th>
								<td id="detail_emp_name_field"></td>
							</tr>
							<tr>
								<th>직원 코드</th>
								<td id="detail_emp_id"></td>
							</tr>
							<tr>
								<th>휴가 ID</th>
								<td id="detail_vacation_id"></td>
							</tr>
							<tr>
								<th>휴가 시작일</th>
								<td colspan="2" id="detail_start_date"></td>
							</tr>
							<tr>
								<th>휴가 종료일</th>
								<td colspan="2" id="detail_end_date"></td>
							</tr>
							<tr>
								<th>결제</th>
								<td colspan="2" id="detaile_status"><select
									name="modal_status">
										<option>승인</option>
										<option>불승인</option>
								</select></td>
							</tr>
							<tr>
								<th>비고(사유)</th>
								<td colspan="2" id="detaile_comment"><input type="text"
									name="modal_comment" value=""></td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<th>첨부파일</th>
								<td colspan="2"></td>
							</tr>
						</tfoot>
					</table>
					<div class="button-area">
						<input type="button" value="적용" onclick="Approval_ok"> <span
							class="close">&times;</span>
					</div>
				</div>
			</div>
		</form>
	</main>

	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

	<script type="text/javascript">
	
		function Approval_ok(f) {
			const rows = document.querySelectorAll("#standby tbody tr");
			const approvals = [];
			
			rows.forEach(row => {
				const vacationId = row.cells[2]/textContent;
				const status = row.cells[5].getElementsByTagName("select")[0].value;
				const comment = row.cells[6]/getElementsByTagName("input")[0].value;
				
				approvals.push({
					vacation_id: vacationId, 
					status: status === "승인" ? "승인" : "반려", 
					comment: comment
				});
			});
			
			if (modal.style.display === "block") {
		        const vacationId = document.getElementById("detail_vacation_id").textContent;
		        const status = document.getElementById("detail_status").getElementsByTagName("select")[0].value;
		        const comment = document.getElementById("detail_comment").getElementsByTagName("input")[0].value;
		        
		        approvals.push({
		            vacation_id: vacationId,
		            status: status === "승인" ? "승인" : "반려",
		            comment: comment
		        });
		    }
			
			// AJAX로 서버에 전송
		    fetch('/updateVacationStatus', {
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
		
	
		const modal = document.getElementById("vacation_detail");
		const closeBtn = document.getElementsByClassName("close")[0];

		document.querySelectorAll("#standby tbody tr").forEach(row => {
			row.addEventListener("click", function() {
				const cells = row.getElementsByTagName("td");
				document.getElementById("detail_vacation_id").textContent = cells[0].textContent; // 휴가ID
				document.getElementById("detail_f_name").textContent = cells[3].textContent; // 이름
				document.getElementById("detail_emp_name").textContent = cells[3].textContent; // 이름
				document.getElementById("detail_emp_id").textContent = cells[4].textContent; // 사원id
				document.getElementById("detail_start_date").textContent = cells[5].textContent.split(" ~ ")[0]; // 시작일
				document.getElementById("detail_end_date").textContent = cells[5].textContent.split(" ~ ")[1]; // 종료일
				document.getElementById("detaile_status").getElementsByTagName("select")[0].value = cells[6].getElementsByTagName("select")[0].value; // 결제
				document.getElementById("detaile_comment").getElementsByTagName("input")[0].value = cells[7].getElementsByTagName("input")[0].value; // 비고
		        
				modal.style.display = "block";
			});
		});
		
		closeBtn.onclick = function(){
			modal.style.display = "none";
		};
		
	</script>

</body>
</html>