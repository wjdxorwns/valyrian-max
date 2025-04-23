<!-- 작성자 : 김용호 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래저 조회, 리스트</title>
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
#main{
border:1px solid black;
margin:10px;
padding:10px;
max-width: 1500px;
}
#search-box{
display: flex;
justify-content: flex-end;
}
#search-box input{
margin:0 5px;
padding:5px;
}
table{
text-align: center;
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
			<li><a id="item_insert" href="/vender_insert" style="font-size: 15px;">
					거래처 등록</a></li>
			<li><a id="item_detail" href="/vender_list" style="font-size: 15px;">
					거래처 조회/목록</a></li>
		</ul>
	</nav>
</aside>
<form id="main_body" action="/vender_update_ok" method="post" encType="multipart/form-data">
	<div id="header">
		<h2>거래처 조회/리스트</h2>
		<p>전체 거래처 목록을 확인합니다.</p>
	</div>
	<div id="main">
		<div id="search-box">
			<input type="text" value="코드검색" name="${ vendor_id}">
			<input type="button" value="검색" onclick="">
			<input type="text" value="상호명 검색" name="${ vendor_name}">
			<input type="button" value="검색" onclick="">
		</div>
		<div>
			<table>
				<thead>
					<tr>
						<th>no.</th><th>거래처 코드</th><th>상호</th><th>전화번호</th><th>e-mail</th><th>주소</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty items}">
						<tr>
							<td colspan="7">등록된 품목이 없습니다. 품목을 등록하세요.</td>
						</tr>
					</c:if>
					<c:forEach var="vender" items="${vender_id}">
						<tr>
							<td>${count}</td>
							<td>${vender_id}</td>
 							<td><a href="/vender_detail?code=${vender.vender_name}">${vender.vender_name}</td>
							<td>${vender.contact_info}</td>
							<td>${vender.vender_email}</td>
							<td>${vender.address}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</form>

</body>
</html>