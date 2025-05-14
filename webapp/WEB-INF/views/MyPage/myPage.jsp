<!-- 작성자 : 한찬욱 / 기여자 : 김용호 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- 서명 기능을 위해 SignaturePad 라이브러리를 CDN으로 추가 -->
<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.0/dist/signature_pad.umd.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 화면(CSS) 링크 -->

    <link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/KimYH/re.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/KimYH/PayUpdate.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/KimYH/media.css' />" rel="stylesheet">

    
    <!-- 폰트 링크 -->
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
	<!-- Font Awesome for social icons -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
   
<style>
.container_left{
margin-left: 200px;
}

table, th, td{
border: 1px solid black;
border-collapse: collapse;
}
th{
padding:0;
width:100px;
height:50px;
}
th img{
width:100%;
height:610%;
object-fit: cover;
display: block;
}

.buttons{
display:flex;
justify-content: center;
}
.buttons button{
margin:10px;
}

/* 모달 창 */
#update_detail {
display: none;
position: fixed;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
background-color: #fff;
border: 1px solid #ccc;
padding: 20px;
z-index: 1000;
width: 400px;
max-width: 90%;
border-radius: 8px;
}
/* 모달 오버레이 */
#modal_overlay {
display: none;
position: fixed;
top: 0;
left: 0;
width: 100%;
height: 100%;
background-color: rgba(0, 0, 0, 0.5);
z-index: 999;
}
.pwup{
justify-content: center;
margin-bottom: 10px;
}
.pwup input{
width:100%;
height:30px;
}
#signature_pad{
border: 1px solid black;
width:100%;
}


#passwordMessage {
margin-top: 5px; /* 입력 필드와 간격 */
text-align: center; /* 중앙 정렬 */
}
 
</style>
</head>
<body>

	<!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />
    

<main>
	<div class="container_left">
		<div class="text">
			<h2>내 정보 조회</h2>
			<p>본인의 개인 정보를 확인 및 수정합니다.</p>
		</div>
		<table>
			<tbody>
				<tr>
					<th colspan="2" rowspan="6">
						<c:if test="${not empty eVO}">
									<c:if test="${not empty eVO['f_name']}">
										<img src="${pageContext.request.contextPath}/resources/images/${eVO['f_name']}.jpg" alt="증명사진">
									</c:if>
									<c:if test="${empty eVO['f_name']}">
										<img src="${pageContext.request.contextPath}/resources/images/default_profile.jpg" alt="기본 프로필">
									</c:if>
								</c:if>
					</th>
					<th>이름</th><td><input type="text" class="box1" value="${eVO.emp_name}" readonly /></td>
				</tr>
				<tr>
					<th>이메일</th><td><input type="text" class="box1" value="${eVO.emp_email}" readonly /></td>
				</tr>
				<tr>
					<th>전화번호</th><td><input type="text" class="box1" value="${eVO.phone_number}" readonly /></td>
				</tr>
				<tr>
					<th>부서</th><td><input type="text" class="box1" value="${eVO.team}" readonly /></td>
				</tr>
				<tr>
					<th>직책</th><td><input type="text" class="box1" value="${eVO.position}" readonly /></td>
				</tr>
				<tr>
					<th>연차</th><td><input type="text" class="box1" value="${eVO.pay_grade}" readonly /></td>
				</tr>
				<tr>
					<th>입사일</th><td><input type="text" class="box2" value="${eVO.hire_date}" readonly /></td>
					<th>잔여 연차</th><td><input type="text" class="box2" value="${eVO.vacation_balance}" readonly /></td>
				</tr>
				<tr>
					<th>직원코드</th><td><input type="text" class="box2" value="${eVO.emp_idx}" readonly /></td>
					<th>성별</th><td><input type="text" class="box2" value="${eVO.gender}" readonly /></td>
				</tr>
				<tr>
					<th>주소</th><td><input type="text" class="box3" value="${eVO.home}" readonly /></td>
					<th>상세주소</th><td><input type="text" class="box3" value="${eVO.detail_home}" readonly /></td>
				</tr>
			</tbody>
		</table>
		<div class="buttons">
			<button onclick="openmodal()">수정하기</button>
			<button onclick="goToMain()">메인으로</button>
		</div>	
	</div>
	<!-- 모달 오버레이 -->
	<div id="modal_overlay"></div>
        
	<!-- 모달 창 -->
	<div id="update_detail">
		<form id="updateForm">
			<p>새로운 비밀번호</p>
			<div class="pwup">
				<input type="password" name="password" id="password" onkeyup="passwordCheck()" value="${users.emp_password }" placeholder="비밀번호를 입력하세요"/>
			</div>
			<p>비밀번호 확인</p>
			<div class="pwup">
				<input type="password" name="passwordchk" id="passwordchk" onkeyup="passwordCheck()" value="${users.emp_password }" placeholder="비밀번호를 확인하세요"/>
			</div>
			<div id="messageContainer"></div>
			<p>싸인을 입력하세요</p>
			<canvas id="signature_pad"></canvas>
			<div class="buttons">
				<button type="button" onclick="saveData()">저장</button>
				<button type="button" onclick="closemodal()">닫기</button>
			</div>
		</form>
	</div>
