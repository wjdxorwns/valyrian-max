
<!-- 작성자 : 

수정해야할 것들

1. 직원 이미지 : 파일 크기 설정값 없앨 것 
2. 직원 번호 : 고용타입(정규직, 계약직, 아르바이트) 에 따라 다르게 설정되도록 할것 ex). 정규직 : E000 / 계약직 : T000 / 아르바이트 : P000 (수정완료)
3. 직책 : 드롭 다운으로 사원, 대리, 과장, 차장, 부장, 전무, 대표 (수정완료)
4. 아이디 : 이메일 형식으로 입력 되도록 할 것 (수정완료)
5. 성별 : "남성", "여성"으로 <select><option>으로 드롭 다운 만들기 (* DB에 입력될 때는  남성 : 0, 여성 : 1) (수정완료)
6. 휴대전화 번호 : 중복확인 추가 (수정완료)
7. 주소, 상세주소 : 주소 검색 api를 사용할 것  (수정완료)
8. "퇴사자, 퇴사일자, 계정상태" 등록 화면에서 없앨 것 (수정완료)
9. 확인 버튼 : 컨트롤러에 확인(submit) 받는 로직 추가



*추가* 
직원등록 후 생성된 emp_idx가 request 등 다른 DB 테이블과도 연결돼야 한다. 
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="3부상조 - 직원등록(관리자)">
<title>3부상조 - 직원등록(관리자)</title>

<link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/KimKS/CSS_origin.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/KimKS/CSS_detail.css' />" rel="stylesheet">
	
<!-- Font Awesome for social icons -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
/* 전체 컨테이너 스타일 */
.profile-container {
	max-width: 1300px;
	max-height: 1300px;
	margin: 0 auto;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	overflow-x: auto;
}

/* 헤더 스타일 */
.profile-container h2 {
	color: #333;
	margin-bottom: 10px;
	font-size: 24px;
}

.profile-container h4 {
	color: #666;
	margin-bottom: 30px;
	font-size: 16px;
	font-weight: normal;
}

/* 프로필 헤더 섹션 */
.profile-header {
	display: flex;
	gap: 30px;
	margin-bottom: 40px;
	background-color: #f8f9fa;
	border-radius: 8px;
	overflow-x: auto;
	
}

/* 프로필 이미지 박스 */
.profile-box {
	width: 200px;
	text-align: center;
}

.profile-img {
	width: 180px;
	height: 200px;
	border: 1px solid #ddd;
	border-radius: 4px;
	overflow: hidden;
	margin-bottom: 10px;
}

.profile-img img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

/* 섹션 스타일 */
.section {
	flex: 1;
	display: flex;
	flex-direction: column;
	gap: 15px;
}

/* 행 스타일 */
.row, .row01, .row02 {
	display: flex;
	align-items: center;
	gap: 56px;
	margin-bottom: 15px;
}

.row0 {
	display: flex;
	align-items: center;
	gap: 56px;
	margin-bottom: 15px;
	margin-left: 28px;
	margin-top: 30px;
}

.row00 {
	display: flex;
	align-items: center;
	gap: 56px;
	margin-bottom: 15px;
	margin-right: 119px;
}

.row label, .row01 label, .row02 label .row0 label .row00 label {
	width: 100px;
	font-weight: bold;
	color: #333;
}

/* 입력 필드 스타일 */
input[type="text"], input[type="date"], input[type="number"], select {
	height: 35px;
	padding: 0 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-sizing: border-box;
	width: 200px;
}

/* 이메일 입력 그룹 */
.email-input-group {
	display: flex;
	gap: 5px;
	align-items: center;
	flex-wrap: wrap;
}

.email-input-group input[type="text"] {
	width: 150px;
}

.email-input-group select {
	width: 120px;
}

#custom_domain {
	width: 150px;
}

/* 전화번호 입력 그룹 */
.phone-input-group {
	display: flex;
	gap: 5px;
	align-items: center;
}

.phone-input-group input[type="text"] {
	width: 60px;
	text-align: center;
}

.phone-input-group span {
	font-weight: bold;
	color: #666;
}

/* 중복확인 결과 메시지 */
#email_check_result, #phone_check_result {
	font-size: 0.9em;
	margin-left: 10px;
	display: inline-block;
}

