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
#update{
border:1px solid black;
width:400px;
height:400px;
justify-content: center;
margin:auto;
background-color: #fff;
}
#header{
border-bottom:1px solid black;
margin:0;
background-color: skyblue;
text-align: center;
}
#update-box{
margin:10px ;
padding:10px;
border:1px solid black;
background-color: #ADD8E6;
}
#update-box input{
justify-content: center;
align-items: center;
display: flex;
width:350px;
height:30px;
}
#update-box label{
text-align: left;
margin:5px auto;
}
ul{
list-style: none;
}
#button-box{
justify-content: flex-end;
align-items: right;
}
#button-box button{
padding:5px;
margin:auto 10px;
justify-content: flex-end;
align-items: right;
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
	<div id="update">
		<div id="header">거래처 정보 수정</div>
		<div id="update-box">
			<ul>
				<li>거래처 코드<input type="text" name="" ></li>
				<li>상호<input type="text" name=""></li>
				<li>전화 번호<input type="text" name=""></li>
				<li>e-mail<input type="text" name=""></li>
				<li>주소<input type="text" name=""></li>
			</ul>
		</div>
		<div id="button-box">
			<button type="submit">수정</button>
			<button type="reset">닫기</button>
		</div>
	</div>
</form>

</body>
</html>