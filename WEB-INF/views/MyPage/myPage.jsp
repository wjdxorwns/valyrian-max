<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 작성자: 한찬욱 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 정보(MyPage)</title>

	<!-- 화면(CSS) 링크 -->
    <link href="<c:url value='/resources/css/HanCW/CSS_mypage.css' />" rel="stylesheet">
	<link href="<c:url value='/resources/css/Main.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
    
    
    <!-- 폰트 링크 -->
	<link
		href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
		rel="stylesheet">
	<!-- Font Awesome for social icons -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style type="text/css">
.btn {
  display: inline-block;
  padding: 6px 12px;
  background-color: skyblue; 
  color: white;
  text-decoration: none;
  border: none;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
}

.btn:hover {
  background-color: #45a049;
}

img{
	width: 299px;
	height: 300px;
	}

</style>


</head>
<body>
	<!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />
    
    <jsp:include page="/resources/jsp/PayAside.jsp" /> 
	

	<main>	<!-- 사진, 이메일, 직원 이름, 집주소, 상세 집주소, 휴대전화번호, 부서명, 직책, 호봉, 입사일, 직원 고유코드, 휴가일  -->

		<div class="container" style="margin-top: 120px;" >
			 <div class="main_body">
		  <h2>내 정보 조회</h2>
			  <h4>본인의 개인 정보를 확인 및 수정합니다.</h4>
			  	<!-- 전체 테이블 -->
					<div class="container_left">
						<!-- 사진과 옆내용 -->
						<div class="infor_table">
							<!-- 사진 -->				
							<div class="profile_image">
								<c:if test="${not empty eVO}">
									<c:if test="${not empty eVO['f_name']}">
										<img src="${pageContext.request.contextPath}/resources/images/${eVO['f_name']}.jpg" alt="증명사진">
									</c:if>
									<c:if test="${empty eVO['f_name']}">
										<img src="${pageContext.request.contextPath}/resources/images/default_profile.jpg" alt="기본 프로필">
									</c:if>
								</c:if>
							</div>
							<!-- 직원이름, 이메일, 휴대전화번호, 부서명, 직책, 호봉 -->
							<div>
								<div class="set">
									<div class="info_title">이름</div>
									<div>
										<input type="text" class="box1" value="${eVO['emp_name']}" readonly />
									</div>
								</div>
								
								<div class="set">
									<div class="info_title">이메일</div>
									<div>
										<input type="text" class="box1" value="${eVO['emp_email']}" readonly />
									</div>
								</div>
								
								<div class="set">		
									<div class="info_title">전화번호</div>
									<div><input type="text" class="box1" value="${eVO['phone_number']}" readonly /></div>
								</div>

								<div class="set">		
									<div class="info_title">부서명</div>
									<div><input type="text" class="box1" value="${eVO['team']}" readonly /></div>
								</div>							

								<div class="set">		
									<div class="info_title">직책</div>
									<div><input type="text" class="box1" value="${eVO['position']}" readonly /></div>
								</div>							

								<div class="set">		
									<div class="info_title">호봉</div>
									<div><input type="text" class="box1" value="${eVO['pay_grade']}" readonly /></div>
								</div>
							</div>					
						</div>
						<!-- 사진 아랫내용 -->
						<div>
							<div class="und_table">
								<div class="set">
									<div class="info_title">입사일</div>
									<div><input type="text" class="box2" value="${eVO['hire_date']}" readonly /></div>
								</div>
								<div class="set">
									<div class="info_title">잔여 연차</div>
									<div><input type="text" class="box2" value="${eVO['vacation_balance']}" readonly /></div>
								</div>
							</div>
							<div>
								<div class="und_table">
									<div class="set">
										<div class="info_title">직원코드</div>
										<div>
											<input type="text" class="box2" value="${eVO['emp_idx']}" readonly />
										</div>
									</div>
									<div class="set">
										<div class="info_title">성별</div>
										<div>
											<input type="text" class="box2" value="${eVO['gender']}" readonly />
										</div>
									</div>			
								</div>
								<div class="set">
									<div class="info_title">주소</div>
									<div><input type="text" class="box3" value="${eVO['home']}" readonly /></div>
								</div>
								<div class="set">		
									<div class="info_title">상세주소</div>
									<div>
										<input type="text" class="box3" value="${eVO['detail_home']}" readonly />
									</div>
								</div>		
							</div>	
						</div>
					</div>
					<div class="buttons">
						<div>
							<a href="/myPageUp" class="btn" >수정하러가기</a>    
						</div>
						<div>
					        <a href="/index" class="btn" >메인으로가기</a>
						</div>
					</div>					
			 </div>
		</div>	  		  	
	</main>
		
	<!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />
	</body>
</html>