/* 테이블 스타일 */
.form-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 30px;
}

.form-table td {
	padding: 15px;
	vertical-align: middle;
}

.form-table label {
	font-weight: bold;
	color: #333;
	display: block;
	margin-bottom: 5px;
}

/* 버튼 스타일 */
.directory-btn {
	text-align: right;
	margin-bottom: 20px;
}

.directory-btn button, .update-btn button {
	padding: 8px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-weight: bold;
	transition: background-color 0.3s;
}

.directory-btn button {
	background-color: #6c757d;
	color: white;
}

.update-btn {
	text-align: center;
	margin-top: 30px;
}

.update-btn button {
	background-color: #007bff;
	color: white;
	padding: 10px 30px;
	font-size: 16px;
}

.directory-btn button:hover {
	background-color: #5a6268;
}

.update-btn button:hover {
	background-color: #0056b3;
}

/* 주소 검색 버튼 */
input[type="button"][value="주소찾기"] {
	background-color: #28a745;
	color: white;
	border: none;
	padding: 8px 15px;
	border-radius: 4px;
	cursor: pointer;
	margin: 10px;
}

input[type="button"][value="주소찾기"]:hover {
	background-color: #218838;
}

/* 파일 업로드 스타일 */
input[type="file"] {
	width: 100%;
	margin-top: 10px;
}

/* 반응형 디자인 */
@media ( max-width : 768px) {
	.profile-header {
		flex-direction: column;
	}
	.profile-box {
		width: 100%;
	}
	.form-table td {
		display: block;
		width: 100%;
	}
	.email-input-group, .phone-input-group {
		flex-direction: column;
		align-items: flex-start;
	}
}

.update-btn-fixed {
	width: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 40px 0 0 0;
	padding-bottom: 40px;
	background: transparent;
}

.update-btn-fixed button {
	background-color: #007bff;
	color: white;
	padding: 10px 30px;
	font-size: 16px;
	border: none;
	border-radius: 4px;
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.3s;
}

.update-btn-fixed button:hover {
	background-color: #0056b3;
}

