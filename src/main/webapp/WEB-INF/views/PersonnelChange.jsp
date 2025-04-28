<!-- 김기섭 -->


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
        
        /* 체크박스 열 너비 조정 */
	tbody td:first-child,
	thead th:first-child {
    width: 100px;
    text-align: center;
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
      
     /* 세부내용  */
     
     .detail-section {
      margin-top: 20px;
      padding: 15px;
      border: 1px solid #ccc;
      border-radius: 5px;
      background-color: #f9f9f9;
    }

    .detail-section h3 {
      margin-top: 0;
      margin-bottom: 15px;
      font-size: 1.2em;
      font-weight: bold;
    }

    .detail-row {
      display: flex;
      align-items: center; /* 라벨과 입력 필드 세로 중앙 정렬 */
      margin-bottom: 10px;
    }

    .detail-row label {
      width: 100px; /* 라벨 너비 고정 (조정 가능) */
      margin-right: 10px;
      font-weight: bold;
      display: inline-block; /* 너비 적용을 위해 block 속성 부여 */
    }

    .detail-row input[type="text"],
    .detail-row input[type="date"] {
      flex-grow: 1; /* 남은 공간 모두 차지 */
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 3px;
      box-sizing: border-box; /* padding, border가 전체 너비에 포함되도록 */
    }

    .detail-row br {
      display: none; /* 기존 <br> 태그 제거 */
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
                <li><a href="/payrollInfo">보직 이동</a></li>
            </ul>
        </nav>
    </aside>
    
<!-- Main Content -->

<main>
	 <section class="employee-section">
		<h2>보직 이동</h2>
		<h4>관리자가 임직원의 호봉, 부서 등 인사정보 관리</h4>
		
		<!-- Search and Filter -->
			<div id="NameSearch">		
			<input type="text" value="" placeholder="직원명/직원번호 입력 "> 
			<input type="button" value="검색">
			</div>

		 <!-- Detail Table -->
    <table>
        <thead>
            <tr>
                <th>직원번호</th>
                <th>직원명</th>
                <th>부서</th>
                <th>직책</th>
                <th>발령 구분</th>
                <th>발령 부서</th>
                <th>발령일</th>
                <th>발령사항</th>
            </tr>
        </thead>
        <tbody>
            <!-- 데이터 로딩 -->
            <tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
        </tbody>
    </table>
   
   <div class="detail-section">
  <h3>세부 내용</h3>
  <div class="detail-row">
    <label>직원명:</label> <input type="text" name="empName" />
  </div>
  <div class="detail-row">
    <label>발령 구분:</label> <input type="text" name="changeType" />
  </div>
  <div class="detail-row">
    <label>발령 사항:</label> <input type="text" name="changeDesc" />
  </div>
  <div class="detail-row">
    <label>발령일:</label> <input type="date" name="changeDate" />
  </div>
  <div class="detail-row">
    <label>발령 부서:</label> <input type="text" name="newDept" />
  </div>
</div>
  <!-- Action Buttons -->
    	<div class="action-buttons">
    		<button class="create-btn">신규</button>
    		<button class="update-btn">저장</button>
    		<button class="cancel-btn">취소</button>
		</div>
	</section>
</main>
   <!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />
</body>

</html>