<!-- 김기섭 -->

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
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Aside.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/KimKS/CSS_pop_up.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/KimKS/CSS_origin.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/KimKS/CSS_detail.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/HanCW/CSS_employee_mypage_update.css' />" rel="stylesheet">
    <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> 
    <style type="text/css">

.duplicate{ 
	    display: flex;
    margin-top: -100px;
    margin-left: 200px;
}

.duplicate-btn{
	width: 80px;
}

.row01{
	margin-top: -62px;
	gap:0px;
	margin-bottom: 15px;
	display: flex;
	align-items: center;

}

.row02{
	margin-top: -8px;
	gap:0px;
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
    <jsp:include page="/resources/jsp/PayAside.jsp" />
	<!-- Main Content -->
<main>

  <div class="profile-container">
  	<h2>직원정보 등록</h2>
    <h4>관리자가 임직원의 인사정보 등록 및 관리</h4>
    	<!-- Action Buttons -->
			<div class="directory-btn">
				<button>목록</button>
			</div>
    <div class="profile-header">
     <div class="profile-box">
      <div class="profile-img"></div>
      <div><input type="file" id="profile-photo" accept="image/*"> </div>
      </div>
  	<div class="section">
					<div class="row">
						<label>직원 이름</label> <input type="text" name="emp_name" value="" placeholder="직원 이름입력" required>
					</div>
					  <div class="row">
						<label>부서 이름</label> 
						<select name="team">
						<option selected>인사1팀</option>
						<option>인사2팀</option>
						<option>인사3팀</option>
						</select>
					</div>
					<div class="row">
						<label>아이디</label> <input type="text" name="emp_email" value="" placeholder="직원 개인이메일 입력" required>
						</div>
					<div class="duplicate">
					<button class="duplicate-btn" type="button">중복확인</button>
					</div>
					</div>
					<div class="section">
						<div class="row">
						<label>직원번호</label>
						<input type="text" name="emp_id" value="" placeholder="직원 번호 입력" required>
						</div>
						<div class="duplicate">
						<button class="duplicate-btn" type="button">중복확인</button>
						</div>
						<div class="row01">
					 	<label>직책</label>
         				<input type="text" name="position" value="" placeholder="사원 , 대리 , ... , 대표">
         				</div>
         				<div class="row02">
						<label>비밀번호</label> <input type="text" name="emp_password" value="" placeholder="비밀번호 입력" required>
					</div>
					</div>
				</div>

   
   	<!-- 직원 상세정보  -->
	<h2>직원 상세정보</h2>
    <div id="basic" class="tab-content active">
      <table class="form-table">
        <tr>
         <td><label>생년월일</label></td>
          <td><input type="date" name="brithday"  value="" required></td>
          <td><label>성별</label></td>
          <td>
             <input type="text" name="gender" value="" required>
          </td>
  			<td><label>휴대전화번호</label></td>
         <td>
            <input type="text" name="phone_number" value="" required>
          </td>          
        </tr>
        <tr>
          <td><label>주소</label></td>
          <td><input type="text" name="home" value="" placeholder="주소 입력" required></td>
          <td><label>상세주소</label></td>
           <td colspan="3"><input id="addr" name="detail_home" value="" placeholder="상세주소 입력"></td>
        </tr>
        <tr>
          <td><label>입사일</label></td>
          <td><input type="date" name="hire_date" value=""></td>
        	<td><label>근무지</label></td>
        	<td><input type="text" name="location" value="" placeholder="보직이동에서 입력한 값"></td>
         	   <td><label>년차</label></td>
          <td><input type="number" name="pay_grade" value="" placeholder="년차 입력"></td>
        </tr>
        <tr>
          <td><label>고용타입</label></td>
          <td>
            <select name="employment_type">
              <option selected>정규직</option>
              <option>계약직</option>
              <option>아르바이트</option>
            </select>
          </td>
          <td><label>근무방식</label></td>
         <td>
            <select name="attitude_type">
              <option selected>회사</option>
              <option>출장</option>
              <option>재택</option>
            </select>
          </td>
         <td><label>부서명</label></td>
         <td>
            <select name="dept_name">
              <option selected>대기</option>
              <option>직원</option>
              <option>관리자</option>
              <option>슈퍼관리자</option>
            </select>
          </td>
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
       <td><input type="text" name="remove" value="" placeholder="정상 or 동결" required ></td>
        </tr>
      </table>
    </div>
    	<!-- Action Buttons -->
			<div class="update-btn">
				<button >확인</button>
			</div>
  </div>
 
  </main>
   <!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />
  <script src="script.js">

  </script>
</body>
</html>