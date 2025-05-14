<!-- 작성자: 김기섭 | 기여자: 김재겸, 김용호 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="3부상조 - 보직 발령(관리자)">
<title>3부상조 - 보직 발령(관리자)</title>

<link href="<c:url value='/resources/css/KimYH/personnel.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/KimYH/re.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">

<!-- Font Awesome for social icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">

</head>
<body>
	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />
	<!-- Aside -->
	<jsp:include page="/resources/jsp/EmpDataAside.jsp" />
	<main>
		<!-- Main Content -->
		<section class="employee-section">
			<h2>보직 발령 조회 및 등록</h2>
			<div class="search-bar">
				<label>발령구분</label> <select>
					<option>전체</option>
					<option>사내</option>
					<option>전출</option>
				</select> <label>발령일자</label> <input type="date" value=""> <span>~</span>
				<input type="date" value="">
				<div id="button">
					<button type="submit">조회</button>
				</div>
			</div>
			<div class="top-bar">
				<span style="font-weight: bold; color: #000;">발령 직원조회</span>
				<button id="openPopupBtn" class="register-btn">발령등록</button>
			</div>
			<!-- 발령등록 버튼 -->
			<div class="table-area">
				<table>
					<thead>
						<tr>
							<th>직원번호</th>
							<th>직원이름</th>
							<th>직책</th>
							<th>년차</th>
							<th>발령 유형</th>
							<th>이전 부서명</th>
							<th>변경 후 부서명</th>
							<th>이전 근무지</th>
							<th>변경 후 근무지</th>
							<th>발령일</th>
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


			<!-- 팝업 오버레이 -->
			<div id="registerFormContainer">
				<!-- 팝업 내용: 여기에 발령등록 폼 등 원하는 내용을 넣으세요 -->
				<!-- 예시 입력 폼 -->
				<div class="detail-section">
					<div class="text">
					<h3>발령등록</h3>
					<h3>세부 내용</h3>
					</div>
					<div class="detail-row">
						<label>직원번호:</label> <input type="text" name="emp_id" readonly />
					</div>
					<div class="detail-row">
						<label>직원 이름:</label> <input type="text" name="emp_name" readonly />
					</div>
					<div class="detail-row">
						<label>직책:</label> <input type="text" name="position" readonly />
					</div>
					<div class="detail-row">
						<label>년차:</label> <input type="number" name="pay_grade" readonly />
					</div>
					<div class="detail-row">
						<label>발령 유형:</label> 
						<select name="change_type">
							<option selected>사내</option>
							<option>전출</option>
						</select>
					</div>
					<div class="detail-row">
						<label>이전 부서명:</label> <input type="text" name="prev_dept_id" />
					</div>
					<div class="detail-row">
						<label>변경 후 부서명:</label> <input type="text" name="new_dept_id" />
					</div>
					<div class="detail-row">
						<label>이전 근무지:</label> <input type="text" name="prev_location_id" />
					</div>
					<div class="detail-row">
						<label>변경 후 근무지:</label> <input type="text" name="new_location_id" />
					</div>
					<div class="detail-row">
						<label>발령일:</label> <input type="date" name="change_date" />
					</div>
				</div>

				<!-- 지도 + 선택 영역 통합 -->
				<div class="map_content">
					<!-- 지도 영역 -->
					<div class="map_section">
						<iframe id="map_data"
							src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.803744693673!2d126.93840231521123!3d37.54999397980272!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357c989d7c7e8b8b%3A0x9f5c8e2b5d9e6f1!2z7ISc7Jq47Yq567OE7IucIOyCrOyaqeygnOq1rCDrsLDsmrXroZwzMe2DkywgM-yKpO2DhOybkA!5e0!3m2!1sko!2skr!4v1698771234567!5m2!1sko!2skr">
						</iframe>
					</div>
					<!-- 근무지 선택 영역 -->
					<form method="post" action="/submit_location"
						class="work_location_form">
						<div class="location_select_container">
							<label for="location_select"><strong>근무지 목록</strong></label><br>
							<select id="location_select" name="location" size="5"
								class="location_select">
								<option>경기도 연천지부</option>
								<option>전라남도 나주지부</option>
								<option>경상북도 경산지부</option>
								<option>강원도 속초지부</option>
							</select>
						</div>
					</form>
				</div>
			</div>

			<!-- Action Buttons -->
			<div class="update-btn">
				<button>확인</button>
				<button>취소</button>
			</div>
		</section>
	</main>
	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

	<script type="text/javascript">
document.getElementById('openPopupBtn').addEventListener('click', function() {
  var container = document.getElementById('registerFormContainer');
  if (container.style.display === 'block') {
    // 이미 열려있으면 닫기
    container.style.display = 'none';
    container.innerHTML = '';
    return;
  }

  // AJAX로 폼을 불러오는 것처럼 예시 (실제로는 서버에서 받아오거나, 아래처럼 직접 작성)
  // fetch('/register-form.html').then(res => res.text()).then(html => { container.innerHTML = html; ... });
  container.innerHTML = `
    <form id="registerForm">
      <div>
        <label>발령구분</label>
        <select name="type" required>
          <option value="">선택</option>
          <option value="부서이동">부서이동</option>
          <option value="승진">승진</option>
        </select>
      </div>
      <div>
        <label>발령일자</label>
        <input type="date" name="date" required>
      </div>
      <div>
        <label>사원번호</label>
        <input type="text" name="empno" required>
      </div>
      <div>
        <label>성명</label>
        <input type="text" name="name" required>
      </div>
      <div>
        <label>발령내용</label>
        <input type="text" name="content" required>
      </div>
      <button type="submit">등록</button>
    </form>
  `;
  container.style.display = 'block';

  // 폼 제출 시 AJAX로 처리 (예시)
  document.getElementById('registerForm').addEventListener('submit', function(e) {
    e.preventDefault();
    // 실제로는 아래 부분에서 fetch 또는 $.ajax 등으로 서버에 데이터 전송
    alert('등록되었습니다!');
    container.style.display = 'none';
    container.innerHTML = '';
  });
});
</script>
</body>
</html>