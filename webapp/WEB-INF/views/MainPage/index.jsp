<!-- 최성현 수정자: 정택준  -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 비즈니스 플랫폼</title>
<!-- 폰트 로드 -->
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<!-- Font Awesome for social icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- CSS 파일 링크 -->
<link href="<c:url value='/resources/css/Header.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/index.css' />" rel="stylesheet">

</head>
<body>
	<div class="wrap">
		<!-- Header -->
		<jsp:include page="/resources/jsp/Header.jsp" />

		<!-- Content -->
		<div class="content">
			<!-- Visual Section -->
			<div class="visual">
				<div class="container">
					<div class="txt-box">
						<h2 class="txt-main">
							3부상조<span class="strong">비즈니스 플랫폼</span>
						</h2>
						<p class="txt-sub">
							혁신적인 솔루션으로<br>당신의 비즈니스를 성장시키세요.
						</p>
					</div>
				</div>
			</div>

			<!-- Shortcut Section -->
			<div class="shortcut">
				<div class="container">
					<ul class="shortcut-list clearfix">

						<li class="shortcut-list-item"><a href="calendar">
								<h3 class="txt-main">켈린더</h3>
								<p class="txt-sub">
									3부상조 플랫폼 켈린더를 활용하기 위해<br> 계정을 등록하고 서비스를 경험하세요.
								</p>
								<p class="img-box">
									<span class="screen-hidden"></span>
								</p>
						</a></li>
						<li class="shortcut-list-item"><a href="attendance">
								<h3 class="txt-main">출, 퇴근 관리</h3>
								<p class="txt-sub">
									출근과 퇴근 시간을<br> 실시간으로 보고 편하게 등록하세요.
								</p>
								<p class="img-box">
									<span class="screen-hidden"></span>
								</p>
						</a></li>
						<li class="shortcut-list-item"><a href="electronicpayment">
								<h3 class="txt-main">전자 결제</h3>
								<p class="txt-sub">
									손쉽고 간편하게<br> 승인 요청을 넣어보세요.
								</p>
								<p class="img-box">
									<span class="screen-hidden"></span>
								</p>
						</a></li>
						<li class="shortcut-list-item"><a href="notice">
								<h3 class="txt-main">공지사항</h3>
								<p class="txt-sub">
									건의사항이나<br> 올리고싶은 파일을 올려보세요
								</p>
								<p class="img-box">
									<span class="screen-hidden"></span>
								</p>
						</a></li>
					</ul>
				</div>
			</div>

			<!-- Recent Posts Section -->
			<div class="article recent-posts">
				<div class="container clearfix">
					<div class="txt-box">
						<span class="txt-sub2">최근 소식</span>
						<h3 class="txt-main">공지사항 업데이트</h3>
						<p class="txt-sub">3부상조 게시판의 최신 글을 확인하세요.</p>
						<span class="txt-sub3">최신 업데이트: 2025/04/24 00:00</span>
					</div>
					<div class="graphic-box clearfix">
						<ul class="post-list">
							<li class="post-item"><a href="noticeone">
									<h4 class="post-title">2025년 상반기 워크숍 안내</h4>
									<p class="post-meta">
										<span>작성자: 김관리</span> <span>작성일: 2025/04/23</span>
									</p>
							</a></li>
							<li class="post-item"><a href="noticetwo">
									<h4 class="post-title">급여 관리 시스템 업데이트 공지</h4>
									<p class="post-meta">
										<span>작성자: 박인사</span> <span>작성일: 2025/04/22</span>
									</p>
							</a></li>
							<li class="post-item"><a href="noticethree">
									<h4 class="post-title">휴가 신청 프로세스 변경 안내</h4>
									<p class="post-meta">
										<span>작성자: 이인사</span> <span>작성일: 2025/04/20</span>
									</p>
							</a></li>
						</ul>
					</div>
				</div>
			</div>

			<!-- Info Step Section -->
			<div class="article info-step">
				<div class="container clearfix">
					<div class="txt-box">
						<span class="txt-sub2">3부상조</span>
						<h3 class="txt-main">이용 절차</h3>
						<p class="txt-sub">
							간단한 절차로<br> 3부상조의 모든 서비스를<br> 이용할 수 있습니다.
						</p>
					</div>
					<div class="graphic-box clearfix">
						<div class="div-step">
							<p class="step-txt">
								STEP<span class="step-num">01</span>
							</p>
							<p class="step-icon">
								<img src="resources/image/icons8-로그인-50.png" alt="">
							</p>
							<p class="step-txt-sub">
								3부상조 플랫폼에 로그인 및<br> 계정 등록
							</p>
						</div>
						<div class="div-step">
							<p class="step-txt">
								STEP<span class="step-num">02</span>
							</p>
							<p class="step-icon">
								<img src="resources/image/icons8-서비스-50.png" alt="">
							</p>
							<p class="step-txt-sub">
								서비스 테스트 및<br> 기능 확인
							</p>
						</div>
						<div class="div-step">
							<p class="step-txt">
								STEP<span class="step-num">03</span>
							</p>
							<p class="step-icon">
								<img src="resources/image/icons8-문서-서명-50.png" alt="">
							</p>
							<p class="step-txt-sub">
								3부상조 서비스<br> 약정 체결
							</p>
						</div>
						<div class="div-step">
							<p class="step-txt">
								STEP<span class="step-num">04</span>
							</p>
							<p class="step-icon">
								<img src="resources/image/icons8-적용-스킨-타입-7-48.png" alt="">
							</p>
							<p class="step-txt-sub">
								운영 환경 적용 및<br> 서비스 시작
							</p>
						</div>
					</div>
				</div>
			</div>

			<!-- Company Info Section -->
			<div class="article company-info">
				<div class="container clearfix">
					<div class="txt-box">
						<span class="txt-sub2">회사 정보</span>
						<h3 class="txt-main">3부상조를 찾아오세요</h3>
						<p class="txt-sub">당신의 비즈니스 파트너, 3부상조의 위치를 확인하세요.</p>
					</div>
					<div class="graphic-box clearfix">
						<div class="info-details">
							<p>
								<strong>회사명:</strong> 3부상조 주식회사
							</p>
							<p>
								<strong>주소:</strong> 서울특별시 마포구 백범로 23, 3층 (신수동, 케이터틀)
							</p>
							<p>
								<strong>전화번호:</strong> 02-1234-5678
							</p>
							<p>
								<strong>이메일:</strong> contact@3busangjo.com
							</p>
						</div>
						<div class="map-container">
							<iframe
								src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.803744693673!2d126.93840231521123!3d37.54999397980272!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357c989d7c7e8b8b%3A0x9f5c8e2b5d9e6f1!2z7ISc7Jq47Yq567OE7IucIOyCrOyaqeygnOq1rCDrsLDsmrXroZwzMe2DkywgM-yKpO2DhOybkA!5e0!3m2!1sko!2skr!4v1698771234567!5m2!1sko!2skr"></iframe>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Footer -->
		<jsp:include page="/resources/jsp/Footer.jsp" />
	</div>
</body>
</html>