button {
	width: 100px;
	height: 50px;
	margin-left: 5px;
}
</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />

	<!-- Aside -->
	<jsp:include page="/resources/jsp/EmpDataAside.jsp" />
	<!-- Main Content -->
	<main>
		<div class="profile-container">
			<h2>직원정보 등록</h2>
			<h4>관리자가 임직원의 인사정보 등록 및 관리</h4>
			<form
				action="<c:url value='/PersonnelManagement/EmpManagement/empDataRegister'/>"
				method="post" enctype="multipart/form-data"
				onsubmit="return validateForm();">
				<!-- Action Buttons -->
				<div class="directory-btn">
					<button type="button" onclick="goToTheList()">목록</button>
				</div>
				<div class="profile-header">
					<div class="profile-box">
						<div class="profile-img">
							<img id="profilePreview" src="#" alt="미리보기"
								style="width: 180px; height: 200px; display: none;">
						</div>
						<div>
							<input type="file" id="profile-photo" name="profileImg"
								accept="image/*" onchange="previewImage(this, 'profilePreview')">
						</div>
					</div>
					<div class="section">
						<div class="row">
							<label>직원 이름</label> <input type="text" name="emp_name"
								id="emp_name" value="" placeholder="직원 이름입력" required> <label>직원번호</label>
							<input type="text" name="emp_id" id="emp_id" value=""
								placeholder="고용타입 선택 시 자동 생성" readonly>
						</div>
						<div class="row">
							<label>부서 이름</label> <select name="team" id="team">
								<option selected>부서 선택</option>
								<option>인사1팀</option>
								<option>인사2팀</option>
								<option>인사3팀</option>
							</select> <label>직책</label> <select name="position" id="position">
								<option selected>직책 선택</option>
								<option>사원</option>
								<option>대리</option>
								<option>과장</option>
								<option>차장</option>
								<option>부장</option>
								<option>전무</option>
								<option>대표</option>
							</select>
						</div>
						<div class="row">
							<label>고용타입</label> <select name="employment_type"
								id="employment_type">
								<option selected>고용타입 선택</option>
								<option value="정규직">정규직</option>
								<option value="계약직">계약직</option>
								<option value="아르바이트">아르바이트</option>
							</select> <label>근무방식</label> <select name="attitude_type"
								id="attitude_type">
								<option selected>근무방식 선택</option>
								<option>회사</option>
								<option>출장</option>
								<option>재택</option>
							</select>
						</div>
						<div class="row0">
							<label>아이디</label>
							<div class="email-input-group" style="flex: 1;">
								<input type="text" name="email_id" id="email_id"
									placeholder="이메일 아이디" required> <select
									name="email_domain" id="email_domain" required>
									<option value="">도메인 선택</option>
									<option value="@gmail.com">@gmail.com</option>
									<option value="@naver.com">@naver.com</option>
									<option value="@hanmail.com">@hanmail.com</option>
									<option value="@nate.com">@nate.com</option>
									<option value="custom">직접 입력</option>
								</select> <input type="text" name="custom_domain" id="custom_domain"
									style="display: none;" placeholder="도메인 입력"> <input
									type="hidden" name="emp_email" id="emp_email">
							</div>
							<span id="email_check_result"
								style="color: #666; margin-left: 10px;"></span>
						</div>
						<div class="row00">
							<label>비밀번호</label> <input type="text" name="emp_password"
								id="emp_password" value="" placeholder="비밀번호 입력" required>
						</div>
					</div>
				</div>

				<!-- 직원 상세정보  -->
				<h2>직원 상세정보</h2>
				<div id="basic" class="tab-content active">
					<table class="form-table">
						<tr>
							<td><label>생년월일</label></td>
							<td><input type="date" name="birthday" id="birthday"
								value="" required></td>
							<td><label>성별</label></td>
							<td><select name="gender" id="gender">
									<option selected>성별 선택</option>
									<option value="0">남성</option>
									<option value="1">여성</option>
							</select></td>
							<td><label>휴대전화번호</label></td>
							<td>
								<div class="phone-input-group">
									<input type="text" name="phone1" id="phone1" maxlength="3"
										placeholder="010" required> <span>-</span> <input
										type="text" name="phone2" id="phone2" maxlength="4"
										placeholder="0000" required> <span>-</span> <input
										type="text" name="phone3" id="phone3" maxlength="4"
										placeholder="0000" required> <input type="hidden"
										name="phone_number" id="phone_number">
								</div> <span id="phone_check_result"
								style="color: #666; margin-left: 10px;"></span>
							</td>
						</tr>
						<tr>
							<td><label>주소</label></td>
							<td><input type="text" name="home" id="home" value=""
								placeholder="주소 입력" required> <input type="button"
								value="주소찾기" onclick="execDaumPostcode()"></td>
							<td><label>상세주소</label></td>
							<td colspan="3"><input id="addr" name="detail_home"
								id="detail_home" value="" placeholder="상세주소 입력"
								style="width: 100%"></td>
						</tr>
						<tr>
							<td><label>입사일</label></td>
							<td><input type="date" name="hire_date" id="hire_date"
								value=""></td>
							<td><label>근무지</label></td>
							<td><input type="text" name="location" id="location"
								value="" placeholder="보직이동에서 입력한 값"></td>
							<td><label>년차</label></td>
							<td><input type="number" name="pay_grade" id="pay_grade"
								value="" placeholder="년차 입력"></td>
						</tr>
					</table>
				</div>
				<!-- Action Buttons -->
				<div class="update-btn-fixed">
					<button type="submit" name="action" value="submit">확인</button>
				</div>
			</form>
		</div>
	</main>
	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />
	<script type="text/javascript">
		$(document).ready(function() {
			// 이메일 도메인 선택 처리
			$("#email_domain").on("change", function() {
				var customDomain = $("#custom_domain");

				if ($(this).val() === "custom") {
					customDomain.show();
					customDomain.prop("required", true);
					customDomain.focus();
				} else {
					customDomain.hide();
					customDomain.prop("required", false);
					checkEmailDuplicate();
				}
			});

			// 이메일 아이디 입력 처리
			$("#email_id").on("input", function() {
				checkEmailDuplicate();
			});

			// 커스텀 도메인 입력 처리
			$("#custom_domain").on("input", function() {
				checkEmailDuplicate();
			});

			// 핸드폰 번호 입력 처리
			$("#phone1, #phone2, #phone3").on("input", function() {
				// 숫자만 입력 가능하도록
				this.value = this.value.replace(/[^0-9]/g, '');

				// 자동으로 다음 입력필드로 이동
				if (this.value.length === this.maxLength) {
					if (this.id === "phone1") {
						$("#phone2").focus();
					} else if (this.id === "phone2") {
						$("#phone3").focus();
					}
				}

				checkPhoneDuplicate();
			});
		});

		// 이메일 중복 확인 함수
		function checkEmailDuplicate() {
			var emailId = $("#email_id").val();
			var domainSelect = $("#email_domain");
			var customDomain = $("#custom_domain");
			var resultSpan = $("#email_check_result");

			if (!emailId) {
				resultSpan.text("");
				return;
			}

			var domain = domainSelect.val();
			if (domain === "custom") {
				domain = customDomain.val();
				if (!domain) {
					resultSpan.text("");
					return;
				}
			}

			if (!domain) {
				resultSpan.text("");
				return;
			}

			var fullEmail = emailId + domain;
			$("#emp_email").val(fullEmail);

			// 중복 확인 AJAX 요청
			$
					.ajax({
						url : "${pageContext.request.contextPath}/checkDuplicate",
						type : "GET",
						data : {
							field : "emp_email",
							value : fullEmail
						},
						success : function(response) {
							if (response.error) {
								resultSpan.text(response.error).css("color",
										"red");
							} else if (response.duplicate) {
								resultSpan.text("이미 사용중인 이메일입니다.").css("color",
										"red");
							} else {
								resultSpan.text("사용 가능한 이메일입니다.").css("color",
										"green");
							}
						},
						error : function() {
							resultSpan.text("중복확인 중 오류가 발생했습니다.").css("color",
									"red");
						}
					});
		}

		// 핸드폰 번호 중복 확인 함수
		function checkPhoneDuplicate() {
			var phone1 = $("#phone1").val();
			var phone2 = $("#phone2").val();
			var phone3 = $("#phone3").val();
			var resultSpan = $("#phone_check_result");

			// 모든 필드가 채워졌는지 확인
			if (phone1.length !== 3 || phone2.length !== 4
					|| phone3.length !== 4) {
				resultSpan.text("");
				return;
			}

			var fullPhone = phone1 + "-" + phone2 + "-" + phone3;
			$("#phone_number").val(fullPhone);

			// 중복 확인 AJAX 요청
			$
					.ajax({
						url : "${pageContext.request.contextPath}/checkDuplicate",
						type : "GET",
						data : {
							field : "phone_number",
							value : fullPhone
						},
						success : function(response) {
							if (response.error) {
								resultSpan.text(response.error).css("color",
										"red");
							} else if (response.duplicate) {
								resultSpan.text("이미 사용중인 전화번호입니다.").css(
										"color", "red");
							} else {
								resultSpan.text("사용 가능한 전화번호입니다.").css("color",
										"green");
							}
						},
						error : function() {
							resultSpan.text("중복확인 중 오류가 발생했습니다.").css("color",
									"red");
						}
					});
		}

		function goToTheList() {
			window.location.href = "${pageContext.request.contextPath}/empDataList";
		}

		function validateForm() {
			const empName = document.querySelector("input[name='emp_name']");
			const userId = document.querySelector("input[name='emp_email']");
			const password = document
					.querySelector("input[name='emp_password']");

			if (!empName.value.trim() || !userId.value.trim()
					|| !password.value.trim()) {
				alert("직원 이름, 이메일, 비밀번호는 필수 입력입니다.");
				return false;
			}
			return true;
		}
		// 사진 미리보기
		function previewImage(input, targetId) {
			const file = input.files[0];
			if (file) {
				const reader = new FileReader();
				reader.onload = function(e) {
					const img = document.getElementById(targetId);
					if (img) {
						img.src = e.target.result;
						img.style.display = "block";
					}
				};
				reader.readAsDataURL(file);
			}
		}
		// 주소 찾기
		function execDaumPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {
					$("#home").val(data.address);
				}
			}).open();
		}
	</script>
</body>
</html>