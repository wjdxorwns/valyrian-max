<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Permission Management</title>
<style type="text/css">
aside {
    position: fixed;
    top: 80px;
    left: 0;
    width: 250px;
    height: calc(100vh - 80px);
    background-color: #ffffff;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    z-index: 9997;
    overflow-y: auto;
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
    padding: 0;
    margin: 0;
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
    padding: 10px;
    transition: all 0.3s ease;
    border-radius: 4px;
}

aside .aside-item ul li a:hover {
    color: #003399;
    background-color: #f5f5f5;
}
</style>
</head>

<body>
<aside>
    <div class="aside-item">
        <c:choose>
			<c:when test='${sessionScope.permissionvo.can_access_employee eq 1 or sessionScope.employeeVO.dept_name eq "슈퍼관리자"}'>
				<li class="nav-item"><a href="/Permission">권한 및 전자결제 관리</a>
					<ul class="dropdown-menu">
						<li><a href="/Permission?emp_idx=${sessionScope.employeeVO.emp_idx}">권한 부여</a></li>
						<li><a href="/PermissionRequest?emp_idx=${sessionScope.employeeVO.emp_idx}">전자 결제</a></li>
					</ul>
				</li>
			</c:when>
			<c:otherwise>
				<li class="nav-item">
					<a href="#" onclick="alert('휴가 관리 권한이 없습니다.'); return false;">권한 및 전자결제 관리</a>
					<ul class="dropdown-menu">
						<li><a href="#" onclick="alert('휴가 관리 권한이 없습니다.'); return false;">권한 부여</a></li>
					</ul>
				</li>
			</c:otherwise>
		</c:choose>
    </div>
</aside>
</body>
</html>