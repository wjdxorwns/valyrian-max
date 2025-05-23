<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 메인 페이지</title>
<!-- 기존 CSS 유지 -->
<link href="<c:url value='/resources/css/JeoungTJ/CSS_table.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/JeoungTJ/CSS_jungtakejun.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/JeoungTJ/Main.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/KimYH/media.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css'/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <jsp:include page="/resources/jsp/Header.jsp" />
        <jsp:include page="/resources/jsp/PayAside.jsp" />
    <main style="margin: 80px auto auto;">
        <div class="main-item">
            <div id="title">
                <h2>나의 급여 정보</h2>
                <p>내용설명 본인급여 조회(직원용)</p>
            </div>
            <p>
                지급년월 <input type="month" id="paymentYearMonth" name="payment_date">
                <button id="serch" onclick="searchPayroll()">조회</button>
            </p>
            <div class="emp_information">
                <table class="emp_table">
                    <thead>
                        <tr>
                            <th>선택</th> <!-- 기능 추가 -->
                            <th>직원코드</th>
                            <th>이름</th>
                            <th>지급기준일</th>
                            <th>지급차수</th>
                            <th>부서</th>
                            <th>직책</th>
                            <th>고용형태</th>
                            <th>기본급</th>
                            <th>보너스</th>
                            <th>실수령액</th>
                        </tr>
                    </thead>
                    <tbody id="payrollTableBody">
                        <c:choose>
                            <c:when test="${empty paylist}">
                                <tr>
                                    <td colspan="11"><h3>내용이 없습니다</h3></td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="pay" items="${paylist}">
                                    <tr>
                                        <td><input type="checkbox" name="salary_ids" value="${pay.salary_id}"></td>
                                        <td>${pay.emp_idx}</td>
                                        <td>${pay.emp_name}</td>
                                        <td>${pay.payment_date}</td>
                                        <td>${pay.pay_grade}</td>
                                        <td>${pay.team}</td>
                                        <td>${pay.position}</td>
                                        <td>${pay.employment_type}</td>
                                        <td>${pay.base_salary}</td>
                                        <td>${pay.bonus}</td>
                                        <td>${pay.base_salary + pay.bonus}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            <div id="but" style="margin-bottom: 50px;">
                <button onclick="downloadExcel()">다운로드</button>
                <button onclick="loadAllMyPayroll()">전체 보기</button>
                <button onclick="cancel()">취소</button>
            </div>
        </div>
    </main>
    <jsp:include page="/resources/jsp/Footer.jsp" />
    <script type="text/javascript">
        function searchPayroll() {
            const paymentDateInput = document.querySelector("input[name='payment_date']").value;
            const emp_idx = "${sessionScope.emp_idx}";
            if (!paymentDateInput) {
                alert("지급년월을 선택하세요.");
                return;
            }
            location.href = "/paylist?emp_idx=" + emp_idx + "&payment_date=" + encodeURIComponent(paymentDateInput);
        }

        function loadAllMyPayroll() {
            const emp_idx = "${sessionScope.emp_idx}";
            location.href = "/paylist?emp_idx=" + emp_idx;
        }

        function cancel() {
            window.history.back();
        }

        // ✅ 기능 병합된 부분: 다운로드 처리
        function downloadExcel() {
            const checkboxes = document.querySelectorAll("input[name='salary_ids']:checked");
            if (checkboxes.length === 0) {
                alert("급여 항목을 선택해주세요.");
                return;
            }

            const form = document.createElement("form");
            form.method = "POST";
            form.action = "/downloadExcelMultiple";
            form.style.display = "none";

            checkboxes.forEach(cb => {
                const input = document.createElement("input");
                input.type = "hidden";
                input.name = "salary_ids";
                input.value = cb.value;
                form.appendChild(input);
            });

            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>
</html>
