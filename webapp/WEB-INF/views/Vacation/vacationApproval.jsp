<!-- 작성자 : 김용호 | 기여자 : 김재겸 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 휴가 승인 화면</title>
    <!-- 폰트 로드 -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- CSS 파일 링크 -->
    <link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Aside.css' />" rel="stylesheet">
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/KimYH/CSS_vacation.css">
<style type="text/css">
#standby{
border: 1px solid black;
background-color: #fff;

margin-top: 10px;
overflow: hidden;
}
#standby p{
text-align: center;
margin-top: 10px;
}
#complete{
border: 1px solid black;
background-color: #fff;

margin-top: 50px;
overflow: hidden;
}
#complete p{
text-align: center;
margin-top: 10px;
}

/* 공통 */
table{
margin-top:10px;
border-bottom: 2px solid black;
border-top: 2px solid black;
}

th, td{
width:150px;
height:50px;
text-align: center;
border:1px solid black;
}
#button{
margin:5px;
padding:5px;
align-items: flex-end;
justify-content: flex-end;
float: right;
}
/* 모달 창 */
#vacation_detail {
display: none;
position: fixed;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
background-color: #fff;
border: 1px solid #ccc;
padding: 20px;
z-index: 1000;
width: 600px;
max-width: 90%;
border-radius: 8px;
}
/* 모달 오버레이 */
#modal_overlay {
display: none;
position: fixed;
top: 0;
left: 0;
width: 100%;
height: 100%;
background-color: rgba(0, 0, 0, 0.5);
z-index: 999;
}
#vacation_detail table th{
width:150px;
}
.button{
display:flex;
justify-content: center;
}
.button button{
margin:10px;
}


