<!-- 작성자: 김기섭 | 기여자: 김재겸 -->


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="3부상조 - 퇴사자 리스트 조회">
    <title>3부상조 - 퇴사자 리스트 조회</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/KimKS/CSS_origin.css' />" rel="stylesheet">
    <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> 
    <style type="text/css">
       
.emp_information {
	width: 1215px;
	overflow-x: auto;
}

.emp_table {
	min-width: 1900px
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
	 <section class="employee-section">
		<h2>퇴사 데이터 관리</h2>
			<h4>슈퍼관리자가 퇴사자의 계정 동결 및 인사정보 조회</h4>
		<!-- Search and Filter -->
			<div>
			<div class="search-form"> 
			<!-- Action Buttons -->
				<div>
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
<div class=" emp_information">
    <table class=" emp_table">
        <thead>
            <tr> <th>직원번호</th>
                <th>직원명</th>
                <th>부서이름</th>
                <th>직책</th>
                <th>아이디</th>
                <th>생년월일</th>
                <th>성별</th>
                <th>전화번호</th>
                <th>주소</th>
                <th>상세주소</th>
                <th>입사일</th>
                <th>근무지</th>
                <th>년차</th>
                <th>고용타입</th>
                <th>근무방식</th>
                <th>부서명</th>
                <th>퇴사일자</th>
                <th>계정상태</th>
            </tr>
        </thead>
        <tbody>
			<tr><td>001211</td><td>김진수</td><td>인사1팀</td><td>사원</td><td>kjs@mycompany.kr</td><td>1999-01-01</td><td>남성</td><td>010-1111-2222</td><td>서울특별시</td><td>광화문 광화로 광화오피스</td><td>2024.1.1</td><td>경기도 연천지부</td><td>1</td><td>정규직</td><td>회사</td><td>직원</td>
			<td>2025.5.1</td><td>휴면</td></tr>
			<tr><td>001211</td><td>김진수</td><td>인사1팀</td><td>사원</td><td>kjs@mycompany.kr</td><td>1999-01-01</td><td>남성</td><td>010-1111-2222</td><td>서울특별시</td><td>광화문 광화로 광화오피스</td><td>2024.1.1</td><td>경기도 연천지부</td><td>1</td><td>정규직</td><td>회사</td><td>직원</td>
			<td>2025.5.1</td><td>휴면</td></tr>
			<tr><td>001211</td><td>김진수</td><td>인사1팀</td><td>사원</td><td>kjs@mycompany.kr</td><td>1999-01-01</td><td>남성</td><td>010-1111-2222</td><td>서울특별시</td><td>광화문 광화로 광화오피스</td><td>2024.1.1</td><td>경기도 연천지부</td><td>1</td><td>정규직</td><td>회사</td><td>직원</td>
			<td>2025.5.1</td><td>휴면</td></tr>
        
        </tbody>
    </table>
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