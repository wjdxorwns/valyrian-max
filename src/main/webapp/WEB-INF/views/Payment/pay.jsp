<!-- 정택준 일반이 돈확인창  -->
<!-- 작성자: 정택준 | 기여자 : 김재겸 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 메인 페이지</title>
<link href="<c:url value='/resources/css/JeoungTJ/CSS_table.css'/>"
	rel="stylesheet">
<link
	href="<c:url value='/resources/css/JeoungTJ/CSS_jungtakejun.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/JeoungTJ/Main.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css'/>" rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">



</head>

<body>

	<jsp:include page="/resources/jsp/Header.jsp" />


	<main style="margin: 80px auto auto;">
		<jsp:include page="/resources/jsp/PayAside.jsp" />

		<div class="main-item">
			<div id="title">
				<h2>나의 급여 정보</h2>
				<p>내용설명 본인급여 조회(직원용)</p>
			</div>
			<p>
				지급년월 <input type="date" id="paymentYearMonth">
				<button id="serch" onclick="searchPayroll()">조회</button>
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
					<tbody id="payrollTableBody">
						<!-- 동적으로 데이터 추가 -->
					</tbody>
				</table>
			</div>

			<div id="but">
				<button onclick="downloadExcel()">다운로드</button>
				<button onclick="cancel()">취소</button>
			</div>
		</div>

	</main>
	<jsp:include page="/resources/jsp/Footer.jsp" />

	<script type="text/javascript">
		function searchPayroll() {
			// 조회 버튼 클릭 시 테이블 데이터 갱신 (AJAX로 구현 가능)
			alert("조회 기능은 구현 중입니다.");

		}

		function downloadExcel() {
			const userIdx = "${sessionScope.user_idx}";
			if (!userIdx) {
				alert("로그인이 필요합니다.");
				window.location.href = "<c:url value='/login' />";
				return;
			}
			// 엑셀 다운로드 요청
			window.location.href = "<c:url value='/downloadExcel' />?user_idx="
					+ userIdx;
		}

		function cancel() {
			// 취소 버튼: 이전 페이지로 이동 또는 폼 초기화
			window.history.back();
		}
	</script>
</body>
</html>