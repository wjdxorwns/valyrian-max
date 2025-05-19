<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>권한 부여 페이지</title>
<link href="<c:url value='/resources/css/KimJK/CSS_permission.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/JeoungTJ/CSS_table.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/JeoungTJ/CSS_jungtakejun.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Main.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css'/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<jsp:include page="/resources/jsp/Header.jsp" />

<main>
    <jsp:include page="/resources/jsp/PermissionAside.jsp" />
    <div class="content-table" style="width: 1200px; margin-left: 150px;">
        <table>
            <thead>
                <tr>
                    <th>이름</th>
                    <th>직원 정보</th>
                    <th>근무 방식</th>
                    <th>인사 발령</th>
                    <th>급여</th>
                    <th>휴가</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty userList}">
                        <tr>
                            <td colspan="7" style="text-align: center;">데이터가 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="user" items="${userList}">
                            <tr>
                                <td>${user.emp_name}</td>
                                <td><select onchange="onPermissionChange('${user.emp_idx}', 'canAccessEmployee', this.value)">
                                    <option value="승인" ${user.canAccessEmployee=='승인' ? 'selected' : '' }>승인</option>
                                    <option value="미승인" ${user.canAccessEmployee=='미승인' ? 'selected' : '' }>미승인</option>
                                </select></td>
                                <td><select onchange="onPermissionChange('${user.emp_idx}', 'canAccessWorktype', this.value)">
                                    <option value="승인" ${user.canAccessWorktype=='승인' ? 'selected' : '' }>승인</option>
                                    <option value="미승인" ${user.canAccessWorktype=='미승인' ? 'selected' : '' }>미승인</option>
                                </select></td>
                                <td><select onchange="onPermissionChange('${user.emp_idx}', 'canAccessPersonnel', this.value)">
                                    <option value="승인" ${user.canAccessPersonnel=='승인' ? 'selected' : '' }>승인</option>
                                    <option value="미승인" ${user.canAccessPersonnel=='미승인' ? 'selected' : '' }>미승인</option>
                                </select></td>
                                <td><select onchange="onPermissionChange('${user.emp_idx}', 'canAccessSalary', this.value)">
                                    <option value="승인" ${user.canAccessSalary=='승인' ? 'selected' : '' }>승인</option>
                                    <option value="미승인" ${user.canAccessSalary=='미승인' ? 'selected' : '' }>미승인</option>
                                </select></td>
                                <td><select onchange="onPermissionChange('${user.emp_idx}', 'canAccessVacation', this.value)">
                                    <option value="승인" ${user.canAccessVacation=='승인' ? 'selected' : '' }>승인</option>
                                    <option value="미승인" ${user.canAccessVacation=='미승인' ? 'selected' : '' }>미승인</option>
                                </select></td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <form id="permissionForm" style="text-align: center; margin-top: 10px;">
        <div id="but" style="margin-top: 10px; margin-left: 600px;">
            <button type="submit" style="margin-right: 10px;">수정</button>
            <button type="button" onclick="location.href='/'">취소</button>
        </div>
    </form>
</main>

<jsp:include page="/resources/jsp/Footer.jsp" />

<script type="text/javascript">
    const changedPermissions = {};

    function onPermissionChange(userId, permissionType, value) {
        if (!changedPermissions[userId]) {
            changedPermissions[userId] = {};
        }
        changedPermissions[userId][permissionType] = (value === '승인');
    }

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelector('#permissionForm').addEventListener('submit', function (event) {
            event.preventDefault();

            fetch('/updatePermissions', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(changedPermissions)
            })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => { throw new Error(text) });
                }
                return response.json();
            })
            .then(data => {
                if (data.status === 'success') {
                    window.location.href = '/Permission'; // 세션에서 emp_idx를 유지하므로 파라미터 생략 가능
                } else {
                    alert('업데이트 실패: ' + data.message);
                }
            })
            .catch((error) => {
                console.error('Error:', error);
                alert('에러 발생: ' + error.message);
            });
        });
    });
</script>
</body>
</html>