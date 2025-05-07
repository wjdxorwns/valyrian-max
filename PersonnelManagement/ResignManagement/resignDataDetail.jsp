<!-- 김기섭 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="3부상조 - 퇴사자 상세보기(슈퍼관리자) ">
<title>3부상조 - 퇴사자 상세보기(슈퍼관리자)</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Aside.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/KimKS/CSS_pop_up.css' />"
	rel="stylesheet">
<link href="<c:url value='resources/css/KimKS/CSS_detail.css' />"
	rel="stylesheet">
<link href="<c:url value='resources/css/KimKS/CSS_origin.css' />"
	rel="stylesheet">
<link
	href="<c:url value='resources/css/HanCW/CSS_employee_mypage_update.css' />"
	rel="stylesheet">
<!-- Font Awesome for social icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style type="text/css">
.profile-container {
	background: #fff;
	border-radius: 8px;
	max-width: 1100px;
	max-height: 1300px;
	margin: auto;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
	padding: 32px;
}
</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />

	<!-- Aside -->
	<jsp:include page="/resources/jsp/PayAside.jsp" />
	<!-- Main Content -->
	<main>

		<div class="profile-container">
			<h2>퇴사 데이터 관리</h2>
			<h4>슈퍼관리자가 퇴사자의 인사정보 관리 및 계정 동결</h4>
			<!-- Action Buttons -->
			<div class="directory-btn">
				<button>목록</button>
			</div>
			<div class="profile-header">
				<div class="profile-box">
					<div class="profile-img"></div>
					<div>
						<input type="file" id="profile-photo" accept="image/*">
					</div>
				</div>

				<div class="section">
					<div class="row">
						<label>직원 이름</label> <input type="text" name="emp_name" value="">
					</div>
					<div class="row">
						<label>부서 이름</label> <select name="team">
							<option selected>인사1팀</option>
							<option>인사2팀</option>
							<option>인사3팀</option>
						</select>
					</div>
					<div class="row">
						<label>아이디</label> <input type="text" name="emp_email" value="">
					</div>
				</div>
				<div class="section2">
					<div class="row">
						<label>직원번호</label> <input type="text" name="emp_id" value="">
					</div>
					<div class="row">
						<label>직책</label> <input type="text" name="position" value="">
					</div>
				</div>
			</div>


			<div id="basic" class="tab-content active">
				<table class="form-table">
					<tr>
						<td><label>생년월일</label></td>
						<td><input type="date" name="brithday" value=""></td>
						<td><label>성별</label></td>
						<td><input type="text" name="gender" value="">
						</td>
						<td><label>휴대전화번호</label></td>
						<td><input type="text" name="phone_number" value="">
						</td>
					</tr>
					<tr>
						<td><label>주소</label></td>
						<td><input type="text" name="home" value=""></td>
						<td><label>상세주소</label></td>
						<td colspan="3"><input id="addr" name="detail_home" value=""></td>
					</tr>
					<tr>
						<td><label>입사일</label></td>
						<td><input type="date" name="hire_date" value=""></td>
						<td><label>근무지</label></td>
						<td><input type="text" name="location" value=""></td>
						<td><label>년차</label></td>
						<td><input type="number" name="pay_grade" value=""></td>
					</tr>
					<tr>
						<td><label>고용타입</label></td>
						<td><select name="employment_type">
								<option selected>정규직</option>
								<option>계약직</option>
								<option>아르바이트</option>
						</select></td>
						<td><label>근무방식</label></td>
						<td><select name="attitude_type">
								<option selected>회사</option>
								<option>출장</option>
								<option>재택</option>
						</select></td>
						<td><label>부서명</label></td>
						<td><select name="dept_name">
								<option selected>대기</option>
								<option>직원</option>
								<option>관리자</option>
								<option>슈퍼관리자</option>
						</select></td>
					</tr>
					<tr>
						<td><label>퇴사자</label></td>
						<td><select name="quitter">
								<option selected>입사</option>
								<option>퇴사</option>
								<option>퇴사대기</option>
						</select></td>
						<td><label>퇴사일자</label></td>
						<td><input type="date" name="resignation_date" value=""></td>
						<td><label>계정상태</label></td>
						<td><input type="text" name="remove" value=""></td>
					</tr>
				</table>

			</div>
			<!-- 사인 저장을 위한 canvas -->
			<div><h3>직원 서명</h3></div>
			<canvas class="signature_pad" width="400px"></canvas>
			<br>
			<br>
			<!-- Action Buttons -->
			<div class="update-btn">
				<button>확인</button>
			</div>
		</div>
	</main>
	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />
	<script src="script.js">
		
	</script>
</body>
</html>