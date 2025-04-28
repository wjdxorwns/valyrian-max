<!-- 김기섭 -->


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="3부상조 - 퇴사 데이터 관리 1">
    <title>3부상조 - 퇴사 데이터 관리 1</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="<c:url value='/resources/css/CSS.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/CSS_working_ways.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
    <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> 
    <style type="text/css">
        /* Override and enhance styles for payroll info page */
        body {
            font-family: 'Roboto', sans-serif; /* Use Roboto for consistency */
        }

        main {
            margin-top: 60px;
            margin-left: 200px;
            padding: 2rem;
            max-width: calc(100% - 200px);
            min-height: calc(100vh - 60px);
            background: none; /* Remove background image for clarity */
            color: #333;
            text-align: left;
        }

        .employee-section {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            max-width: 100%;
        }

        .employee-section h2 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 1rem;
            margin-left: 0; /* Override CSS_working_ways.css */
        }

        .employee-section h4 {
            font-size: 1.2rem;
            color: #666;
            margin-bottom: 2rem;
            margin-left: 0; /* Override CSS_working_ways.css */
        }

        /* Search and Filter Area */
        .search-filter {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .search-filter input[type="text"] {
            padding: 0.5rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
            width: 200px;
        }

        .search-filter select {
            padding: 0.5rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
            width: 150px;
            appearance: none;
            padding-right: 2rem;
        }

        .search-filter .total-cost {
            font-size: 1rem;
            color: #333;
            font-weight: bold;
        }

		

        /* Table Styles (Enhanced from CSS.css) */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
            font-size: 1rem;
            text-align: center;
        }

        table th,
        table td {
            padding: 1rem;
            border: 1px solid #ddd;
        }

        table thead {
            background-color: #87ceeb; /* Sky blue theme */
            color: #fff;
        }

        table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table tbody tr:hover {
            background-color: #e0f4ff; /* Light sky blue on hover */
        }

        table input[type="checkbox"] {
            cursor: pointer;
        }
        
        tbody td {
    	text-align: center;		
}

        /* Action Buttons */
        .action-buttons {
            margin-top: 1rem;
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }

        .action-buttons button {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .download-btn {
            background-color: #87ceeb;
            color: #fff;
        }

        .download-btn:hover {
            background-color: #6ab7d5;
        }

        .cancel-btn {
            background-color: #ccc;
            color: #333;
        }

        .cancel-btn:hover {
            background-color: #bbb;
        }

       
      #NameSearch {
      	margin-left: 540px;
      } 
</style>
</head>
<body>
	<!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />
    <header id="main-header">
        <div id="logo"><a href="/">3부상조</a></div>
        <nav>
            <ul class="nav-items">
        <li><a href="/">직원등록</a></li>
        <li><a href="/">근무 지정</a></li>
        <li><a href="/">인사 관리</a></li>
        <li><a href="/">급여</a></li>
        <li><a href="/">휴가</a></li>
      </ul>
        </nav>
    </header>

    <!-- Sidebar -->
    <aside id="sidebar">
        <nav>
            <ul>
                <li><a href="/">인사관리</a></li>
                <li><a href="/payrollInfo">인사 데이터 관리</a></li>
                <li><a href="/payrollInfo">퇴사 데이터 관리</a></li>
                <li><a href="/payrollInfo">보직 이동</a></li>
            </ul>
        </nav>
    </aside>
    
<!-- Main Content -->
<main>
	 <section class="employee-section">
		<h2>퇴사 데이터 관리</h2>
		<h4>관리자가 퇴사자의 인사정보 관리 및 계정 동결</h4>
		
		<!-- Search and Filter -->
			<div id="NameSearch">		
			<input type="text" value="001" placeholder="직원명/직원번호 입력 "> 
			<input type="button" value="검색">
			</div>

		 <!-- Detail Table -->
    <table>
        <thead>
            <tr>
            	<th> <input type="checkbox" id="select-all"></th>
                <th>직원번호</th>
                <th>직원명</th>
                <th>부서</th>
                <th>직책</th>
                <th>호봉</th>
                <th>근무형태</th>
                <th>입사일자</th>
                <th>퇴사일자</th>
                <th>계정상태</th>
            </tr>
        </thead>
        <tbody>
            <tr><td><input type="checkbox"></td><td>001123</td><td>김진수</td><td>총무1팀</td><td>사원</td><td>1</td><td>정상</td><td>25.1.1</td><td></td><td>정상</td></tr>
            <tr><td><input type="checkbox" checked></td><td>001211</td><td>박진수</td><td>총무1팀</td><td>주임</td><td>2</td><td>정상</td><td>24.1.1</td><td></td><td>정상</td></tr>
            <tr><td><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td><input type="checkbox"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
        </tbody>
    </table>
    
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