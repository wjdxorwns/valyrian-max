<!-- 작성자: 김기섭 | 기여자: 김재겸 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="3부상조 - 보직 발령">
<title>3부상조 - 보직 발령</title>
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/KimKS/CSS_personnel_change_detail.css' />" rel="stylesheet">
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
		<h2>보직 이동</h2>
		<h4>관리자가 해당 직원 보직 변경 및 진급 관리</h4>
		
		<!-- Search and Filter -->
			<div>
			<div class="search-form">
				<div>
					<label class="department">부서</label> <select class="department">
						<option>영업1팀</option>
						<option>영업2팀</option>
						<option>인사1팀</option>
						<option>인사2팀</option>
						<option>총무팀</option>
					</select>
					 <select class="employee">
						<option>직원명</option>
						<option>직원번호</option>
						<option>부서</option>
						<option>직책</option>
					</select>
					<input type="text" placeholder="검색">
					<button>검색</button>
				</div>
			</div>
		</div>

		 <!-- Detail Table -->
    <table>
        <thead>
            <tr>
            	<th class="checkbox"> <input type="checkbox" id="select-all"></th>
                <th>직원번호</th>
                <th>직원명</th>
                <th>부서</th>
                <th>직책</th>
                <th>호봉</th>
                <th>발령 유형</th>
                <th>발령 부서</th>
                <th>발령일</th>
            </tr>
        </thead>
        <tbody>
            <!-- 데이터 로딩 -->
            <tr><td class="checkbox"><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td class="checkbox"><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td class="checkbox"><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td class="checkbox"><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
        </tbody>
    </table>
   
   <div class="detail-section">
  <h3>세부 내용</h3>
  <div class="detail-row">
    <label>직원번호:</label> <input type="text" name="emp_id" />
  </div>
  <div class="detail-row">
    <label>직원명:</label> <input type="text" name="emp_name" />
  </div>
  <div class="detail-row">
    <label>직책:</label> <input type="text" name="position" />
  </div>
  <div class="detail-row">
    <label>호봉:</label> <input type="number" name="pay_grade" />
  </div>
  <div class="detail-row">
    <label>발령 유형:</label> <select name="change_type">
    	<option>사내</option>
    	<option>전출</option>
    </select>
  </div>
  <div class="detail-row">
    <label>발령 부서:</label> <input type="text" name="new_dept_id" />
  </div>
  <div class="detail-row">
    <label>발령일:</label> <input type="date" name="change_date" />
  </div>
</div>
  <!-- Action Buttons -->
    	<div class="action-buttons">
    		<button class="update-btn">저장</button>
    		<button class="cancel-btn">취소</button>
		</div>
	</section>
</main>
   <!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />
</body>

</html>