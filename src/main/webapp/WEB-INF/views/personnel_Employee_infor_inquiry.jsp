<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 메인 페이지</title>
<style type="text/css">
/* Reset default styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Arial', sans-serif;
    line-height: 1.6;
    background-color: #f0f8ff; /* Light sky blue background */
    color: #333;
}

/* Header Styles */
#main-header {
    background-color: #87ceeb; /* Sky blue theme */
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: fixed;
    width: 100%;
    top: 0;
    z-index: 1000;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

#logo a {
    color: #fff;
    text-decoration: none;
    font-size: 1.5rem;
    font-weight: bold;
}

.nav-items {
    list-style: none;
    display: flex;
    gap: 1.5rem;
}

.nav-items li a {
    color: #fff;
    text-decoration: none;
    padding: 0.5rem 1rem;
    transition: all 0.3s ease;
    font-size: 1rem;
}

.nav-items li a:hover {
    background-color: #6ab7d5; /* Slightly darker sky blue on hover */
    border-radius: 4px;
}

.badge {
    background-color: #ff6b6b; /* Coral red for badge */
    color: #fff;
    padding: 0.2rem 0.5rem;
    border-radius: 12px;
    font-size: 0.8rem;
}

/* Mobile Menu Button */
#mobile-menu-btn {
    display: none;
    background: none;
    border: none;
    cursor: pointer;
}

#mobile-menu-btn span {
    display: block;
    width: 25px;
    height: 3px;
    background-color: #fff;
    margin: 5px 0;
    transition: all 0.3s ease;
}

/* Mobile Menu */
#mobile-menu {
    display: none;
    position: fixed;
    top: 0;
    right: -250px;
    width: 250px;
    height: 100%;
    background-color: #87ceeb; /* Sky blue theme */
    padding: 5rem 2rem 2rem;
    transition: all 0.3s ease;
}

#mobile-menu.active {
    right: 0;
}

/* Sidebar (Aside) Styles */
#sidebar {
    position: fixed;
    top: 60px; /* Below the header */
    left: 0;
    width: 200px;
    height: calc(100vh - 60px);
    background-color: #fff;
    border-right: 1px solid #ddd;
    padding: 1rem;
    z-index: 999;
}

#sidebar nav ul {
    list-style: none;
}

#sidebar nav ul li {
    margin-bottom: 1rem;
}

#sidebar nav ul li a {
    color: #333;
    text-decoration: none;
    font-size: 1rem;
    display: block;
    padding: 0.5rem;
    transition: all 0.3s ease;
}

#sidebar nav ul li a:hover {
    background-color: #e0f4ff; /* Very light sky blue on hover */
    border-radius: 4px;
    color: #4682b4; /* Steel blue for text on hover */
}

/* Main Content */
main {
    margin-top: 60px; /* Space for header */
    margin-left: 200px; /* Space for sidebar */
    padding: 2rem;
    max-width: calc(100% - 200px);
    min-height: calc(100vh - 60px);
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80') no-repeat center center/cover;
    color: #fff;
    text-align: center;
}

.hero-section {
    background-color: rgba(255, 255, 255, 0.9);
    padding: 2rem 3rem;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    max-width: 600px;
}

.hero-section h1 {
    font-size: 2rem;
    color: #333;
    margin-bottom: 1rem;
}

.hero-section p {
    font-size: 1.1rem;
    color: #666;
    margin-bottom: 1.5rem;
}

.hero-section .btn {
    display: inline-block;
    padding: 0.75rem 1.5rem;
    background-color: #87ceeb; /* Sky blue theme */
    color: #fff;
    text-decoration: none;
    border-radius: 4px;
    transition: all 0.3s ease;
}

.hero-section .btn:hover {
    background-color: #6ab7d5; /* Slightly darker sky blue on hover */
}

