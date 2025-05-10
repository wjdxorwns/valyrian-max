
<!-- 작성자 : 

수정해야할 것들

1. 직원 이미지 : 파일 크기 설정값 없앨 것
2. 직원 번호 : 고용타입(정규직, 계약직, 아르바이트) 에 따라 다르게 설정되도록 할것 ex). 정규직 : E000 / 계약직 : T000 / 아르바이트 : P000
3. 직책 : 드롭 다운으로 사원, 대리, 과장, 차장, 부장, 전무, 대표 
4. 아이디 : 이메일 형식으로 입력 되도록 할 것
5. 성별 : "남성", "여성"으로 <select><option>으로 드롭 다운 만들기 (* DB에 입력될 때는  남성 : 0, 여성 : 1)
6. 휴대전화 번호 : 중복확인 추가
7. 주소, 상세주소 : 주소 검색 api를 사용할 것 
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
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/KimKS/CSS_pop_up.css' />"
	rel="stylesheet">
<link href="<c:url value='resources/css/KimKS/CSS_origin.css' />"
	rel="stylesheet">
<link href="<c:url value='resources/css/KimKS/CSS_detail.css' />"
	rel="stylesheet">
<!-- Font Awesome for social icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style type="text/css">
.duplicate {
	display: flex;
	margin-top: -100px;
	margin-left: 200px;
}

.duplicate-btn {
	width: 80px;
}

.row01 {
	margin-top: -62px;
	gap: 0px;
	margin-bottom: 15px;
	display: flex;
	align-items: center;
}

.row02 {
	margin-top: -8px;
	gap: 0px;
	margin-bottom: 15px;
	display: flex;
	align-items: center;
}

.row01 label, .row02  label {
	width: 100px;
	font-weight: bold;
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
				action="<c:url value='/manager/PersonnelManagement/EmpManagement/empDataRegister'/>"
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
								id="emp_name" value="" placeholder="직원 이름입력" required>
						</div>
						<div class="row">
							<label>부서 이름</label> <select name="team" id="team">
								<option selected>인사1팀</option>
								<option>인사2팀</option>
								<option>인사3팀</option>
							</select>
						</div>
						<div class="row">
							<label>아이디</label> <input type="text" name="emp_email"
								id="emp_email" value="" placeholder="직원 개인이메일 입력" required>
						</div>
						<div class="duplicate">
							<button class="duplicate-btn" type="button"
								onclick="checkDuplicate('emp_email')">중복확인</button>
						</div>
					</div>
					<div class="section">
						<div class="row">
							<label>직원번호</label> <input type="text" name="emp_id" id="emp_id"
								value="" placeholder="직원 번호 입력" required>
						</div>
						<div class="duplicate">
							<button class="duplicate-btn" type="button"
								onclick="checkDuplicate('emp_id')">중복확인</button>
						</div>
						<div class="row01">
							<label>직책</label> <input type="text" name="position"
								id="position" value="" placeholder="사원 , 대리 , ... , 대표">
						</div>
						<div class="row02">
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
							<td><input type="text" name="gender" id="gender" value=""
								required></td>
							<td><label>휴대전화번호</label></td>
							<td><input type="text" name="phone_number" id="phone_number"
								value="" required></td>
						</tr>
						<tr>
							<td><label>주소</label></td>
							<td><input type="text" name="home" id="home" value=""
								placeholder="주소 입력" required></td>
							<td><label>상세주소</label></td>
							<td colspan="3"><input id="addr" name="detail_home"
								id="detail_home" value="" placeholder="상세주소 입력"></td>
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
						<tr>
							<td><label>고용타입</label></td>
							<td><select name="employment_type" id="employment_type">
									<option selected>정규직</option>
									<option>계약직</option>
									<option>아르바이트</option>
							</select></td>
							<td><label>근무방식</label></td>
							<td><select name="attitude_type" id="attitude_type">
									<option selected>회사</option>
									<option>출장</option>
									<option>재택</option>
							</select></td>
							<td><label>부서명</label></td>
							<td><select name="dept_name" id="dept_name">
									<option selected>대기</option>
									<option>직원</option>
									<option>관리자</option>
									<option>슈퍼관리자</option>
							</select></td>
						</tr>
					</table>
				</div>
				<!-- Action Buttons -->
				<div class="update-btn">
					<button type="submit" name="action" value="submit">확인</button>
				</div>
			</form>
		</div>
	</main>
	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />
	<script type="text/javascript">
	console.log("중복확인 URL:", checkDuplicateUrl);
  	function checkDuplicate(field) {
	  const checkDuplicateUrl = "${pageContext.request.contextPath}/manager/checkDuplicate";
	  console.log("checkDuplicate() 함수 실행됨:", field);
	  let value = "";
	  let label = "";
	  console.log("입력된 필드:", field)
	  if (field === "emp_email") {
	    value = document.querySelector("input[name='emp_email']").value;
	    label = "이메일";
	  } else if (field === "emp_id") {
	    value = document.querySelector("input[name='emp_id']").value;
	    label = "직원번호";
	  }

	  if (!value) {
	    alert(`${label}을(를) 입력해주세요.`);
	    return;
	  }
	  const url = checkDuplicateUrl + "?field=" + encodeURIComponent(field) + "&value=" + encodeURIComponent(value);
	  console.log("생성된 URL:", url); // fetch 바로 전에 넣어줘
	  fetch(url)
	    .then(res => res.json())
	    .then(data => {
	      if (data.duplicate) {
	        alert(` 이미 존재합니다.`);
	      } else {
	        alert(`사용 가능합니다.`);
	      }
	    })
	    .catch(error => {
	      console.error('중복확인 실패', error);
	      alert('중복확인 중 오류가 발생했습니다.');
	    });
	}
	
	  function goToTheList() {
	    window.location.href = "${pageContext.request.contextPath}/PersonnelManagement/EmpManagement/empDataList";
	  }

	  function validateForm() {
	    const empName = document.querySelector("input[name='emp_name']");
	    const userId = document.querySelector("input[name='emp_email']");
	    const password = document.querySelector("input[name='emp_password']");

	    if (!empName.value.trim() || !userId.value.trim() || !password.value.trim()) {
	      alert("직원 이름, 이메일, 비밀번호는 필수 입력입니다.");
	      return false;
	    }
	    return true;
	  }

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
  </script>
</body>
</html>