<!-- 권한 지정 -->
<!-- 작성자: 정택준 | 기여자: 김재겸 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>


<meta charset="UTF-8">
<title>3부상조 - 메인 페이지</title>
<link href="<c:url value='/resources/css/Main.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/JeoungTJ/CSS_table.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/JeoungTJ/CSS_jungtakejun.css'/>"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
	<jsp:include page="/resources/jsp/Header.jsp" />

	<main>
		<div class="title">
			<h2>권한 부여 페이지</h2>
			<p>권한 부여에 대한 설명</p>
		</div>

		<div style="width: 1200px">
			<table>
				<thead>
					<tr>
						<th>분류</th>
						<th>이름</th>
						<th>직급</th>
						<th>직원 정보권한</th>
						<th>근무 방식 권한</th>
						<th>인사발령권한</th>
						<th>급여 권한</th>
						<th>휴가 권한</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty userList}">
							<td colspan="8" style="text-align: center;">데이터가 없습니다.</td>
						</c:when>
						<c:otherwise>
							<!-- 데이터가 있는 경우 -->
							<c:forEach var="user" items="${userList}">
								<tr>
									<td>${user.role}</td>
									<td>${user.name}</td>
									<td>${user.position}</td>
									<c:choose>
										<c:when test="${user.role == '슈퍼 관리자'}">
											<!-- 슈퍼 관리자: 모든 체크박스 체크 -->
											<td><input type="checkbox"
												name="employeeInfo_${user.id}" checked></td>
											<td><input type="checkbox" name="workType_${user.id}"
												checked></td>
											<td><input type="checkbox" name="personnel_${user.id}"
												checked></td>
											<td><input type="checkbox" name="payroll_${user.id}"
												checked></td>
											<td><input type="checkbox" name="vacation_${user.id}"
												checked></td>
										</c:when>
										<c:otherwise>
											<!-- 다른 역할: 기본적으로 체크 안 함 -->
											<td><input type="checkbox"
												name="employeeInfo_${user.id}"></td>
											<td><input type="checkbox" name="workType_${user.id}"></td>
											<td><input type="checkbox" name="personnel_${user.id}"></td>
											<td><input type="checkbox" name="payroll_${user.id}"></td>
											<td><input type="checkbox" name="vacation_${user.id}"></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<div id="but">
				<button type="submit" value="수정">수정</button>
				<button type="submit" value="취소">취소</button>
			</div>
		</div>
	</main>


	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />
</body>




</html>