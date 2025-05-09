<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <!-- 작성자: 김재겸 -->
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>3부상조 _ 메인 페이지</title>
	<link rel="stylesheet" href="/resources/css/KimJK/CSS_job_apply.css">
	<link rel="stylesheet" href="/resources/css/Main.css">
	<link rel="stylesheet" href="/resources/css/Header.css">
	<link rel="stylesheet" href="/resources/css/Footer.css">
</head>
<body>

<jsp:include page="/resources/jsp/Header.jsp" />

<main>
	<h2>근무 방식 지정</h2>
	<h4>설명내용 _ 희망 근무지를 선택하세요</h4>

	<!-- 지도 + 선택 영역 통합 -->
	<div class="map_content">
		
		<!-- 지도 영역 -->
		<div class="map_section">
			<iframe id="map_data" 
				src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.803744693673!2d126.93840231521123!3d37.54999397980272!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357c989d7c7e8b8b%3A0x9f5c8e2b5d9e6f1!2z7ISc7Jq47Yq567OE7IucIOyCrOyaqeygnOq1rCDrsLDsmrXroZwzMe2DkywgM-yKpO2DhOybkA!5e0!3m2!1sko!2skr!4v1698771234567!5m2!1sko!2skr">
				</iframe>
		</div>

		<!-- 근무지 선택 영역 -->
		<form method="post" action="/submit_location" class="work_location_form">
			<div class="location_container">
				<div class="location_select_container">
					<label for="location_select"><strong>근무지 목록</strong></label><br>
					<select id="location_select" name="location" size="5" class="location_select">
						<option>경기도 연천지부</option>
						<option>전라남도 나주지부</option>
						<option>경상북도 경산지부</option>
						<option>강원도 속초지부</option>
					</select>
				</div>
				<div class="address_container">
					<label for="detail_address"><strong>~ 각 지부 별 상세 주소 ~</strong></label><br>
					<textarea id="detail_address" name="detail_home" rows="5" cols="30" class="detail_address"></textarea>
				</div>
			</div>
			<button type="submit" class="submit_button">신청</button>
		</form>

	</div>
</main>

	<jsp:include page="/resources/jsp/Footer.jsp" />
	
</body>
</html>
