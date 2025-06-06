<!-- 작성자: 정택준 | 기여자: 김재겸, 김용호 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 급여 관리 (관리자)</title>


<link href="<c:url value='/resources/css/KimYH/adminpay.css'/>"
	rel="stylesheet">

<link href="<c:url value='/resources/css/Header.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css'/>" rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
.error {
	color: red;
	margin-top: 10px;
}

#but {
	margin-top: 20px;
	text-align: center;
}

#but button {
	padding: 10px 20px;
	margin: 0 10px;
}
</style>
</head>
<body>
<%-- 	
	<c:if test="${sessionScope.loginchk != 'ok'}">
		<c:redirect url="/login" />
	</c:if>
	<c:if test="${sessionScope.admin != 'ok'}">
		<c:redirect url="/index" />
	</c:if>
	 --%>

	<jsp:include page="/resources/jsp/Header.jsp" />

		<jsp:include page="/resources/jsp/PayAside.jsp" />
	<main>
	<div class="list">
		<div id="title">
			<h2>급여 기본 정보 조회 및 수정</h2>
			<p>내용 설명 - 전체 직원 급여 조회 및 수정 (관리자용)</p>
		</div>

		<div>
			<form class="search-form" action="/searchEmployees" method="post">
				<div class="choice">
					<label class="employee">검색 기준</label> 
					<select class="employee" name="searchType">
						<option value="">선택</option>
						<option value="name">이름</option>
						<option value="department">부서</option>
						<option value="position">직책</option>
					</select>
				</div>
				<div class="search-box">
					<input type="text" name="searchKeyword" placeholder="검색"
						value="<c:out value='${searchKeyword}'/>">
					<button type="submit">검색</button>
				</div>
			</form>
			<c:if test="${not empty error}">
				<p class="error">
					<c:out value="${error}" />
				</p>
			</c:if>
		</div>

		<div class="admintable">
			<table>
				<thead>
					<tr>
						<th></th>
						<th>직원코드</th>
						<th>직원명</th>
						<th>년차</th>
						<th>직책</th>
						<th>부서</th>
						<th>입사일자</th>
						<th>고용형태</th>
						<th>기본급</th>
						<th>보너스</th>
						<th>실수령액</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty employeeList}">
							<tr>
								<td colspan="11"><h3>검색 결과가 없습니다.</h3></td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="emp" items="${employeeList}">
								<tr>
									<td><input type="checkbox" name="employeeIds"
										value="${emp.emp_idx}"></td>
									<td>${emp.emp_idx}</td>
									<td>${emp.emp_name}</td>
									<td>${emp.pay_grade}</td>
									<td>${emp.position}</td>
									<td>${emp.dept_name}</td>
									<td>${emp.hire_date}</td>
									<td>${emp.employment_type}</td>
									<td>${emp.base_salary}</td>
									<td>${emp.bonus}</td>
									<td>${emp.pay}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

		<div id="but">
			<button onclick="payUpdate()">수정하기</button>
			<button onclick="insert()">지급하기</button>
			<button onclick="cancelSelection()">취소</button>
		</div>
	</div>
	</main>

	<jsp:include page="/resources/jsp/Footer.jsp" />

	<script type="text/javascript">
        function payUpdate() {
            const checked = document.querySelector('input[name="employeeIds"]:checked');
            if (!checked) {
                alert("수정할 직원을 선택하세요.");
                return;
            }
            const emp_idx = checked.value;
            location.href = "/pay_detail?emp_idx=" + emp_idx;
        }

        function insert() {
            const checked = document.querySelector('input[name="employeeIds"]:checked');
            if (!checked) {
                alert("지급할 직원을 선택하세요.");
                return;
            }
            const emp_idx = checked.value;
            location.href = "/pay_insert?emp_idx=" + emp_idx;
        }

        function cancelSelection() {
            document.querySelectorAll('input[name="employeeIds"]').forEach(cb => cb.checked = false);
        }

        document.addEventListener("DOMContentLoaded", function () {
            const checkboxes = document.querySelectorAll('input[name="employeeIds"]');
            checkboxes.forEach(cb => {
                cb.addEventListener('change', function () {
                    if (this.checked) {
                        checkboxes.forEach(other => {
                            if (other !== this) {
                                other.checked = false;
                            }
                        });
                    }
                });
            });
        });
    </script>
</body>
</html>