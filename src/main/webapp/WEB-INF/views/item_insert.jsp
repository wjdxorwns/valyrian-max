<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품목등록</title>
<link rel="stylesheet" 
    href="${pageContext.request.contextPath}/resources/css/CSS.css">
<style type="text/css">
* {
margin: 0;
padding: 0;
box-sizing: border-box;
}
body {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}
.item{
font-size: 30px;
}
.main_body{
margin:20px;
}
.container{
box-sizing: border-box;
}
h2{
font-size: 50px;
margin:5px 50px;
}
p{
margin:5px 50px;
}
#insert_box{
background-color: #fff;
border: 1px solid black;
margin: 20px auto;
/* width:auto;
max-width:100rem; */
height:600px;
}
.upload-box{
border:1px solid black;
margin:20px;
width:300px;
height:200px;
justify-content: center;
align-items: center; 
display: flex;
background-color: #fff;
}
.form-list {
  width: 100%;
  margin: 0 auto;
  padding: 10px;
}

.form-list li {
  display: flex;
  justify-content: space-between; /* 좌우로 분리 정렬 */
  align-items: center;
  margin-bottom: 15px;
}

.form-list label {
flex: 1;
text-align: left;
font-weight: bold;
}

.form-list input[type="text"] {
width: 85%;
padding: 6px 10px;
border: 1px solid #ccc;
border-radius: 4px;
}
ul{
list-style: none;
}
ul li{
margin:0 5px;
padding:5px;
}

.form-buttons{
text-align: right;
margin:10px;
padding:10px;
}
.form-buttons input{
margin:5px;
padding:0 10px;
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
<form id="main_body" action="/item_insert_ok" method="post" encType="multipart/form-data">
<div id="container">
<h2>품목 등록</h2>
<p>품목 정보를 등록하기 위해 필요합니다</p>
<div id="insert_box">
	<label for="photoUpload">
		<div class="upload-box">사진을 넣어주세요</div>
    </label>
	<input type="file" id="photoUpload" name="uploadFile" hidden />
	<ul class="form-list">
		<li>
			<label for="item_name">품목명(규격) : </label>
			<input type="text" id="item_name" name="item_name" required>
		</li>
		<li>
			<label for="">거래처코드 : </label>
			<input type="text" id="" name="" required>
		</li>
    	<li>
    		<label for="">상호 : </label>
			<input type="text" id="" name="" required>
		</li>
    	<li>
    		<label for="category">분류 : </label>
			<input type="text" id="category" name="category" required>
		</li>
    	<li>
    		<label for="">재고 수량 : </label>
			<input type="text" id="" name="" required>
		</li>
    	<li>
    		<label for="unit_price">재고 단가 : </label>
			<input type="text" id="unit_price" name="unit_price" required>
		</li>
	</ul>
    <div class="form-buttons">
    	<input type="button" value="등록" onclick="item_insert_ok(this.form)">
    	<input type="button" value="취소" onclick="item_list(this.form)">
	</div>
</div>
</div>
</form>
  
<script type="text/javascript">
function item_insert_ok(f) {
	f.action="/item_insert_ok";
	f.submit();
}
</script>

</body>
</html>