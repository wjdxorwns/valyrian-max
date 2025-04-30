<!-- 정택준 일반이 돈확인창  -->
<!-- 작성자: 정택준 | 기여자 : 김재겸 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.information {
	margin: 40px 200px
}

.emp_information {
	width: 1215px;
	overflow-x: auto;
}

.emp_table {
	min-width: 1500px
}
</style>
<meta charset="UTF-8">
<title>3부상조 - 메인 페이지</title>
<link href="<c:url value='/resources/css/Main.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/JeoungTJ/table.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/JeoungTJ/CSS_jungtakejun.css'/>"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

</head>

<body>

	<jsp:include page="/resources/jsp/Header.jsp" />
	<main>

		<div id="title">
			<h2>나의 급여 정보</h2>
			<p>내용설명 본인급여 조회(직원용)</p>
		</div>

		<div>
			<p class="information">
				직원 번호 <input type="text"
					style="background-color: lightgray; border-radius: 20px;"
					value="  d001" readonly> 입사일자 <input type="text"
					style="background-color: lightgray; border-radius: 20px;"
					value="  2025/01/25" readonly> 직원명 <input type="text"
					style="background-color: lightgray; border-radius: 20px;"
					value="  이소룡" readonly>
			</p>
		</div>
		<p>
			지급년월 <input type="text">
			<button style="size: 20px">조회</button>
		</p>
		<div class="emp_information">
			<table class="emp_table">
				<thead>
					<tr>
						<th>지급기준일</th>
						<th>지급차수</th>
						<th>부서</th>
						<th>직책</th>
						<th>급여형태</th>
						<th>호봉</th>
						<th>급여</th>
						<th>보너스</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>2</td>
						<td>3</td>
						<td>4</td>
						<td>5</td>
						<td>6</td>
						<td>6</td>
						<td>6</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="but">
			<button>다운로드</button>
			<button>취소</button>
		</div>
	</main>
	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

</body>
</html>