<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 작성자: 한찬욱 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 정보(MyPage) - 비밀 번호, 사인 수정</title>

	<!-- 화면(CSS) 링크 -->
    <link href="<c:url value='/resources/css/HanCW/CSS_mypageupdate.css' />" rel="stylesheet">
	<link href="<c:url value='/resources/css/index.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Aside.css' />" rel="stylesheet">
    
    <!-- 폰트 링크 -->
	<link
		href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
		rel="stylesheet">
	<!-- Font Awesome for social icons -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style type="text/css">
	#signature_pad{
		border: 1px solid #000;
		background-color: white;
		}
</style>

</head>
<body>
	<!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />
    
    <jsp:include page="/resources/jsp/PayAside.jsp" /> 
	
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
	<main>	<!-- 사진, 이메일, 직원 이름, 집주소, 상세 집주소, 휴대전화번호, 부서명, 직책, 호봉, 입사일, 직원 고유코드, 휴가일  -->
	
		<div class="container">	
			<div class="allcontainer">
		 	<h2>내 정보 조회</h2>
			<h4>본인의 개인 정보를 확인 및 수정합니다.</h4>
			  	<!-- 전체 테이블 -->
			  		<div style="display: flex; align-items: flex-start; text-align: center;">
						<jsp:include page="myPageLeft.jsp" />
						
						<div class="container_right">
							<form action="/updatePassword" method="post">
							    <div>비밀번호 변경</div>
							    <div>
							      <input type="password" name="password" id="password" style="width: 200px; height: 30px;" onkeyup="passwordCheck()" value="${users.emp_password }" placeholder="비밀번호를 입력하세요"/>
							    </div>			
							    
							    <div>비밀번호 확인</div>
							    <div>
							    	<input type="password" name="passwordchk" id="passwordchk" style="width: 200px; height: 30px;" onkeyup="passwordCheck()" value="${users.emp_password }" placeholder="비밀번호를 확인하세요"/>
							    </div>		
							    <br><br><br>
							    <!-- 결과 메시지 -->
							    <div id="passMessage" style="color: red;"></div>
							
							    <!-- 서버에 전송할 실제 비밀번호 -->
							    <input type="hidden" id="passwordOk" name="emp_password"/>		
							
							    <!-- 싸인 데이터 전송을 위한 hidden input -->
							    <input type="hidden" id="signatureData" name="signatureData" />
							
							    <!-- 사인 입력 -->
							    <div>사인을 입력하세요</div>
							    <canvas id="signature_pad" width="300" height="100"></canvas>
							    <br>
							    <div>
							    	<button type="button" onclick="clearCanvas()">싸인 지우기</button>
							    </div>
								<br><br>
							    <div class="cols" >
							    	<input type="button" id="button" value="저장하기" onclick="myPageUpdate(this.form)">
							    	<input type="button" id="button" value="돌아가기" onclick="returnMyPage()">
							    </div>
							</form>		
						</div>
			  		</div>
			</div>		 
		</div>
	</main>						
				
						  	
	
		
	<!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />
</body>
	
		<script type="text/javascript">
		    // Canvas 초기화
			    var canvas = document.getElementById('signature_pad');
			    var ctx = canvas.getContext('2d');
			    var isDrawing = false;
			    var lastX = 0;
			    var lastY = 0;
				
			// 마우스 이벤트 리스너
			    canvas.addEventListener('mousedown', startDrawing);
			    canvas.addEventListener('mousemove', draw);
			    canvas.addEventListener('mouseup', stopDrawing);
			    canvas.addEventListener('mouseout', stopDrawing);
					
			// 터치 이벤트 리스너
			    canvas.addEventListener('touchstart', handleTouch);
			    canvas.addEventListener('touchmove', handleTouch);
			    canvas.addEventListener('touchend', stopDrawing);
				
		    function startDrawing(e) {
		        isDrawing = true;
		        [lastX, lastY] = getCoordinates(e);
			    }
	
		    function draw(e) {
		        if (!isDrawing) return;
		        
		        ctx.beginPath();
		        ctx.moveTo(lastX, lastY);
		        [lastX, lastY] = getCoordinates(e);
		        ctx.lineTo(lastX, lastY);
		        ctx.strokeStyle = '#000';
		        ctx.lineWidth = 2;
		        ctx.lineCap = 'round';
		        ctx.stroke();
			    }
	
		    function stopDrawing() {
		        isDrawing = false;
			    }
	
		    function handleTouch(e) {
		        e.preventDefault();
			        if (e.type === 'touchstart') {
			            startDrawing(e);
			        } else if (e.type === 'touchmove') {
			            draw(e);
			        }
			    }
	
		    function getCoordinates(e) {
		        let x, y;
			        if (e.type.includes('touch')) {
			            const rect = canvas.getBoundingClientRect();
			            x = e.touches[0].clientX - rect.left;
			            y = e.touches[0].clientY - rect.top;
			        } else {
			            x = e.offsetX;
			            y = e.offsetY;
			        }
			        return [x, y];
			    }
	
		    function clearCanvas() {
		        ctx.clearRect(0, 0, canvas.width, canvas.height);
		   		}
	
		    function passwordCheck() {
		        var password = $("#password").val();
		        var passwordchk = $("#passwordchk").val();
			        if (password !== passwordchk) {
			            $("#passMessage").html("비밀번호가 서로 일치하지 않습니다.");
			        } else {
			            $("#passMessage").html("");
			            $("#passwordOk").val(password);
			        }
			    }
		
		    function myPageUpdate(f) {
		        var password = $("#password").val();
		        var passwordchk = $("#passwordchk").val();
	
		        if (!password || !passwordchk) {
		            alert("비밀번호를 입력해주세요.");
		            return;
		        }
	
		        if (password !== passwordchk) {
		            alert("비밀번호가 일치하지 않습니다.");
		            return;
		        }
	
		        // 싸인 데이터를 Base64로 변환하여 hidden 필드에 저장
		        var signatureData = canvas.toDataURL();
		        	document.getElementById("signatureData").value = signatureData;
	
		        // 전송
		        	f.submit();
		   		}
	
		    function returnMyPage() {
				window.location.href = "/MyPage/myPage";
			}
		</script>		
		
</html>



