<!-- 김기섭 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="3부상조 - 퇴사자 상세보기 ">
<title>3부상조 - 퇴사자 상세보기 </title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Aside.css' />" rel="stylesheet">
	<link href="<c:url value='resources/css/KimKS/CSS_detail.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/KimKS/CSS_origin.css' />" rel="stylesheet">
    <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> 
    <style type="text/css">


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
	<h4>관리자가 퇴사자의 인사정보 관리 및 계정 동결</h4>
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
						<label>직원명</label> <input type="text" value="김진수" placeholder="이름입력" disabled>
					</div>
					<div class="row">
						<label>아이디</label> <input type="text" value="kjs@gmail.com" placeholder="직원 개인이메일 입력">
					</div>
					</div>
		<div class="section">
						<div class="row">
						<label>직원번호</label>
						<input type="text" value="001211" placeholder="직원번호 입력">
					</div>
					<div class="row">
						<label>부서이름</label> 
						<select>
						<option selected>인사1팀</option>
						<option>인사2팀</option>
						<option>인사3팀</option>
						</select>
					</div>
					</div>
				</div>
   
 <!--    <div class="tabs">
      <button class="tab-btn active" onclick="openTab(event, 'basic')">기본</button>
      <button class="tab-btn" onclick="openTab(event, 'other')">신상</button>
      기타 탭 추가 가능
    </div> -->
   
   
    <div id="basic" class="tab-content active">
      <table class="form-table">
        <tr>
         <td><label>생년월일</label></td>
          <td><input type="date" value=""></td>
          <td><label>성별</label></td>
           <td><input type="text" value=""></td>
  			<td><label>전화번호</label></td>
         <td>
            <input type="text" value="">
          </td>          
        </tr>
        <tr>
          <td><label>주소</label></td>
          <td><input type="text"></td>
          <td><label>상세주소</label></td>
           <td><input type="text"></td>
            <td><label>년차</label></td>
          <td><input type="number"></td>
        </tr>
        <tr>
          <td><label>입사일</label></td>
          <td><input type="date" value=""></td>
        	<td><label>근무지</label></td>
        	<td><input type="text" value="" placeholder="보직이동에서 입력한 값"></td>
         	 <td><label>직책</label></td>
          <td><input type="text" value="" placeholder=""></td>
        </tr>
        <tr>
          <td><label>고용타입</label></td>
          <td>
            <select>
              <option selected>정규직</option>
              <option>계약직</option>
              <option>아르바이트</option>
            </select>
          </td>
          <td><label>근무방식</label></td>
         <td>
            <select>
              <option selected>회사</option>
              <option>출장</option>
              <option>재택</option>
            </select>
          </td>
         <td><label>부서명</label></td>
         <td>
            <select>
              <option>대기</option>
              <option selected>직원</option>
              <option>관리자</option>
              <option>슈퍼관리자</option>
            </select>
          </td>
        </tr>
        <tr>
        <td><label>퇴사자</label></td>
       <td><select>
       	<option>입사</option>
       	<option>퇴사</option>
       	<option selected>퇴사대기</option>
       </select></td>
        <td><label>퇴사일자</label></td>
       <td><input type="date" value=""></td>
        <td><label>계정상태</label></td>
       <td><input type="text" value=""></td>
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
  
  function openTab(evt, tabName) {
	  const tabContents = document.querySelectorAll('.tab-content');
	  const tabBtns = document.querySelectorAll('.tab-btn');
	  tabContents.forEach(tc => tc.classList.remove('active'));
	  tabBtns.forEach(tb => tb.classList.remove('active'));
	  document.getElementById(tabName).classList.add('active');
	  evt.currentTarget.classList.add('active');
	}
  
  </script>
</body>
</html>