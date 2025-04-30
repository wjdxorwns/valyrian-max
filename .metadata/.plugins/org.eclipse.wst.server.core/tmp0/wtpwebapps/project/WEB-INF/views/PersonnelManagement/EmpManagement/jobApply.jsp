<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!-- 작성자: 김재겸 -->
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>3부상조 _ 메인 페이지</title>
	<link rel="stylesheet" href="/resources/css/Main.css">
	<link rel="stylesheet" href="/resources/css/Header.css">
	<link rel="stylesheet" href="/resources/css/Footer.css">
	<link rel="stylesheet" href="/resources/css/KimJK/CSS_JobApply.css">
</head>
<body>

<jsp:include page="/resources/jsp/Header.jsp" />


	<div id="main_body">
		<h2>근무 방식 지정</h2>
		<h4>설명내용 _ 희망 근무지를 선택하세요</h4>

		<div class="working_form_container">
			<!-- 지도 영역 -->
			<div class="map_section">
				<p class="map_title">지도</p>
				<img src="/resources/images/map.png" alt="지도 이미지" class="map_image">
			</div>

			<!-- 근무지 선택 영역 -->
			<form method="post" action="/submit_location"
				class="work_location_form">
				<div class="location_container">
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

					<div class="address_container">
						<label for="detail_address"><strong>~ 각 지부 별 상세
								주소 ~</strong></label><br>
						<textarea id="detail_address" name="detail_home" rows="5"
							cols="30" class="detail_home"></textarea>
					</div>
				</div>

				<button type="submit" class="submit_button">신청</button>
			</form>
		</div>
	</div>
	
	<jsp:include page="/resources/jsp/Footer.jsp" />
	
</body>
</html>