</style>
</head>
<body>

	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />
	
	<!-- Aside -->
	<jsp:include page="/resources/jsp/VacationAside.jsp" />
	
	<main>
		<div id="title">
			<h2>직원 휴가 신청 사항</h2>
		</div>
			
		<div id="standby">
			<p>승인 대기 목록</p>
			<table>
				<thead>
					<tr>
						<th style="width:150px;">휴가ID</th><th>부서</th><th>직급</th><th>이름</th><th>사원id</th><th>기간</th><th>결재</th><th>비고(사유)</th>
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
								<c:if test="${entry.value.status eq '대기' or empty entry.value.status}">
									<tr data-request-idx="${entry.value.request_idx}">
										<td>${entry.value.vacation_id }</td>
										<td>${entry.value.team }</td>
										<td>${entry.value.position }</td> <!-- employee(직원) 테이블 -->
										<td>${entry.value.emp_name }</td> <!-- user(회원가입) 테이블 -->
										<td>${entry.value.emp_idx }</td> <!-- employee(직원) 테이블 -->
										<td>${entry.value.start_date } ~ ${entry.value.end_date }</td> <!-- vacation(휴가) 테이블 -->
										<td>
											<select name="status_${entry.value.vacation_id }">
												<option value="승인">승인</option>
												<option value="반려">반려</option>
											</select>
										</td>
										<td><input type="text" name="comment_${entry.value.vacation_id}" value="${entry.value.comment }"></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
		</div>
			
		<div id="complete">
			<p>승인 완료 목록</p>
			<table>
				<thead>
					<tr>
						<th style="width:150px;">휴가ID</th><th>부서</th><th>직급</th><th>이름</th><th>사원id</th><th>기간</th><th>결재</th><th>비고(사유)</th>
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
								<c:if test="${entry.value.status eq '승인' or entry.value.status eq '반려'}">
									<tr>
										<td>${entry.value.vacation_id }</td>
										<td>${entry.value.team }</td>
										<td>${entry.value.position }</td> <!-- employee(직원) 테이블 -->
										<td>${entry.value.emp_name }</td> <!-- user(회원가입) 테이블 -->
										<td>${entry.value.emp_idx }</td> <!-- employee(직원) 테이블 -->
										<td>${entry.value.start_date } ~ ${entry.value.end_date }</td> <!-- vacation(휴가) 테이블 -->
										<td>${entry.value.status }</td>
										<td>${entry.value.comment }</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
			
		<!-- 모달 오버레이 -->
		<div id="modal_overlay"></div>
        
		<!-- 모달 창 -->
		<div id="vacation_detail">
			<h (°C)3>휴가 상세 정보</h3>
			<table>
				<tbody>
					<tr>
						<td rowspan="4" colspan="2">사진이 들어올거임</td><th>사원ID</th><td><span id="modal_emp_idx"></span></td>
					</tr>
					<tr>
						<th>이름</th><td><span id="modal_emp_name"></span></td>
					</tr>
					<tr>
						<th>부서</th><td><span id="modal_team"></span></td>
					</tr>
					<tr>
						<th>직급</th><td><span id="modal_position"></span></td>
					</tr>
					<tr>
						<th>휴가ID</th><td><span id="modal_vacation_id"></span></td>
						<th>분류</th><td><span id="modal_vacation_type"></span></td>
					</tr>
					<tr>
						<th>결재</th>
						<td>
							<select id="modal_status">
								<option value="승인">승인</option>
								<option value="반려">반려</option>
							</select>
						</td>
						<th>비고</th><td><input type="text" id="modal_comment_input"></td>
					</tr>
					<tr>
						<th>휴가기간</th><td colspan="3"><span id="modal_period"></span></td>
					</tr>
					<tr>
						<th>첨부파일</th><td colspan="3"><span id="modal_file"></span></td>
					</tr>
				</tbody>
			</table>
			<div class="button">
				<button onclick="updateVacationStatus('modal')">적용</button>
				<button onclick="closeModal()">닫기</button>
			</div>
		</div>
			
	</main>

	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />
	
	<script type="text/javascript">
		
	function updateVacationStatus(source) {
		console.log("1. updateVacationStatus function called, source:", source);
		let approvals = [];
        
		if (source === 'table') {
	        // 테이블 데이터 수집
	        const rows = document.querySelectorAll("#standby tbody tr");
	        console.log("2. 처리할 행 수: " + rows.length);
	        if (rows.length === 0) {
	            console.log("처리할 행 없음");
	            alert("처리할 휴가 신청이 없습니다.");
	            return;
	        }

	        rows.forEach((row, index) => {
	            console.log(`3. 행 ${index + 1} HTML: `, row.innerHTML);
	            const cells = row.cells;
	            console.log(`4. 행 ${index + 1} 셀 수: `, cells.length);
	            
	            const vacationId = cells[0] ? cells[0].textContent.trim() : "";
	            const requestIdx = row.dataset.requestIdx; // request_idx 추가
	            const statusSelect = cells[6] ? cells[6].querySelector("select") : null;
	            const commentInput = cells[7] ? cells[7].querySelector("input") : null;

	            console.log(`5. 행 ${index + 1} 처리: vacationId=${vacationId}, requestIdx=${requestIdx}, statusSelect=${!!statusSelect}, commentInput=${!!commentInput}`);

	            if (vacationId && statusSelect && commentInput) {
	                const approvalData = {
	                    vacation_id: vacationId,
	                    request_idx: requestIdx, // request_idx 포함
	                    status: statusSelect.value,
	                    comment: commentInput.value || ""
	                };
	                approvals.push(approvalData);
	                console.log(`6. 승인 데이터 추가: `, approvalData);
	            } else {
	                console.warn(`행 ${index + 1} 데이터 오류: vacationId=${vacationId}, requestIdx=${requestIdx}, statusSelect=${!!statusSelect}, commentInput=${!!commentInput}`);
	            }
	        });
	    } else if (source === 'modal') {
	        // 모달 데이터 수집
	        const vacationId = document.getElementById("modal_vacation_id").textContent.trim();
	        const requestIdx = document.getElementById("modal_vacation_id").dataset.requestIdx; // request_idx 가져오기
	        const statusSelect = document.getElementById("modal_status");
	        const commentInput = document.getElementById("modal_comment_input");

	        console.log(`2. 모달 처리: vacationId=${vacationId}, requestIdx=${requestIdx}, statusSelect=${!!statusSelect}, commentInput=${!!commentInput}`);

	        if (vacationId && statusSelect && commentInput) {
	            const approvalData = {
	                vacation_id: vacationId,
	                request_idx: requestIdx, // request_idx 포함
	                status: statusSelect.value,
	                comment: commentInput.value || ""
	            };
	            approvals.push(approvalData);
	            console.log(`3. 모달 승인 데이터 추가: `, approvalData);
	        } else {
	            console.warn(`모달 데이터 오류: vacationId=${vacationId}, requestIdx=${requestIdx}, statusSelect=${!!statusSelect}, commentInput=${!!commentInput}`);
	        }
	    }

	    if (approvals.length === 0) {
	        console.log("7. 보낼 승인 데이터 없음");
	        alert("유효한 데이터가 없습니다.");
	        return;
	    }

	    console.log("8. 승인 데이터 전송: ", approvals);
	    fetch('${pageContext.request.contextPath}/updateVacationStatus', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	        },
	        body: JSON.stringify(approvals)
	    })
	    .then(response => {
	        console.log("9. 응답 상태: " + response.status);
	        if (!response.ok) {
	            throw new Error(`HTTP 에러! 상태: ${response.status}`);
	        }
	        return response.json();
	    })
	    .then(data => {
	        console.log("10. 서버 응답: ", data);
	        if (data.success) {
	            console.log("11. 성공: 업데이트 완료");
	            alert("승인 처리가 완료되었습니다.");
	            closeModal(); // 모달 창 닫기
	            location.reload();
	        } else {
	            console.log("11. 서버 실패 응답");
	            alert("서버에서 오류가 발생했습니다.");
	        }
	    })
	    .catch(error => {
	        console.error("12. Fetch 에러: ", error);
	        alert("서버 통신 오류: " + error.message);
	    });
	}

	// 모달 창 열기
	function openModal(row) {
	    const cells = row.cells;
	    const vacationId = cells[0].textContent.trim();
	    const team = cells[1].textContent.trim();
	    const position = cells[2].textContent.trim();
	    const empName = cells[3].textContent.trim();
	    const empIdx = cells[4].textContent.trim();
	    const period = cells[5].textContent.trim();
	    const statusSelect = cells[6].querySelector("select");
	    const status = statusSelect ? statusSelect.value : "";
	    const commentInput = cells[7].querySelector("input");
	    const comment = commentInput ? commentInput.value : "";
	    const requestIdx = row.dataset.requestIdx; // request_idx 가져오기

	    // 모달 창에 데이터 삽입
	    document.getElementById("modal_vacation_id").textContent = vacationId;
	    document.getElementById("modal_vacation_id").dataset.requestIdx = requestIdx; // request_idx 저장
	    document.getElementById("modal_team").textContent = team;
	    document.getElementById("modal_position").textContent = position;
	    document.getElementById("modal_emp_name").textContent = empName;
	    document.getElementById("modal_emp_idx").textContent = empIdx;
	    document.getElementById("modal_period").textContent = period;
	    document.getElementById("modal_vacation_type").textContent = ""; 
	    document.getElementById("modal_file").textContent = ""; 
	    
	    // 결재 상태 동기화
	    const modalStatus = document.getElementById("modal_status");
	    modalStatus.value = status;
	    
	    // 비고 입력 동기화
	    document.getElementById("modal_comment_input").value = comment;

	    // 모달 창과 오버레이 표시
	    document.getElementById("vacation_detail").style.display = "block";
	    document.getElementById("modal_overlay").style.display = "block";
	}

	// 모달 창 닫기
	function closeModal() {
	    document.getElementById("vacation_detail").style.display = "none";
	    document.getElementById("modal_overlay").style.display = "none";
	}

	// 행 클릭 이벤트 리스너 추가
	document.addEventListener("DOMContentLoaded", function() {
	    const rows = document.querySelectorAll("#standby tbody tr");
	    rows.forEach(row => {
	        row.addEventListener("click", function(event) {
	            // <select>와 <input> 클릭 시 모달 창 열림 방지
	            if (event.target.tagName !== 'SELECT' && event.target.tagName !== 'INPUT') {
	                openModal(this);
	            }
	        });
	    });
	});
	
	
</script>
</body>
</html>