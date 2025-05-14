<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<!-- 작성자: 정택준 | 기여자: 김재겸 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

aside {
    position: absolute;
    top: 80px;
    left: 0;
    width: 250px;
    background-color: #ffffff;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    z-index: 9997; 
    height: -webkit-fill-available;
    
}

aside .aside-item {
    padding: 20px;
}

aside .aside-item h2 {
    font-size: 20px;
    font-weight: 400;
    color: #003399;
    margin-bottom: 15px;
}

aside .aside-item ul {
    list-style: none;
}

aside .aside-item ul li {
    margin-bottom: 10px;
}

aside .aside-item ul li a {
    text-decoration: none;
    color: #333;
    font-size: 16px;
    font-weight: 300;
    display: block;
    padding: 5px 0;
    transition: color 0.3s ease;
}

aside .aside-item ul li a:hover {
    color: #3498db;
}


</style>
</head>



<body>
<aside  id="scrollable-aside">
	<div class= "aside-item">
        <h2>마이페이지</h2>
        <ul>
            <li><a href="/payrollList">내 프로필</a></li>
            <li><a href="/payrollGrade">문의사항</a></li>
        </ul>
     	<h2>인사관리</h2>
        <c:choose>
       	  <c:when test='${sessionScope.permissionvo.can_access_employee eq 1 or sessionScope.employeeVO.dept_name eq "슈퍼관리자"}'>
       		<ul>
            	<li><a href="/personnelChange">근무지 정보 관리</a></li>
				<li><a href="/empDataList">직원 현황 관리</a></li>
				<li><a href="/hrManagement">퇴직자 정보 관리</a></li>
				<li><a href="/PersonnelManagement/EmpManagement/empDataRegister">신규 직원 등록</a></li>
        	</ul>
       	  </c:when>
       	  <c:otherwise>
       	  	<ul>
       	  		<li><a href="#" onclick="alert('인사 관리 권한이 없습니다.'); return false;">근무지 정보 관리</a></li>
				<li><a href="#" onclick="alert('인사 관리 권한이 없습니다.'); return false;">직원 현황 관리</a></li>
				<li><a href="#" onclick="alert('인사 관리 권한이 없습니다.'); return false;">퇴직자 정보 관리</a></li>
				<li><a href="#" onclick="alert('인사 관리 권한이 없습니다.'); return false;">신규 직원 등록</a></li>
       	  	</ul>
       	  </c:otherwise>
        </c:choose>
        
        <h2>급여관리</h2>
        <c:choose>
       	  <c:when test='${sessionScope.permissionvo.can_access_salary eq 1 or sessionScope.employeeVO.dept_name eq "슈퍼관리자"}'>
       		<ul>
            	<li><a href="/pay">직원 급여 리스트</a></li>
				<li><a href="/adminPay">개인 급여 지급 및 수정</a></li>
        	</ul>
       	  </c:when>
       	  <c:otherwise>
       	  	<ul>
       	  		<li><a href="/paylist" onclick="alert('급여 관리 권한이 없습니다.'); return false;">직원 급여 리스트</a></li>
				<li><a href="${pageContext.request.contextPath}/adminPay" onclick="alert('급여 관리 권한이 없습니다.'); return false;">개인 급여 명세서 조회</a></li>
       	  	</ul>
       	  </c:otherwise>
        </c:choose>
        
        <h2>휴가관리</h2>
        <c:choose>
       	  <c:when test='${sessionScope.permissionvo.can_access_vacation eq 1 or sessionScope.employeeVO.dept_name eq "슈퍼관리자"}'>
       		<ul>
            	<li><a href="/pay">직원 급여 리스트</a></li>
				<li><a href="/adminPay">개인 급여 지급 및 수정</a></li>
        	</ul>
       	  </c:when>
       	  <c:otherwise>
       	  	<ul>
       	  		<li><a href="/paylist" onclick="alert('급여 관리 권한이 없습니다.'); return false;">직원 급여 리스트</a></li>
				<li><a href="${pageContext.request.contextPath}/adminPay" onclick="alert('급여 관리 권한이 없습니다.'); return false;">개인 급여 명세서 조회</a></li>
       	  	</ul>
       	  </c:otherwise>
        </c:choose>
        
        <h2>권한 및 전자결제 관리</h2>
        <c:choose>
       	  <c:when test='${sessionScope.permissionvo.can_access_personnel eq 1 or sessionScope.employeeVO.dept_name eq "슈퍼관리자"}'>
       		<ul>
            	<li><a href="/Permission">권한 부여</a></li>
				<li><a href="/PermissionRequest">전자 결제</a></li>
        	</ul>
       	  </c:when>
       	  <c:otherwise>
       	  	<li class="nav-item"><a href="#"
								onclick="alert('권한 및 전자결제 관리 권한이 없습니다.'); return false;">권한 및 전자결제 관리</a>
			<ul class="dropdown-menu">
				<li><a href="#" onclick="alert('권한 및 전자결제 관리 권한이 없습니다.'); return false;">권한 부여</a></li>
				<li><a href="/PermissionRequest?emp_idx=${sessionScope.employeeVO.emp_idx}">전자 결제</a></li>
			</ul>
       	  </c:otherwise>
        </c:choose>
       </div>
</aside>

<script>

    function adjustAsidePosition() {
        const aside = document.getElementById('scrollable-aside');
        const footer = document.querySelector('footer');
        const headerHeight = 80; 
        const scrollY = window.scrollY;
		
  
        if (!footer) {
            aside.style.top = `${scrollY + headerHeight}px`;
            return;
        }
        const footerTop = footer.getBoundingClientRect().top + scrollY; 
       
        const maxTop = footerTop - aside.offsetHeight;
  
        let newTop = scrollY + headerHeight;

   
        if (newTop > maxTop) {
            newTop = maxTop;
        }

       
        aside.style.top = `${newTop}px`;
    }

 
    document.addEventListener('DOMContentLoaded', () => {
        adjustAsidePosition();
    });

    // 스크롤 및 리사이즈 이벤트에 위치 조정 함수 연결
    window.addEventListener('scroll', adjustAsidePosition);
    window.addEventListener('resize', adjustAsidePosition);

    // 푸터가 동적으로 로드될 경우를 대비해 주기적으로 체크
    setTimeout(adjustAsidePosition, 1000); // 1초 후 재시도
</script>


</body>
</html>