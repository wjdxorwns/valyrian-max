<!-- 작성자: 한찬욱 | 기여자: 김재겸, 김용호-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 어드민 직원에게 급여 지급</title>

<link href="<c:url value='/resources/css/Header.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/KimYH/PayUpdate.css'/>" rel="stylesheet">

<!-- 폰트 -->
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
	<jsp:include page="/resources/jsp/PayAside.jsp" />
	<jsp:include page="/resources/jsp/Header.jsp" />
	<main>
		<div class="content">
			<div class="text-area">
				<h2>직원 급여 지급</h2>
				<h4>직원에게 급여를 책정합니다.</h4>
			</div>
			<div class="table-area">
				<table>
					<tbody>
						<tr>
							<th colspan="2" rowspan="6">
								<c:if test="${not empty user}">
                            <c:if test="${not empty user['f_name']}">
                                <img src="${pageContext.request.contextPath}/resources/images/${user['f_name']}.jpg" alt="증명사진">
                            </c:if>
                        </c:if>
							</th>
							<th>이름</th><td><input type="text" class="box1" value="${user.emp_name}" readonly /></td>
						</tr>
						<tr>
							<th>이메일</th><td><input type="text" class="box1" value="${not empty user.emp_email ? user.emp_email : '-'}" disabled /></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="text" class="box1" value="${not empty user.phone_number ? user.phone_number : '-'}" disabled/></td>
						</tr>
						<tr>
							<th>부서명</th>
							<td><input type="text" class="box1" value="${not empty user.team ? user.team : '-'}" disabled/></td>
						</tr>
						<tr>
							<th>직책</th>
							<td><input type="text" class="box1" value="${not empty user.position ? user.position : '-'}" disabled/></td>
						</tr>
						<tr>
							<th>연(년)차</th>
							<td><input type="text" class="box1" value="${not empty user.pay_grade ? user.pay_grade : '-'}" disabled/></td>
						</tr>
						<tr>
							<th>입사일</th><td><input type="text" class="box1" value="${not empty user.hire_date ? user.hire_date : '-'}" disabled/></td>
							<th>성별</th><td><input type="text" class="box1" value="${not empty user.gender ? user.gender : '-'}" disabled/></td>
						</tr>
						<tr>
							<th>직원코드</th><td><input type="text" class="box1" name="emp_idx" value="${not empty user.emp_idx ? user.emp_idx : '-'}" disabled/></td>
							<th>급여</th><td><input type="text" class="box1" value="${not empty user.pay ? user.pay : '-'}" disabled/></td>
						</tr>
						<tr>
							<th>주소</th><td colspan="3"><input type="text" class="box1" value="${not empty user.home ? user.home : '-'}" disabled/></td>
						</tr>
						<tr>
							<th>상세주소</th><td colspan="3"><input type="text" class="box1" value="${not empty user.detail_home ? user.detail_home : '-'}" disabled/></td>
						</tr>
					</tbody>
				</table>
			</div>
				<button onclick="openmodal()">급여 수정</button>
		</div>
		
		

		<!-- 모달 창 -->
		<div id="pay-modal">
			<form id="payForm" action="/admin_Pay_Update_Ok" method="post">
				<p class="p1">
					<label>기본급 : </label>
					<input class="in" type="number" name="base_salary" min="0" value="${user.base_salary}">
				</p>
				<button class="button3" type="button" onclick="calculateRealPay()">계산</button>
				<p class="p1">
					<label>보너스 : </label>
					<input class="in" type="number" name="bonus" min="0" value="${user.bonus} ">
				</p>
				<p class="p1">
					<label>세금</label>
					<select class="percentage" name="taxRate" id="taxRate">
						<option value="1">1%</option>
						<option value="2">2%</option>
						<option value="3">3%</option>
					</select>
				</p>
				<p>실 수령</p>
				<p><label>기본급 - (세금×기본급) + 보너스 = 실수령 금액</label></p>
				<p><input class="pay_box" type="text" name="realPay" readonly></p>
				<div class="button-area">
					<input type="button" class="button2" value="저장하기" onclick="adminPayDetailUpdateOk()"> 
					<input type="button" class="button2" value="돌아가기" onclick="history.back()">
					<input type="button" class="button2" value="닫기" onclick="close()">
				</div>
			</form>
		</div>
	</main>
	
	<jsp:include page="/resources/jsp/Footer.jsp" />
	
	<script type="text/javascript">
		function calculateRealPay() {
			const salaryInput = document
					.querySelector('input[name="base_salary"]').value;
			const salary = parseFloat(salaryInput) || 0;
			const taxRateSelect = document.querySelector(".percentage").value;
			const taxRate = parseFloat(taxRateSelect) / 100 || 0;
			const taxAmount = salary * taxRate;
			const bonusInput = document.querySelector('input[name="bonus"]').value;
			const bonus = parseFloat(bonusInput) || 0;
			const realPay = salary - taxAmount + bonus;
			const realPayInput = document.querySelector(".pay_box");
			realPayInput.value = realPay.toFixed(0);
			console.log("Calculated real pay: " + realPay);
		}

		function adminPayDetailUpdateOk() {
			const baseSalary = parseFloat(document
					.querySelector('input[name="base_salary"]').value) || 0;
			const bonus = parseFloat(document
					.querySelector('input[name="bonus"]').value) || 0;
			const taxRate = document.querySelector('select[name="taxRate"]').value;
			const emp_idx = document.querySelector('input[name="emp_idx"]').value;

			if (baseSalary <= 0) {
				alert("기본급을 숫자로 입력하세요.");
				return;
			}
			if (!taxRate) {
				alert("세율을 선택하세요.");
				return;
			}
			if (!emp_idx) {
				alert("직원 코드가 없습니다.");
				return;
			}

			// 폼 제출
			document.getElementById("payForm").submit();
		}

		document.addEventListener("DOMContentLoaded", function() {
			const calcButton = document.querySelector(".button3");
			if (calcButton) {
				calcButton.addEventListener("click", calculateRealPay);
			}
		});
		
		/* 모달 창 */
		function openmodal() {
			document.getElementById('pay-modal').style.display = 'flex';
		}
		function close() {
			document.getElementById('pay-modal').style.display = 'none';
		}
		function calculateRealPay() {
			const baseSalary = parseFloat(document.querySelector('input[name="base_salary"]').value) || 0;
			const bonus = parseFloat(document.querySelector('input[name="bonus"]').value) || 0;
			const taxRate = parseFloat(document.querySelector('select[name="taxRate"]').value) / 100;
			const realPay = baseSalary - (baseSalary * taxRate) + bonus;
			document.querySelector('input[name="realPay"]').value = realPay.toFixed(2);
		}
		function adminPayDetailUpdateOk() {
			document.getElementById('payForm').submit();
		}
	</script>
</body>
</html>