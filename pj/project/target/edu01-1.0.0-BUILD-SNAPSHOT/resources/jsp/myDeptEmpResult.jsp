<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 작성자: 한찬욱 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출근 확인 결과</title>
<style>
    .table_container {
        width: 100%;
        overflow: auto;
        max-height: 600px; /* 세로 스크롤 높이 조정 */
    }
    
    table {
        border-collapse: collapse;
        width: 100%;
        min-width: 1200px; /* 최소 너비 설정 */
    }
    
    th, td {
        border: 1px solid black;
        padding: 8px;
        text-align: center;
        min-width: 40px; /* 각 셀의 최소 너비 */
    }
    
    th {
        background-color: #f2f2f2;
        position: sticky;
        top: 0;
    }
    
    .sticky_col {
        position: sticky;
        left: 0;
        background-color: #f2f2f2;
        z-index: 1;
    }
    
    .sticky_col_name {
        position: sticky;
        left: 40px;
        background-color: #f2f2f2;
        z-index: 1;
    }
</style>
</head>
<body>
    <c:if test="${not empty error}">
        <div style="color: red;">${error}</div>
    </c:if>
    
    <c:if test="${empty error}">
        <div style="margin-bottom: 10px;">
            
        </div>
        
        <div class="table_container">
            <table>
                <thead>
                    <tr>
                        <th class="sticky_col">번호</th>
                        <th class="sticky_col_name">이름</th>
                        <c:forEach begin="1" end="31" var="day">
                            <th>${day}</th>
                        </c:forEach>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="sticky_col">1</td>
                        <td class="sticky_col_name">한찬욱</td>
                        <c:forEach begin="1" end="31" var="day">
                            <td>출</td>
                        </c:forEach>
                    </tr>
                    <!-- 추가 직원 데이터가 여기에 동적으로 추가될 예정 -->
                </tbody>
                <tfoot>
                    <tr>
                        <td class="sticky_col">합계</td>
                        <td class="sticky_col_name">인원</td>
                        <c:forEach begin="1" end="31" var="day">
                            <td class="day-total">0</td>
                        </c:forEach>
                    </tr>
                </tfoot>
            </table>
        </div>
    </c:if>

    <script>
        // 페이지 로드 시 합계 계산
        document.addEventListener('DOMContentLoaded', function() {
            calculateTotals();
        });

        function calculateTotals() {
            const tbody = document.querySelector('tbody');
            const dayTotals = document.querySelectorAll('.day-total');
            
            // 각 날짜별 합계 계산
            for (let i = 0; i < 31; i++) {
                let total = 0;
                const rows = tbody.querySelectorAll('tr');
                
                rows.forEach(row => {
                    const cells = row.querySelectorAll('td');
                    if (cells[i + 2].textContent === '출') { // +2는 번호와 이름 열을 건너뛰기 위함
                        total++;
                    }
                });
                
                dayTotals[i].textContent = total;
            }
        }
    </script>
</body>
</html>