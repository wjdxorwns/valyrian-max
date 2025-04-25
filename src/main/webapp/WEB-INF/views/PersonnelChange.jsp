<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 보직 발령</title>
<style type="text/css">
@charset "UTF-8";
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
    width: 1200px;
    margin: 0 auto;
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


/* Additional Styling */
a {
    transition: color 0.3s ease;
}

a:hover {
    color: #4682b4; /* Steel blue for links on hover */
}

#main_body{
	margin-top: 100px; 
	margin-left : 300px;
}

#detail{
	margin-left : 300px;
	margin-bottom: 10px; 

}
table th, table td {
            border: 1px solid #aaa;
            padding: 8px;
            text-align: center;
        }
  table thead {
           background-color: #87ceeb;
        }
        
  
#search_member {
margin-left :0%;
display : flex;
gap : 10px;
padding-bottom :10px;



}

.table_container {
    width: 800px;
    overflow-x: auto;
    margin-bottom: 40px;  /* 여기에 여백을 크게 설정 */
}


#positionTableBody{
	background-color: white; 
}

</style>
</head>
<body>
	<header id="main-header">
		<div id="logo">
			<a href="/">3부상조(H)</a>
		</div>
		<nav>
			<ul class="nav-items">
				<li><a href="/">직원 정보 조회</a></li>
				<li><a href="/cart">근무 지정 <span class="badge">0</span></a></li>
				<li><a href="/orders">인사 관리</a></li>
				<li><a href="/signup">급여</a></li>
				<li><a href="/login">휴가</a></li>
			</ul>
		</nav>
		<button id="mobile-menu-btn">
			<span></span> <span></span> <span></span>
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
				<li><h2>
						<a href="/">인사관리</a>
					</h2></li>
				<li><h4>
						<a href="/cart">보직이동</a>
					</h4></li>
			</ul>
		</nav>
	</aside>

	<div id="main_body">
		<h2>보직 이동</h2>
		<h4>보직 및 발령을 설정</h4>
		<form id="search_member" method="post">
			<input type="text" name="name" onclick="send_search('/emp_name', this.form)"> 
			<input type="button" value="이름 검색">
		</form>
		
		
    <table class="table_container" border="1">
        <thead>
            <tr>
                <th></th>
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
        <tbody id="positionTableBody">
            <!-- 데이터 로딩 -->
            <tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
        </tbody>
    </table>
    </div>
    <div id="detail">
    <h3>세부 내용</h3>
    <label>직원명: <input type="text" name="empName" /></label><br />
    <label>발령 구분: <input type="text" name="changeType" /></label><br />
    <label>발령 사항: <input type="text" name="changeDesc" /></label><br />
    <label>발령일: <input type="date" name="changeDate" /></label><br />
    <label>발령 부서: <input type="text" name="newDept" /></label><br />

    <button type="submit">저장</button>
    <button type="reset">신규</button>
    <button type="button">삭제</button>
	</div>
</body>
</html>