</main>
	<!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />

<script type="text/javascript">

	/* 모달 창 열기 */
	function openmodal() {
		document.getElementById('modal_overlay').style.display = 'block';
		document.getElementById('update_detail').style.display = 'block';
	}
	/* 모달 창 닫기 */
	function closemodal() {
		document.getElementById('modal_overlay').style.display = 'none';
		document.getElementById('update_detail').style.display = 'none';
		
		// 입력 필드 초기화
	    document.getElementById('password').value = '';
	    document.getElementById('passwordchk').value = '';
	    
		// 기존 비밀번호 확인 메시지 제거
	    let existingMessage = document.getElementById('passwordMessage');
	    if (existingMessage) existingMessage.remove();
	    // 서명 캔버스 초기화
	    signaturePad.clear();
	}
	/* 메인화면으로 */
	function goToMain() {
		window.location.href = "/index";
	}
	
	// 비밀번호 확인 함수
	function passwordCheck() {
		let password = document.getElementById('password').value;
		let passwordchk = document.getElementById('passwordchk').value;
		let message = document.createElement('p');
		message.id = 'passwordMessage';
        
     	// 기존 메시지 제거
		let existingMessage = document.getElementById('passwordMessage');
		if (existingMessage) existingMessage.remove();

		if (password && passwordchk) {
			if (password === passwordchk) {
				message.style.color = 'green';
				message.textContent = '비밀번호가 일치합니다.';
			} else {
				message.style.color = 'red';
				message.textContent = '비밀번호가 일치하지 않습니다.';
			}
			let passwordchkDiv = document.getElementById('passwordchk').parentNode;
	        passwordchkDiv.appendChild(message);
		}
	}
	
		// 서명 캔버스 초기화
		let canvas = document.getElementById('signature_pad');
		let signaturePad = new SignaturePad(canvas, {
			backgroundColor: 'rgb(255, 255, 255)' // 캔버스 배경 흰색
	});
	
	// 데이터 저장 및 전송
	function saveData() {
			let password = document.getElementById('password').value;
			let passwordchk = document.getElementById('passwordchk').value;

			// 비밀번호 유효성 검사
			if (!password || !passwordchk) {
			alert('비밀번호를 입력해주세요.');
				return;
			}
			if (password !== passwordchk) {
				alert('비밀번호가 일치하지 않습니다.');
				return;
			}

			// 서명 데이터 (base64 이미지)
			let signatureData = signaturePad.isEmpty() ? '' : signaturePad.toDataURL('image/png');

	        // AJAX로 데이터 전송
	        let xhr = new XMLHttpRequest();
	        xhr.open('POST', '/updateProfile', true); // 서버 엔드포인트 URL
	        xhr.setRequestHeader('Content-Type', 'application/json');

	        let data = JSON.stringify({
	            password: password,
	            signature: signatureData
	        });

	        xhr.onreadystatechange = function() {
	            if (xhr.readyState === 4) {
	                if (xhr.status === 200) {
	                    alert('정보가 성공적으로 업데이트되었습니다.');
	                    closemodal();
	                } else {
						let errorMessage = xhr.responseText;
	                    alert('업데이트 실패: ' + errorMessage);
	                }
	            }
	        };
	        xhr.send(data);
	    }

	    // 오버레이 클릭 시 모달 닫기
	    document.getElementById('modal_overlay').addEventListener('click', function(e) {
	        if (e.target === this) {
	            closemodal();
	        }
	    });
	
</script>

</body>
</html>