/* Responsive Design */
@media (max-width: 768px) {
    /* Hide desktop nav and show mobile menu button */
    .nav-items {
        display: none;
    }

    #mobile-menu-btn {
        display: block;
    }

    #mobile-menu {
        display: block;
    }

    /* Hide sidebar on mobile */
    #sidebar {
        display: none;
    }

    /* Adjust main content for mobile */
    main {
        margin-left: 0;
        max-width: 100%;
    }

    .hero-section {
        padding: 1.5rem;
    }

    .hero-section h1 {
        font-size: 1.5rem;
    }

    .hero-section p {
        font-size: 1rem;
    }
}

/* Additional Styling */
a {
    transition: color 0.3s ease;
}

a:hover {
    color: #4682b4; /* Steel blue for links on hover */
}
/* 직원 리스트 표시 하는 테이블 부분 */
table {
  width: 100%;
  border-collapse: collapse;
  margin: 20px 0;
  font-size: 16px;
  font-family: sans-serif;
  text-align: center;
}

table th, table td {
  padding: 12px 15px;
  border: 2px solid black;
}

table thead {
  background-color: #87ceeb;
  text-align: center;
}





#main-body{
	margin-top: 100px; 
	 margin-left: 200px;
}
/* 화면 명칭 */
h2{ margin : 25px;}
/* 설명란 */
h4{ 
margin-left : 25px;
margin-bottom: 30px;
 }
#search_member {
margin-left :50%;
display : flex;
gap : 10px;
}
#search_member input[type="text"] {
	background-color: white;
	color : black;
	border : 1px solid black;
	padding : 5px ;
	cursor: pointer;
	font-size: 16px;
}
</style>
</head>
<body>
	<header id="main-header">
    <div id="logo"><a href="/">3부상조</a></div>
    <nav>
      <ul class="nav-items">
        <li><a href="/">직원 정보 조회(H)</a></li>
        <li><a href="/cart">근무 지정</a></li>
        <li><a href="/orders">인사 관리</a></li>
        <li><a href="/signup">급여</a></li>
        <li><a href="/login">휴가</a></li>
      </ul>
    </nav>
    <button id="mobile-menu-btn">
      <span></span>
      <span></span>
      <span></span>
    </button>
  </header>

  <!-- Mobile Menu -->
  <aside id="mobile-menu">
    <nav>
      <ul class="nav-items">
        <li><a href="/">직원 정보 조회(L)</a></li>
        <li><a href="/cart">근무 지정</a></li>
        <li><a href="/orders">인사 관리</a></li>
        <li><a href="/signup">급 여</a></li>
        <li><a href="/login">휴 가</a></li>
      </ul>
    </nav>
  </aside>

  <!-- Sidebar for Desktop -->
  <aside id="sidebar">
    <nav>
      <ul>
        <li><a href="/">직원 정보 조회(L)</a></li>
        <li><a href="/cart">근무 지정</a></li>
        <li><a href="/orders">인사 관리</a></li>
        <li><a href="/signup">급 여</a></li>
        <li><a href="/login">휴 가</a></li>
      </ul>
    </nav>
  </aside>
<div id="main-body">
  <h2>직원 정보 조회</h2>
  <h4>모든 직원들의 정보를 확인합니다.</h4>
<form id="search_member" method="post" >
 
  <input type="text" name="name" onclick="send_search('/emp_name', this.form)">
  <input type="button" value="이름 검색">
  

  <input type="text" name="name"  onclick="send_search('/emp_id', this.form)"> 
  <input type="button" value="사번 검색">
    
</form> 
	<table>
		<thead>
			<tr>
				<th>이 름</th>
				<th>직원 번호(사번)</th>
				<th>E-Mail</th>
				<th>부 서</th>
				<th>직 책</th>
				<th>호 봉</th>
				<th>입사일</th>
				<th>전화 번호</th>
				<th>주 소</th>
				<th>퇴사일</th>
			</tr>	
		</thead>
		<tbody>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</tbody>
	</table>
</div>
</body>
</html>