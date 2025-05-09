<!-- 작성자: 한찬욱 | 기여자: 김재겸-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 어드민 직원에게 급여 지급</title>

<!-- 화면(CSS) 링크 -->
<link
	href="<c:url value='/resources/css/HanCW/CSS_admin_pay_detail_update.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/JeoungTJ/Main.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css'/>" rel="stylesheet">

<!-- 폰트 링크 -->
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<!-- Font Awesome for social icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>




<body>


	<main style="width: margin: 80px auto auto;">
		<jsp:include page="/resources/jsp/PayAside.jsp" />


		<!-- 사진, 이메일, 직원 이름, 집주소, 상세 집주소, 휴대전화번호, 부서명, 직책, 호봉, 입사일, 직원 고유코드, 휴가일  -->
		<!-- Header -->
		<jsp:include page="/resources/jsp/Header.jsp" />
		<div style="margin-top: 30px;">
			<h2>직원 급여 지급</h2>
			<h4>직원에게 급여를 책정합니다.</h4>

		</div>
		<!-- 개인정보 테이블 -->
		<div class="container">
			<div class="container1">
				<!-- 사진과 옆내용 -->
				<div class="infor_table">
					<!-- 사진 -->
					<div class="profile_image">
						<img
							src='<c:url value="/resources/images/18ceebb0bfd4c2da7.jpg" />'>
					</div>
					<!-- 직원이름, 이메일, 휴대전화번호, 부서명, 직책, 호봉 -->
					<div>

						<div class="set">
							<div class="info_title">이름</div>
							<div>
								<input type="text" class="box1" value="${user.emp_name }"
									disabled />
							</div>
						</div>

						<div class="set">
							<div class="info_title">이메일</div>
							<div>
								<input type="text" class="box1" value="${user.emp_email }"
									disabled />
							</div>
						</div>

						<div class="set">
							<div class="info_title">전화번호</div>
							<div>
								<input type="text" class="box1" value="${user.phone_number }"
									disabled />
							</div>
						</div>

						<div class="set">
							<div class="info_title">부서명</div>
							<div>
								<input type="text" class="box1" value="${employee.dept_name }"
									disabled />
							</div>
						</div>

						<div class="set">
							<div class="info_title">직책</div>
							<div>
								<input type="text" class="box1" value="${employee.position }"
									disabled />
							</div>
						</div>

						<div class="set">
							<div class="info_title">호봉</div>
							<div>
								<input type="text" class="box1" value="${employee.pay_grade }"
									disabled />
							</div>
						</div>

					</div>
				</div>
				<!-- 사진 아랫내용 -->
				<div class="under_table">
					<div class="und_table">
						<div class="set">

							<div class="info_title">입사일</div>
							<div>
								<input type="text" class="box2" value="${user.start_date }"
									disabled />
							</div>
						</div>
						<div class="set">
							<div class="info_title">휴가일</div>
							<div>
								<input type="text" class="box2" value="${user.vacation_day }"
									disabled />
							</div>
						</div>

					</div>
					<div class="und_table">
						<div class="set">
							<div class="info_title">직원코드</div>
							<div>
								<input type="text" class="box2" value="${user.emp_code }"
									disabled />
							</div>
						</div>
						<div class="set">
							<div class="info_title">급여</div>
							<div>
								<input type="text" class="box2" value="${user.pay }" disabled />
							</div>
						</div>
					</div>
					<div class="set">
						<div class="info_title">주소</div>
						<div>
							<input type="text" class="box3" value="${user.home }" disabled />
						</div>
					</div>

					<div class="set">
						<div class="info_title">상세주소</div>
						<div>
							<input type="text" class="box3" value="${user.detail_home }"
								disabled />
						</div>
					</div>
				</div>

			</div>
			<div class="container2">
				<br> <br> <br> <br> <br> <br> <br>
				<br> <br> <br> <br> <br> <br>
				<div class="pay">
					<div>급여 :</div>
					<div class="choice">
						<input class="in" type="number">
						<button class="button3">등록</button>
					</div>
				</div>
				<div class="tex">
					<div>세금</div>
					<div>
						<label for="percentage" class="choice">퍼센트 선택:</label> <select
							class="percentage" name="percentage">
							<option value="1">1%</option>
							<option value="2">2%</option>
							<option value="3">3%</option>
						</select>
					</div>
				</div>
				<div class="real_pay">실수령 금액</div>
				급여 - (세금X급여) = 실수령 금액
				<div>
					<input class="pay_box" type="text" readonly>
				</div>
				<div>
					<input type="button" class="button2" value="저장하기"
						onclick="admin_Pay_Detail_Update_Ok(this.form)"> <input
						type="button" class="button2" value="돌아가기"
						onclick="admin_Pay_Detail(this.form)">
				</div>
			</div>
		</div>
	</main>


	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />
</body>



<script type="text/javascript">
	// 실수령 금액 계산
	function calculateRealPay() {
		const salaryInput = document.querySelector(".in").value;
		const salary = parseFloat(salaryInput) || 0;
		const taxRateSelect = document.querySelector(".percentage").value;
		const taxRate = parseFloat(taxRateSelect) / 100 || 0;
		const taxAmount = salary * taxRate;
		const realPay = salary - taxAmount;
		const realPayInput = document.querySelector(".pay_box");
		realPayInput.value = realPay.toFixed(0);
	}

	function admin_Pay_Detail_Update() {

		const salary = parseFloat(document.querySelector(".in").value) || 0;
		const taxRate = parseFloat(document.querySelector(".percentage").value) || 0;
		const realPay = parseFloat(document.querySelector(".pay_box").value) || 0;
		const empIdx = "${user.emp_code}"; // JSP에서 직원 코드 가져오기

		if (salary <= 0 || isNaN(salary)) {
			alert("유효한 급여를 입력하세요.");
			return;
		}
		if (taxRate <= 0 || isNaN(taxRate)) {
			alert("유효한 세율을 선택하세요.");
			return;
		}

	}

	document.addEventListener("DOMContentLoaded", function() {

		const calcButton = document.querySelector(".button3");
		if (calcButton) {
			calcButton.addEventListener("click", calculateRealPay);
		}

		const saveButton = document.querySelector('input[value="저장하기"]');
		if (saveButton) {
			saveButton.addEventListener("click", admin_Pay_Detail_Update_ok);
		}

		const backButton = document.querySelector('input[value="돌아가기"]');
		if (backButton) {
			backButton.addEventListener("click", function() {
				window.location.href = "/searchEmployees";
			});
		}
	});
</script>

</html>


