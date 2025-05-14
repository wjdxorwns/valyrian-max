<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>3부상조 - 메인 페이지</title>
	<link rel="stylesheet" type="text/css" href="../css/CSS.css">
	<link rel="stylesheet" type="text/css" href="../css/CSS_working_ways.css">
</head>
<body>

<header id="main-header">
    <div id="logo"><a href="/">3부상조</a></div>
    <nav>
        <ul class="nav-items">
            <li><a href="/">직원 정보 조회(H)</a></li>
            <li><a href="/cart">근무 지정</a></li>
            <li><a href="/orders">인사 관리</a></li>
            <li><a href="/signup">급여</a></li>
            <li><a href="/login">휴가</a></li>
        </ul>
    </nav>
</header>

<aside id="sidebar">
    <nav>
        <ul>
            <li><a href="/">직원 정보 조회(L)</a></li>
            <li><a href="/cart">근무 지정</a></li>
            <li><a href="/orders">인사 관리</a></li>
            <li><a href="/signup">급여</a></li>
            <li><a href="/login">휴가</a></li>
        </ul>
    </nav>
</aside>

	<div id="main-body">
		<h2>근무 방식 지정</h2>
		<h4>설명내용 - 희망 근무지를 선택하세요</h4>

		<div class="working-form-container">
			<!-- 지도 영역 -->
			<div class="map-section">
				<p class="map-title">지도</p>
				<img src="/resources/images/map.png" alt="지도 이미지" class="map-image">
			</div>

			<!-- 근무지 선택 영역 -->
			<form method="post" action="/submit-location"
				class="work-location-form">
				<div class="location-container">
					<div class="location-select-container">
						<label for="location-select"><strong>근무지 목록</strong></label><br>
						<select id="location-select" name="location" size="5"
							class="location-select">
							<option>경기도 연천지부</option>
							<option>전라남도 나주지부</option>
							<option>경상북도 경산지부</option>
							<option>강원도 속초지부</option>
						</select>
					</div>

					<div class="address-container">
						<label for="detail-address"><strong>~ 각 지부 별 상세
								주소 ~</strong></label><br>
						<textarea id="detail-address" name="detail-address" rows="5"
							cols="30" class="detail-address"></textarea>
					</div>
				</div>

				<button type="submit" class="submit-button">신청</button>
			</form>
		</div>
	</div>

</body>
</html>