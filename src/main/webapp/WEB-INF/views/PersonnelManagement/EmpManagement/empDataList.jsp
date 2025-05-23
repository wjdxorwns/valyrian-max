<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="3부상조 - 직원정보 조회(관리자)">
<title>3부상조 - 직원정보 조회(관리자)</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/KimKS/CSS_origin.css' />"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
.emp_information {
	width: 1215px;
	overflow-x: auto;
}

.emp_table {
	min-width: 2000px
}

.emp_table tbody tr {
	cursor: pointer;
	transition: background-color 0.2s;
}

.emp_table tbody tr:hover {
	background-color: #f5f5f5;
}
/* 오버레이(배경 어둡게) */
#modal_overlay {
    display: none;
    position: fixed;
    top: 0; left: 0;
    width: 100vw; height: 100vh;
    background: rgba(0,0,0,0.5);
    z-index: 1000;
}

/* 모달창 */
#update_detail {
    display: none;
    position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    background: #fff;
    z-index: 1001;
    max-width: 700px;
    width: 90%;
    padding: 32px 24px;
    border-radius: 12px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.18);
    overflow-y: auto;
    max-height: 90vh;
}

/* 모달 내부 폼 스타일 */
#updateForm label {
    display: inline-block;
    width: 100px;
    font-weight: bold;
    margin-right: 8px;
    margin-bottom: 8px;
}
#updateForm input[type="text"],
#updateForm input[type="date"],
#updateForm input[type="number"],
#updateForm select {
    width: 180px;
    padding: 6px 10px;
    margin-bottom: 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
}
#updateForm div {
    margin-bottom: 12px;
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    gap: 8px;
}
.update-btn-fixed {
    display: flex;
    justify-content: center;
    gap: 16px;
    margin-top: 24px;
}
.update-btn-fixed button {
    padding: 8px 24px;
    border: none;
    border-radius: 4px;
    background: #007bff;
    color: #fff;
    font-weight: bold;
    cursor: pointer;
    transition: background 0.2s;
}
.update-btn-fixed button[type="button"] {
    background: #6c757d;
}
.update-btn-fixed button:hover {
    background: #0056b3;
}
.update-btn-fixed button[type="button"]:hover {
    background: #495057;
}

/* 반응형 */
@media (max-width: 600px) {
    #update_detail {
        max-width: 98vw;
        padding: 12px 4px;
    }
    #updateForm label, #updateForm input, #updateForm select {
        width: 100%;
        margin-bottom: 6px;
    }
    #updateForm div {
        flex-direction: column;
        align-items: flex-start;
        gap: 2px;
    }
}
</style>
</head>
<body>
	<jsp:include page="/resources/jsp/Header.jsp" />

	<jsp:include page="/resources/jsp/EmpDataAside.jsp" />

