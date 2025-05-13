<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<!-- 정택준 -->
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
     <h2>급여관리</h2>
        <ul>
            <li><a href="payrollList">급여 리스트 조회</a></li>
            <li><a href="${pageContext.request.contextPath}/adminPay">직급별 급여 리스트</a></li>
        </ul>
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