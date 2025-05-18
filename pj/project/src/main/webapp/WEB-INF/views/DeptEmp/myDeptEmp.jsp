<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 작성자: 한찬욱 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출근 확인</title>

	<!-- 화면(CSS) 링크 -->
    <link href="<c:url value='/resources/css/HanCW/CSS_mydeptemp.css' />" rel="stylesheet">
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
	
	table,tr,td,th {
		border: 1px solid black;
		border-collapse: collapse;
	}
	th{
		width: 120px;
	}
	table {
	   		
		text-align: center;
		overflow: auto scroll;
		margin-top: 50px;
		margin-bottom: 50px;
		margin-left: 50px;
		}
</style>
  

</head>
<body>
	<!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />
    <!-- Aside -->
    <jsp:include page="/resources/jsp/PayAside.jsp" /> 
	
	<main>	
		<div style="margin-top: 80px">
			<div style="gap: 1800px;">
				<div>
				  <h2>직원 출근 확인</h2>
				  <h4>직원들의 주간별 근무 확인</h4>
				</div>
				<div>
					<br>
					<label for="yearSelect"> 연도 : </label>
						<select id="yearSelect">
							<!-- JavaScript로 동적 생성 -->
						</select>
					<label for="monthSelect" style="margin-left: 15px;"> 월  : </label>
						<select id="monthSelect">
							<option value="1">1월</option>
							<option value="2">2월</option>
							<option value="3">3월</option>
							<option value="4">4월</option>
							<option value="5">5월</option>
							<option value="6">6월</option>
							<option value="7">7월</option>
							<option value="8">8월</option>
							<option value="9">9월</option>
							<option value="10">10월</option>
							<option value="11">11월</option>
							<option value="12">12월</option>						
						</select>	
						<button style="margin-left: 15px; width: 35px;" onclick="searchAttendance()">검색</button>
					
				</div>
			</div>
			<div id="loadingIndicator" style="text-align:center; margin-bottom:10px;"></div>
			<div id="resultContainer">
			<!-- 결과 출력 -->				
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
			                    <c:forEach items="${employeeList}" var="employee" varStatus="status">
			                        <tr data-emp-idx="${employee.emp_idx}">
			                            <td class="sticky_col">${status.count}</td>
			                            <td class="sticky_col_name">${employee.emp_name}</td>
			                            <c:forEach begin="1" end="31" var="day">
			                                <td></td>
			                            </c:forEach>
			                        </tr>
			                    </c:forEach>
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
			</div>	
		</div>
	</main>
		
	<!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />
	
		<script type="text/javascript">

			const searchUrl = '<c:url value="/attendance/search" />';

			// 페이지 로드 시 연도 옵션 생성
			document.addEventListener('DOMContentLoaded', function() {
				const yearSelect = document.getElementById('yearSelect');
				const currentYear = new Date().getFullYear();
				
				// 현재 연도부터 5년 전까지의 옵션 생성
				for (let year = currentYear; year >= currentYear - 5; year--) {
					const option = document.createElement('option');
					option.value = year;
					option.textContent = year + '년';
					yearSelect.appendChild(option);
				}
				
				// 현재 월 선택
				const currentMonth = new Date().getMonth() + 1;
				document.getElementById('monthSelect').value = currentMonth;

				// 페이지 로드 시 합계 계산 (기존 두 번째 리스너 내용)
				// 만약 searchAttendance()를 페이지 로드 시 바로 호출한다면,
				// calculateTotals()는 searchAttendance 성공 콜백에서 호출되므로 여기서 호출 안 해도 됨.
				// 그렇지 않다면 여기서 호출.
				calculateTotals();
			});

			function searchAttendance() {
				const year = document.getElementById('yearSelect').value;
				const month = document.getElementById('monthSelect').value;
				

				const resultContainer = document.getElementById('resultContainer');
				
				const tableBody = resultContainer.querySelector('table tbody');
				
				const loadingIndicator = document.getElementById('loadingIndicator');
				if (loadingIndicator) {
					loadingIndicator.innerHTML = '데이터를 불러오는 중...';
				}
				
				fetch(`${searchUrl}?year=${year}&month=${month}`, {
					method: 'GET',
				
				})
				.then(response => {
					if (!response.ok) {
				
						throw new Error('Network response was not ok');
					}
					return response.json();
				})
				.then(data => {
            // data는 서버로부터 받은 JSON 객체입니다.
            // 예시: data = { attendanceList: [...], year: "2023", month: "5", error: null }
            console.log('서버로부터 받은 데이터:', data);

            if (loadingIndicator) {
                loadingIndicator.innerHTML = ''; // 로딩 메시지 제거
            }

            if (!tableBody) {
                console.error('테이블의 tbody 요소를 찾을 수 없습니다.');
                if (resultContainer) resultContainer.innerHTML = '<div style="color: red; text-align: center;">오류: 테이블 구조를 찾을 수 없습니다. 페이지를 새로고침 해주세요.</div>';
                return;
            }

            // 서버에서 보낸 에러 메시지가 있는지 확인
            if (data.error) {
                // 에러가 있다면 tbody 내용을 비우고 에러 메시지를 표시합니다.
                tableBody.innerHTML = ''; // 기존 행들 모두 제거
                const errorRow = tableBody.insertRow();
                const cell = errorRow.insertCell();
                cell.colSpan = 33; // 번호 + 이름 + 31일 = 33칸
                cell.style.color = 'red';
                cell.style.textAlign = 'center';
                cell.textContent = data.error;
                // 합계 부분도 0으로 초기화
                document.querySelectorAll('.day-total').forEach(td => td.textContent = '0');
                return;
            }

            // 정상적인 attendanceList 데이터를 받았을 경우 테이블 내용 업데이트

            // 방법 1: 기존 tbody의 행들을 유지하고 각 셀의 내용만 업데이트 (권장)
            // 이 방법은 JSP가 페이지 로드 시 직원 목록(tr)을 미리 그려두었을 때 사용합니다.
            if (data.attendanceList && Array.isArray(data.attendanceList)) {
                // 1. 받은 출근 데이터를 사용하기 쉽게 가공 (emp_idx를 키로, 그 값은 다시 day를 키로 하는 Map)
                const attendanceMapByEmployee = new Map();
                data.attendanceList.forEach(att => {
                    if (!attendanceMapByEmployee.has(att.emp_idx)) {
                        attendanceMapByEmployee.set(att.emp_idx, new Map());
                    }
                    // att.day는 숫자여야 합니다. 서버에서 문자열로 오면 parseInt(att.day, 10) 필요
                    attendanceMapByEmployee.get(att.emp_idx).set(Number(att.day), att.attendance_status);
                });

                // 2. HTML 테이블의 각 직원 행(tr)을 순회
                const rows = tableBody.querySelectorAll('tr[data-emp-idx]'); // data-emp-idx 속성이 있는 행만
                if (rows.length === 0) {
                    console.warn('tbody에 data-emp-idx 속성을 가진 직원 행이 없습니다. 초기 로딩을 확인하세요.');
                    // 직원 행이 없다면, 방법 2처럼 tbody를 새로 그려야 할 수 있습니다.
                    // 여기서는 간단히 에러 메시지를 표시하거나 아무것도 하지 않을 수 있습니다.
                }

                rows.forEach(row => {
                    const empIdx = parseInt(row.dataset.empIdx, 10);
                    const employeeAttendanceRecord = attendanceMapByEmployee.get(empIdx);

                    // 3. 각 직원의 날짜별 셀(td)을 업데이트
                    for (let day = 1; day <= 31; day++) {
                        // td는 번호(0), 이름(1) 다음부터 시작하므로 day + 1 번째 셀
                        const cell = row.cells[day + 1]; 
                        if (cell) {
                            cell.textContent = ''; // 일단 기존 내용 지우기
                            if (employeeAttendanceRecord && employeeAttendanceRecord.has(day)) {
                                cell.textContent = employeeAttendanceRecord.get(day); // 새 출근 상태 표시
                            }
                        }
                    }
                });
            } else {
                // attendanceList가 없거나 배열이 아닌 경우 (또는 직원 행을 새로 그려야 하는 경우)
                tableBody.innerHTML = ''; // 일단 비우기
                const noDataRow = tableBody.insertRow();
                const cell = noDataRow.insertCell();
                cell.colSpan = 33;
                cell.style.textAlign = 'center';
                cell.textContent = '표시할 출근 데이터가 없습니다.';
                 document.querySelectorAll('.day-total').forEach(td => td.textContent = '0');
            }

            // 4. 모든 업데이트 후, 일별 합계 다시 계산
            if (typeof calculateTotals === 'function') {
                calculateTotals();
            }

        })
				.catch(error => {
					console.error('Error:', error); // 'Error:' 보다는 '데이터 요청/처리 중 오류:' 등이 더 명확할 수 있습니다.
					// loadingIndicator가 있다면 여기서도 비워주는 것이 좋습니다.
					if (loadingIndicator) {
						loadingIndicator.innerHTML = '';
					}
					document.getElementById('resultContainer').innerHTML =
						'<div style="color: red; text-align: center;">데이터를 불러오는 중 오류가 발생했습니다.</div>';
					// 이 경우에도 tbody를 비우고 합계를 0으로 만드는 것이 일관성 있습니다.
					if (tableBody) { // tableBody 변수가 이 스코프에서 접근 가능한지 확인 필요
						 tableBody.innerHTML = '';
					}
					document.querySelectorAll('.day-total').forEach(td => td.textContent = '0');
				});
			}
							
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
	                    if (cells[i + 2].textContent === '출' /* || cells[i + 2].textContent === '정상' 등 실제 값에 맞게 */) {
	                        total++;
	                    }
	                });
	                
	                dayTotals[i].textContent = total;
	            }
	        }			
		</script>		
		
	</body>
</html>