<main>
		<section class="employee-section" style="margin-left: 100px;">
			<h2>직원정보</h2>
			<h4>관리자가 임직원의 인사정보 조회 및 관리</h4>
			<div>
				<div class="search-form">
					<form id="searchForm" action="<c:url value='/empDataList' />" method="get">
						<div>
							<select class="employee" name="searchType">
								<option value="emp_name" <c:if test="${param.searchType == 'emp_name'}">selected</c:if>>직원명</option>
								<option value="emp_id" <c:if test="${param.searchType == 'emp_id'}">selected</c:if>>직원번호</option>
								<option value="dept_name" <c:if test="${param.searchType == 'dept_name'}">selected</c:if>>부서</option>
								<option value="position" <c:if test="${param.searchType == 'position'}">selected</c:if>>직책</option>
							</select>
							<input type="text" placeholder="검색" name="keyword" value="${param.keyword}" onkeyup="if(window.event.keyCode==13){fn_search();}">
							<button type="button" onclick="fn_search()">검색</button>
						</div>
					</form>
					</div>
			</div>

			<div class="emp_information ">
				<table class="emp_table">
					<thead>
						<tr>
							<th>직원번호</th>
							<th>직원 이름</th>
							<th>부서 이름</th> <th>직책</th>
							<th>이메일</th>
							<th>생년월일</th>
							<th>성별</th>
							<th>휴대전화번호</th>
							<th>주소</th>
							<th>상세주소</th>
							<th>입사일</th>
							<th>근무지</th>
							<th>년차</th>
							<th>고용타입</th>
							<th>근무방식</th>
							<th>부서명</th> <th>퇴사자</th>
							<th>퇴사일자</th>
							<th>계정상태</th>
						</tr>
					</thead>
					<tbody>
					<c:choose>
						<c:when test="${empty employeeList}">
							<tr>
								<td colspan="19">검색 결과가 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="emp" items="${employeeList}">
								<tr onclick="openDetailModal('${emp.emp_idx}')">
									<td>${emp.emp_id}</td>
									<td>${emp.emp_name}</td>
									<td>${emp.team}</td> <td>${emp.position}</td>
									<td>${emp.emp_email}</td>
									<td>${emp.birthday}</td>
									<%-- 성별 (0은 남, 1은 여로 가정) --%>
									<td>
										<c:choose>
											<c:when test="${emp.gender == 0}">남</c:when>
											<c:when test="${emp.gender == 1}">여</c:when>
											<c:otherwise>미지정</c:otherwise>
										</c:choose>
									</td>
									<td>${emp.phone_number}</td>
									<td>${emp.home}</td>
									<td>${emp.detail_home}</td>
									<td>${emp.hire_date}</td>
									<td>${emp.location}</td>
									<td>${emp.pay_grade}</td>
									<td>${emp.employment_type}</td>
									<td>${emp.attitude_type}</td>
									<td>${emp.dept_name}</td>
									<td>${emp.quitter}</td>
									<td>${emp.resignation_date}</td>
									<%-- 계정상태 (0은 활성, 1은 비활성으로 가정) --%>
									<td>
										<c:choose>
											<c:when test="${emp.remove == 0}">활성</c:when>
											<c:when test="${emp.remove == 1}">비활성</c:when>
											<c:otherwise>알 수 없음</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<script>
        console.log("emp.emp_idx: ${emp.emp_idx}");
    </script>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					</tbody>
				</table>
			</div>
		</section>
	<!-- 모달 오버레이 / 한찬욱 -->
	<div id="modal_overlay" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:1000;"></div>

	<!-- 모달 창 -->
	<div id="update_detail" style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%,-50%); background:#fff; z-index:1001; max-width:900px; width:90%; padding:30px; border-radius:10px; overflow:auto; max-height:90vh;">
		<form id="updateForm" action="<c:url value='/empDataUpdate'/>" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
			<input type="hidden" name="emp_idx" id="modal_emp_idx">
			<input type="hidden" name="user_idx" id="modal_user_idx">

			<div>
				<label>직원 이름</label>
				<input type="text" name="emp_name" id="modal_emp_name" required>
				<label>직원번호</label>
				<input type="text" name="emp_id" id="modal_emp_id" readonly>
			</div>
			<div>
				<label>부서 이름</label>
				<select name="team" id="modal_team">
					<option value="인사1팀">인사1팀</option>
					<option value="인사2팀">인사2팀</option>
					<option value="인사3팀">인사3팀</option>
				</select>
				<label>직책</label>
				<select name="position" id="modal_position">
					<option value="사원">사원</option>
					<option value="대리">대리</option>
					<option value="과장">과장</option>
					<option value="차장">차장</option>
					<option value="부장">부장</option>
					<option value="전무">전무</option>
					<option value="대표">대표</option>
				</select>
			</div>
			<div>
				<label>고용타입</label>
				<select name="employment_type" id="modal_employment_type">
					<option value="정규직">정규직</option>
					<option value="계약직">계약직</option>
					<option value="아르바이트">아르바이트</option>
				</select>
				<label>근무방식</label>
				<select name="attitude_type" id="modal_attitude_type">
					<option value="회사">회사</option>
					<option value="출장">출장</option>
					<option value="재택">재택</option>
				</select>
			</div>
			
			<div >
			<label>권한부여</label> <select name="dept_name"id="modal_dept_name">
								<option value="대기"
									${employeeData.dept_name eq '대기' ? 'selected' : ''}>대기</option>
								<option value="직원"
									${employeeData.dept_name eq '직원' ? 'selected' : ''}>직원</option>
								<option value="관리자"
									${employeeData.dept_name eq '관리자' ? 'selected' : ''}>관리자</option>
								<option value="슈퍼관리자"
									${employeeData.dept_name eq '슈퍼관리자' ? 'selected' : ''}>슈퍼관리자</option>
							</select>
						</div>				
			
			<div>
				<label>이메일</label>
				<input type="text" name="emp_email" id="modal_emp_email" required>
			</div>
			<div>
				<label>생년월일</label>
				<input type="date" name="birthday" id="modal_birthday" required>
				<label>성별</label>
				<select name="gender" id="modal_gender">
					<option value="0">남성</option>
					<option value="1">여성</option>
				</select>
			</div>
			<div>
				<label>휴대전화번호</label>
				<input type="text" name="phone_number" id="modal_phone_number">
			</div>
			<div>
				<label>주소</label>
				<input type="text" name="home" id="modal_home" required>
				<label>상세주소</label>
				<input type="text" name="detail_home" id="modal_detail_home">
			</div>
			<div>
				<label>입사일</label>
				<input type="date" name="hire_date" id="modal_hire_date">
				<label>근무지</label>
				<input type="text" name="location" id="modal_location">
				<label>년차</label>
				<input type="number" name="pay_grade" id="modal_pay_grade">
			</div>
			<div>
				<label>퇴사자</label>
				<select name="quitter" id="modal_quitter">
					<option value="입사">입사</option>
					<option value="퇴사대기">퇴사대기</option>
				</select>
				<label>퇴사일자</label>
				<input type="text" name="resignation_date" id="modal_resignation_date" disabled>
				<label>계정상태</label>
				<select name="remove" id="modal_remove" disabled>
					<option value="0">활성</option>
					<option value="1">동결</option>
				</select>
			</div>
			<div class="update-btn-fixed">
				<button type="submit" name="action" value="submit">수정</button>
				<button type="button" onclick="closeModal()">닫기</button>
			</div>
		</form>
	</div>
	</main>
	<jsp:include page="/resources/jsp/Footer.jsp" />
	<script type="text/javascript">
		var employeeList = JSON.parse('${employeeListJson}');
		/* 검색 기능 */
		function fn_search() {
			document.getElementById('searchForm').submit();
		}
		/* 모달 창 열기 */
		function openDetailModal(empIdx) {
			document.getElementById('modal_overlay').style.display = 'block';
			document.getElementById('update_detail').style.display = 'block';
			
			$.ajax({
				url: '/empDataDetail',
				type: 'GET',
				data: { emp_idx: empIdx },
				success: function(employee) {
					console.log(employee);
					// 모달에 값 채우기
					$('#modal_emp_idx').val(employee.emp_idx);
					$('#modal_user_idx').val(employee.user_idx);
					$('#modal_emp_name').val(employee.emp_name);
					$('#modal_emp_id').val(employee.emp_id);
					$('#modal_team').val(employee.team);
					$('#modal_position').val(employee.position);
					$('#modal_employment_type').val(employee.employment_type);
					$('#modal_attitude_type').val(employee.attitude_type);
					$('#modal_emp_email').val(employee.emp_email);
					$('#modal_birthday').val(employee.birthday);
					$('#modal_gender').val(employee.gender);
					$('#modal_phone_number').val(employee.phone_number);
					$('#modal_home').val(employee.home);
					$('#modal_detail_home').val(employee.detail_home);
					$('#modal_hire_date').val(employee.hire_date);
					$('#modal_location').val(employee.location);
					$('#modal_pay_grade').val(employee.pay_grade);
					$('#modal_quitter').val(employee.quitter);
					$('#modal_resignation_date').val(employee.resignation_date);
					$('#modal_remove').val(employee.remove);
					$('#modal_dept_name').val(employee.dept_name);
				},
				error: function() {
					alert('직원 정보를 불러오는데 실패했습니다.');
				}
			})	
		}
		/* 모달 창 닫기 */
		function closeModal() {
			document.getElementById('modal_overlay').style.display = 'none';
			document.getElementById('update_detail').style.display = 'none';
		}
		
		
		</script>
</body>
</html>