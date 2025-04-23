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
margin-right: 50px;
padding:10px;
}
#search-box input{
margin: 0 5px;
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
		<h2>전체 품목 조회</h2>
		<p>모든 품목 정보를 조회합니다.</p>
	</div>
	<table>
		<thead>
			<tr>
				<th>품목코드</th>
				<th>품목 이미지</th>
				<th>품목명</th>
				<th>거래처 코드</th>
				<th>상호</th>
				<th>재고수량</th>
				<th>재고단가</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty items}">
				<tr>
					<td colspan="7">등록된 품목이 없습니다. 품목을 등록하세요.</td>
				</tr>
			</c:if>
			<c:forEach var="item" items="${items}">
				<tr>
					<td>${item_id}</td>
					<td>${file_name}</td>
 					<td><a href="/item_detail?code=${item_name}">${item_name}</td>
					<td>${item.partnerCode}</td>
					<td>${item.partnerName}</td>
					<td>${item.stock}</td>
					<td>${unit_price}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div id="search-box">
		<input type="text" name="item_name" placeholder="품목명 검색" value="${item_name}" />
		<input type="submit" value="조회" />
		<input type="reset" value="취소" />
	</div>
</form>
<script type="text/javascript">
	function /item_detail(f) {
		f.action="/item_detail";
		f.submit();
	}
</script>
</body>
</html>