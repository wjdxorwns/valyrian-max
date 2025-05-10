<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 작성자: 김재겸 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근무 계획 신청 - 근무지 발령 확인 리스트</title>
    <link href="<c:url value='/resources/css/KimJK/CSS_working_list.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
	<link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
</head>
<body>
	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />
	
	<main>
	  <h2>근무 계획 신청</h2>
	  <h4>근무지 발령 확인 리스트</h4>
	  
	  <div class="location_list">
	    <div class="style_list">
	      <table class="style_table">
	      	<thead>
	      		<tr scope="col">
	      		  <th>이름</th>
	      		  <th>발령 유형</th>
	      		  <th>신청한 부서명</th>
	      		  <th>신청한 근무지</th>
	      		  <th>이전 부서명</th>
	      		  <th>변경된 부서명</th>
	      		  <th>이전 근무지</th>
	      		  <th>변경된 근무지</th>
	      		  <th>고용 타입</th>
	      		  <th>승인여부</th>
	      		</tr>
	      	</thead>
	      	<tbody>
	      		<tr>
	      		  <td>${UsersVO.getEmp_name}</td>
	      		  <td>${PersonnelChangeVO.getPrev_dept_id}</td>
	      		  <td>${PersonnelChangeVO.getNew_dept_id}</td>
	      		  <td></td>
	      		  <td></td>
	      		  <td></td>
	      		  <td></td>
	      		  <td></td>
	      		</tr>
	      	</tbody>
	      </table>
	    </div>
	  </div>
	  <div class="location_button">
	  	<button id="update_data" onclick="update_data()">수정하기</button><button id="cancel_page" onclick="cancel_page()">취소</button>
	  </div>
	</main>
	
	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />
	
	<script type="text/javascript">
	  function update_data(){
		  location.href = "/그냥 쌈뽕한 수정하기 컨트롤러로 ㄱㄱ";
	  }

	  function update_data() {
		location.href = "/되돌아가기 기능 컨트롤러로 ㄱㄱ";
	  }
	  
	</script>
</body>
</html>