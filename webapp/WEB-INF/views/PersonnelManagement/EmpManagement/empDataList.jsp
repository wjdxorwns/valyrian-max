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
</style>
</head>
<body>
	<jsp:include page="/resources/jsp/Header.jsp" />

	<jsp:include page="/resources/jsp/EmpDataAside.jsp" />

<main>
		<section class="employee-section">
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
								<tr onclick="goToDetail('${emp.emp_idx}')">
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
	</main>
	<jsp:include page="/resources/jsp/Footer.jsp" />
	<script type="text/javascript">
		function fn_search() {
			document.getElementById('searchForm').submit();
		}

		function goToDetail(empIdx) {
			window.location.href = "${pageContext.request.contextPath}/PersonnelManagement/EmpManagement/empDataDetail?emp_idx=" + empIdx;
		}
	</script>
</body>
</html>