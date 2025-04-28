<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 메인 페이지</title>
<link rel="stylesheet" 
    href="${pageContext.request.contextPath}/resources/css/CSS.css">
    
</head>
<body>
	<header id="main-header">
    <div id="logo"><a href="/main">3부상조</a></div>
    <nav>
      <ul class="nav-items">
        <li><a href="/">직원등록</a></li>
        <li><a href="/">근무지정</a></li>
        <li><a href="/">인사관리</a></li>
        <li><a href="/">급여</a></li>
        <li><a href="/">휴가</a></li>
      </ul>
    </nav>
  </header>

  <!-- 사이드바 -->
  <aside id="sidebar">
    <nav>
      <ul>
        <li><a href="/">직원등록</a></li>
        <li><a href="/">근무지정</a></li>
        <li><a href="/">인사</a></li>
        <li><a href="/">급여</a></li>
        <li><a href="/">휴가</a></li>
      </ul>
    </nav>
  </aside>
  

  

  <main >
  <h2>인사 관리</h2>
  <p class="description">내용 설명 - 관리자가 임직원의 호봉, 부서 등 인사정보 관리</p>    

    <div style="display: flex; align-items: center; justify-content: flex-end; margin: 20px 0;">
        <label for="search" style="margin-right: 10px;">부서</label>
        <input type="text" id="search" placeholder="검색어 입력" style="margin-right: 10px;">
        <button type="button">검색</button>
    </div>

    <table>
        <thead>
            <tr>
                <th></th>
                <th>직원번호</th>
                <th>직원이름</th>
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
            <tr>
                <td><input type="checkbox"></td>
                <td></td><td></td><td></td><td></td><td></td>
                <td></td><td></td><td></td><td></td>
            </tr>
        </tbody>
    </table>

    <div style="text-align: center; margin-top: 20px;">
        <button type="button">수정</button>
        <button type="button">취소</button>
    </div>
</main>
</body>
</html>