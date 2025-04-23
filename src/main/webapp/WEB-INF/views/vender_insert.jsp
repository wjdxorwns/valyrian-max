<!-- 작성자 : 김용호 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" 
    href="${pageContext.request.contextPath}/resources/css/CSS.css">
<style type="text/css">
*{
margin: 0;
padding:0;
box-sizing: border-box;
}
h2{
font-size: 50px;
margin:5px 50px;
}
p{
margin:5px 50px;
}
#insert-box{
border:1px solid black;
margin:30px;
padding:10px;
width: 650px;
}
#insert-box ul li{
  display: flex;
  justify-content: space-between; /* label 왼쪽, input 오른쪽 */
  align-items: center;
  margin: 10px;
}
#insert ul li input{
width:500px;
display: flex;
justify-content: center;
align-items: center;
}
ul{
list-style: none;
}
#insert-box input{
margin:5px;
padding:5px;
width:500px;
}
button{
padding:5px;
margin: 10px;
justify-content: flex-end;
align-items: center;
}
</style>
</head>
<body>


<header id="main-header">
	<div id="logo"><a href="/">3부상조</a></div>
	<nav>
		<ul class="nav-items">
			<li><a href="/">거래처 등록</a></li>
			<li><a href="/item_insert">품목 등록 <span class="badge">0</span></a></li>
			<li><a href="/orders">재고 조정</a></li>
			<li><a href="/signup">구매 관리</a></li>
			<li><a href="/login">판매 관리</a></li>
			<li><a href="">공지사항</a></li>
		</ul>
	</nav>
</header>

  <!-- Sidebar for Desktop -->
<aside id="sidebar">
	<nav>
		<ul class="form-list">
			<li><a id="item_insert" href="/item_insert" style="font-size: 15px;">
					거래처 등록</a></li>
			<li><a id="item_detail" href="/item_detail" style="font-size: 15px;">
					거래처 조회/목록</a></li>
		</ul>
	</nav>
</aside>
<form id="main_body" action="/vender_insert_ok" method="post" encType="multipart/form-data">
	<div id="header">
		<h2>거래처 등록</h2>
		<p>신규 거래처 등록</p>
	</div>
	<div id="insert-box">
		<ul>
			<li><label>거래처명 : </label><input type="text" name="${vender_name }"></li>
			<li><label>연락처 : </label><input type="text" name="${contact_info }"></li>
			<li><label>e-mail : </label><input type="text" name="${vender_email }"></li>
			<li><label>주소 : </label><input type="text" name="${address }"></li>
		</ul>
		<button type="submit">등록</button>
	</div>
</form>

</body>
</html>