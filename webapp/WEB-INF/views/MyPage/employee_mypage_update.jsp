<!-- 작성자: 한찬욱 | 기여자: 김재겸-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 직원 정보 수정하기</title>

	<!-- 화면(CSS) 링크 -->
	<link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/HanCW/CSS_employee_mypage_update.css' />" rel="stylesheet">
    
    <!-- 폰트 링크 -->
	<link
		href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
		rel="stylesheet">
	<!-- Font Awesome for social icons -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
	    <button id="mobile-menu-btn">
	      <span></span>
	      <span></span>
	      <span></span>
	    </button>
	  </header>
	
	  <!-- Mobile Menu -->
	  <aside id="mobile-menu">
	    <nav>
	      <ul class="nav-items">
	        <li><a href="/">직원등록</a></li>
	        <li><a href="/">근무지정</a></li>
	        <li><a href="/">인사</a></li>
	        <li><a href="/">급여</a></li>
	        <li><a href="/">휴가</a></li>
	      </ul>
	    </nav>
	  </aside>
	
	  <!-- Sidebar for Desktop -->
	  <aside id="sidebar">
	    <nav>
	      <ul>
	        <li><a href="/">직원등록</a></li>
	        <li><a href="/">근무지정</a></li>
	        <li><a href="/">인사</a></li>
	        <li><a href="/">급여</a></li>
	        <li><a href="/">휴가</a></li>
	      </ul>
	    </nav>
	  </aside>
	<main>
		<!-- 사진, 이메일, 직원 이름, 집주소, 상세 집주소, 휴대전화번호, 부서명, 직책, 호봉, 입사일, 직원 고유코드, 휴가일  -->
		<!-- Header -->
		<jsp:include page="/resources/jsp/Header.jsp" />
		<h2>내 정보 수정하기</h2>
		<h4>본인의 개인 정보를 확인 및 수정합니다.</h4>
		<hr>
		<!-- 개인정보 테이블 -->
		<div class="container">
			<div class="container1">
				<!-- 사진과 옆내용 -->
				<div class="infor_table">
					<!-- 사진 -->
					<div class="profile_image">
						<img src='<c:url value="/resources/images/brucelee.jpg" />'>
					</div>
					<!-- 직원이름, 이메일, 휴대전화번호, 부서명, 직책, 호봉 -->
					<div>
	
						<div class="set">
							<div class="info_title">이름</div>
							<div>
								<input type="text" class="box1" value="${user.emp_name }" />
							</div>
						</div>
	
						<div class="set">
							<div class="info_title">이메일</div>
							<div>
								<input type="text" class="box1" value="${user.emp_email }" />
							</div>
						</div>
	
						<div class="set">
							<div class="info_title">전화번호</div>
							<div>
								<input type="text" class="box1" value="${user.phone_number }" />
							</div>
						</div>
	
						<div class="set">
							<div class="info_title">부서명</div>
							<div>
								<input type="text" class="box1" value="${employee.dept_name }" />
							</div>
						</div>
	
						<div class="set">
							<div class="info_title">직책</div>
							<div>
								<input type="text" class="box1" value="${employee.position }" />
							</div>
						</div>

					<div class="set">
						<div class="info_title">호봉</div>
						<div>
							<input type="text" class="box1" value="${employee.pay_grade }" />
						</div>
					</div>

				</div>
			</div>
			<!-- 사진 아랫내용 -->
			<div class="under_table">
				<div class="und_table">
					<div class="set">

						<div class="info_title">입사일</div>
						<div>
							<input type="text" class="box2" value="${user.home }" />
						</div>
					</div>
					<div class="set">
						<div class="info_title">휴가일</div>
						<div>
							<input type="text" class="box2" value="${user.home }" />
						</div>
					</div>

				</div>
				<div class="und_table">
					<div class="set">
						<div class="info_title">직원코드</div>
						<div>
							<input type="text" class="box2" value="${user.emp_code }" />
						</div>
					</div>
					<div class="set">
						<div class="info_title">급여</div>
						<div>
							<input type="text" class="box2" value="${user.pay }" />
						</div>
					</div>			
				</div>
				<div class="set">
					<div class="info_title">주소</div>
					<div>
						<input type="text" class="box3" value="${user.home }" />
					</div>
				</div>

				<div class="set">
					<div class="info_title">상세주소</div>
					<div>
						<input type="text" class="box3" value="${user.detail_home }" />
					</div>
				</div>
			</div>

		</div>
		<div class="container2">
			<div class="">비밀번호 변경</div>
				<div>
					<input type="password" class="box4" value="${users.emp_password }" />
				</div>			
			<div class="">비밀번호 확인</div>
				<div>
					<input type="password" class="box4" value="${users.emp_password }" />
				</div>			
			<!-- 사인 저장을 위한 canvas -->
			<div>사인을 입력하세요</div>
			<canvas class="signature_pad" width="400px"></canvas>
			<br><br>
				
				<button onclick="clearCanvas()">싸인 지우기</button>
				<script>
			        const canvas = document.querySelector('.signature_pad');
			        const ctx = canvas.getContext('2d');
			     	   let drawing = false;
			
				        canvas.addEventListener('mousedown', (e) => {
				            drawing = true;
				            ctx.beginPath();
				            ctx.moveTo(e.offsetX, e.offsetY);
				        });
			
			        canvas.addEventListener('mousemove', (e) => {
			            if (drawing) {
			                ctx.lineTo(e.offsetX, e.offsetY);
			                ctx.stroke();
			            }
			        });
			
			        canvas.addEventListener('mouseup', () => {
			            drawing = false;
			        });
			
			        canvas.addEventListener('mouseout', () => {
			            drawing = false;
			        });
		
		       		function clearCanvas() {
		            ctx.clearRect(0, 0, canvas.width, canvas.height);
		     		 }
	   			</script>
			<br><br><br><br>
				<div class="cols">
					<input type="button" class="button" value="저장하기"
						onclick="board_update(this.form)"> 
					<input type="button" class="button" value="돌아가기" 
						onclick="board_return_ok(this.form)">
				</div>
			</div>
		</div>
	</main>
	<script type="text/javascript">
		function board_update(f) {
					
			f.action="/board_write";
			f.submit();
		}
		function board_list_go(f) {
					
			f.actiom="/main";
			f.submit();
		}
	</script>

	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />
</body>
</html>



