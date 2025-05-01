<!-- 작성자: 김기섭 | 기여자: 김재겸 -->


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="3부상조 - 인사 데이터 관리 3">
<title>3부상조 - 인사 데이터 관리 3</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/KimKS/CSS_pop_up.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/KimKS/CSS_origin.css' />" rel="stylesheet">
    <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> 
    <style type="text/css">


</style>
</head>
<body>
		<!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />

	<!-- Main Content -->
	<main>
		<section class="employee-section">
			<h2>인사 데이터 관리</h2>
			<h4>관리자가 임직원의 호봉, 부서 등 인사정보 관리</h4>

		<div class="container">
				<div class="section">
					<div class="row">
						<label>직원번호</label> <input type="text" value="">
						<button>중복확인</button>
					</div>
					<div class="row">
						<label>직원명</label> <input type="text" value="" readonly>
					</div>
					<div class="row">
						<label>부서</label> <input type="text" value="" readonly>
					</div>
					<div class="row">
						<label>직책</label> <input type="text" value="" readonly>
					</div>
					<div class="row">
						<label>이메일</label> <input type="text" value="">
					</div>
					<div class="row">
						<label>전화번호</label> <input type="text" value="">
					</div>

				</div>

				<div class="section">
					<div class="row">
						<label>주소</label> <input type="text" value="" >
					</div>

					<div class="row">
						<label>상세주소</label> <input type="text" value="">
					</div>

					<div class="row">
						<label>근무방식</label> <select>
							<option>회사</option>
							<option>출장</option>
							<option>재택</option>
						</select>
					</div>

					<div class="row">
						<label>고용타입</label> <select>
							<option>정규직</option>
							<option>계약직</option>
							<option>아르바이트</option>
						</select>
					</div>
					
					<div class="row">
						<label>호봉</label> <input type="number" value="">
					</div>
					
					<div class="row">
						<label>입사일자</label> <input type="date" value="">
					</div>
				</div>
			</div>
			
			<!-- Action Buttons -->
			<div class="action-buttons">
				<button class="update-btn">수정</button>
				<button class="cancel-btn">취소</button>
			</div>
		</section>
	
	
	<!-- 모달 팝업 -->
	<div id="popup" class="modal hidden">
  	<div class="modal-content">
    <p>해당 직원의 인사정보를 최신화 하겠습니까?</p>
    <div class="btn-group">
      <button onclick="confirmUpdate()">확인</button>
      <button onclick="closePopup()">취소</button>
    </div>
  </div>
</div>

</main>
  <!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />
	<script type="text/javascript">
  function openPopup() {
    document.getElementById('popup').classList.remove('hidden');
  }

  function closePopup() {
    document.getElementById('popup').classList.add('hidden');
  }

  function confirmUpdate() {
    alert("직원 정보가 업데이트되었습니다.");
    closePopup();
  }
</script>	
</body>
</html>