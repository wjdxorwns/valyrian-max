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
#search-box{
display: flex;
justify-content:flex-end;
}
#search-box input{
margin: 5px;
padding:5px;
}
#information-box{
border: 1px solid black;
background-color: #fff;
padding:10px;
margin:20px;
max-width: 800px;
}
#image-box{
border:1px solid black;
width:500px;
height:300px;
margin: 20px auto;
}
#button-box{
display: flex;
justify-content:flex-end;
margin:0 20px;
padding:10px;
}
#button-box input{
margin:10px;
padding:10px;
}
ul{
list-style: none;
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
					품목 등록</a></li>
			<li><a id="item_detail" href="/item_detail" style="font-size: 15px;">
					상세 품목 조회</a></li>
			<li><a id="/item_list" href="/item_list" style="font-size: 15px;">
					전체 품목 조회</a></li>
		</ul>
	</nav>
</aside>

<form id="main_body" action="/item_detail" method="post" encType="multipart/form-data">
	<div>
		<h2>상세 품목 조회</h2>
		<p>선택한 품목의 상세 정보를 조회합니다.</p>
	</div>
	<div id="information-box">
		<div id="search-box">
			<input type="text" name="item_name" placeholder="품목명 검색" value="${item_name}" />
			<input type="submit" value="조회" />
		</div>
		<div id="image-box">
			<a href="/bbs_down?f_name=${itemvo.file_name}">
				<img width="150px" src='<c:url value="/resources/upload/${itemvo.file_name}" />'>
			</a>
		</div>
		<ul>
			<li>품목코드 : ${itemvo.item_id } </li>
			<li>품목명 : ${itemvo.item_name }</li>
			<li>가격 : ${itemvo.unit_price }</li>
			<li>분류 : ${itemvo.category }</li>
		</ul>
	</div>
	<div id="button-box">
		<input type="button" value="목록으로" onclick="/item_list">
		<input type="button" value="수정" onclick="/item_update">
	</div>
	
</form>

</body>
</html>