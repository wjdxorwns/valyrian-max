<!-- 작성자: 김기섭 | 기여자: 김재겸 -->


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="3부상조 - 인사 데이터 관리 4">
    <title>3부상조 - 인사 데이터 관리 4</title>
     <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/KimKS/CSS_origin.css' />" rel="stylesheet">
    <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style type="text/css">
#emp-data-table {
	overflow-x: visible;
}
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
    	<div id="emp-data-table">
    <table>
        <thead>
            <tr>
            	<th> <input type="checkbox" id="select-all"></th>
                <th>직원번호</th>
                <th>직원명</th>
                <th>부서</th>
                <th>직책</th>
                <th>이메일</th>
                <th>전화번호</th>
                <th>주소</th>
                <th>상세주소</th>
                <th>근무방식</th>
                <th>고용타입</th>
                <th>입사일자</th>
            </tr>
        </thead>
        <tbody>
            <tr><td><input type="checkbox" checked></td><td>001211</td><td>김진수</td><td>총무팀</td><td>사원</td><td>kimjs@gmail.com</td><td>010-1111-2222</td><td>서울</td><td>광화문</td><td>회사</td><td>정규직</td><td>2024.1.1</td></tr>
            <tr><td><input type="checkbox" ></td><td>001311</td><td>박진수</td><td>인사1팀</td><td>대리</td><td>parkjs@gmail.com</td><td>010-1212-9999</td><td>서울</td><td>광화문</td><td>재택</td><td>정규직</td><td>2022.12.1</td></tr>
            <tr><td><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
        </tbody>
    </table>
    </div>
    
   <!-- Action Buttons -->
    	<div class="action-buttons">
    		<button class="update-btn">수정</button>
    		<button class="cancel-btn">취소</button>
		</div>
	</section>
	  </main>
	   <!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />
	  <script type="text/javascript">
	  function goToUpdatePage() {
	      // 체크된 직원 가져오기
	      const checkboxes = document.querySelectorAll('input[name="empChk"]:checked');
	      if (checkboxes.length === 0) {
	        alert("직원을 선택해주세요.");
	        return;
	      }

	      const empNo = checkboxes[0].value; // 첫 번째 선택된 직원
	      // 상세페이지로 이동 (직원번호 전달)
	      window.location.href = "empDetail.jsp?empNo=" + empNo;
	    }
	  </script>
</body>
</html>