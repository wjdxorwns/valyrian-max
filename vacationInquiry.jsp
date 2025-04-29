<!-- 작성자 : 김용호 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 - 휴가 조회 및 신청 화면</title>
    <!-- 폰트 로드 -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <!-- Font Awesome for social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- CSS 파일 링크 -->
    <link href="<c:url value='resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='resources/css/Footer.css' />" rel="stylesheet">
    
<link rel="stylesheet" 
	href="${pageContext.request.contextPath}/resources/css/Vacation.css">
<style type="text/css">
*{
margin: 0;
padding:0;
}


/* 남은 휴가 정보 */
#possible{
border:1px solid black;
background-color: #fff;
text-align: center;
margin-top: 10px;
margin-bottom: 20px;
}
#possible p{
margin: 10px auto;
}

/* 휴가 신청 */
#apply{
border:1px solid black;
text-align: center;
background-color: #fff;
overflow: hidden;
}
#apply p{
margin: 10px;
}
#apply table{
border-bottom: 2px solid black;
}

#button{
margin: 5px;
padding:5px;
float: right;
}

/* 사용한 휴가 */
#complete{
border:1px solid black;
background-color: #fff;
text-align: center;
margin-top: 20px;
margin-bottom: 20px;

}
#complete p{
margin: 10px auto;
}
#complete th, td{
width:150px;
height:50px;
text-align: center;


}

/* 공통 */
table{
margin-top:10px;

border-top: 2px solid black;
}
th, td{
width:150px;
height:50px;
text-align: center;
border:1px solid black;
}
tbody td input{
padding:5px;
} 

</style>
</head>
<body>

	<!-- Header -->
	<jsp:include page="/resources/jsp/Header.jsp" />
	
	<main>
		<form action="" method="post" >
			<div id="title">
				<h2>휴가 신청 및 현황 조회</h2>
			</div>
			<div id="possible">
				<p>신청가능 휴가 정보</p>
				<table>
					<thead>
						<tr>
							<th>휴가 구분</th><th>연차</th><th>월차</th><th>반차</th><th>미사용 월차</th><th>비고</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th style="background-color: #e0f4ff;">가용 가능</th>
							<td>
								<c:forEach var="v" items="${emp_idx}"> <!-- Employee(직원) 테이블 -->
									<c:if test="${v.vacation_type == '연차'}">
										${v.vacation_day}일<br>
									</c:if>
								</c:forEach>
							</td>
							<td>
								<c:forEach var="v" items="${emp_idx}"> <!-- Employee(직원) 테이블 -->
									<c:if test="${v.vacation_type == '월차'}">
										${v.vacation_day}일<br>
									</c:if>
								</c:forEach>
							</td>
							<td>
								<c:forEach var="v" items="${emp_idx}"> <!-- Employee(직원) 테이블 -->
									<c:if test="${v.vacation_type == '반차'}">
										${v.vacation_day}회<br>
									</c:if>
								</c:forEach>
							</td>
							<td>
								<c:forEach var="v" items="${usedList}">
									<c:if test="${v.vacation_type == '미사용 월차'}">
										${v.vacation_day}일<br>
									</c:if>
								</c:forEach>
							</td>
							<td></td>
						</tr>
						
					</tbody>
				</table>
			</div>
			
			<div id="apply">
			<p>휴가 신청</p>
				<table>
					<thead>
						<tr>
							<th>Check</th><th>휴가 구분</th><th>시작날짜</th><th>종료날짜</th><th>상태</th><th>비고</th>
						</tr>
					</thead>
					<tbody id="vacationTableBody">
						<tr>
							<td><input type="radio"></td>
							<td>${vacation_type }
								<select name="vacation" onchange="changeDateType(this)">
									<option value="연차">연차</option>
									<option value="월차">월차</option>
									<option value="반차">반차</option>
								</select>
							</td>
							<td><input type="date" name="startDate">${start_date }</td>
							<td><input type="date" name="endDate"${end_date }></td>
							<td>
								<c:choose>
									<c:when test="${vacationVO.status eq '승인완료'}">
										승인완료
									</c:when>
									<c:otherwise>
										승인대기
									</c:otherwise>
								</c:choose>
							</td>
							<td></td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<th rowspan="4" style="background-color: #e0f4ff;">
								첨부파일
							</th>
							<td colspan="5" style="height:150px;"></td>
						</tr>
						<tr>
							<td colspan="5" >
								<input type="file" name="vacationFile" multipartfile>
								<input type="button" value="보내기" onclick="">
							</td>
						</tr>
					</tfoot>
				</table>
					<input id="button" type="button" value="신청" onclick="request_vacation()">
					<input id="button" type="button" value="삭제" onclick="deleteSelectedRow()">
					<input id="button" type="button" value="추가" onclick="addRow()">
			</div>
			
			<div id="complete">
				<p>신청완료 휴가 정보</p>
				<table>
					<thead>
						<tr>
							<th>휴가 구분</th><th>연차</th><th>월차</th><th>반차</th><th>휴가ID</th><th>비고</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="background-color: #e0f4ff;">사용 완료</td>
							<td>
								<c:forEach var="v" items="${emp_idx}"> <!-- Employee(직원) 테이블 -->
									<c:if test="${v.vacation_type == '연차'}">
										${v.start_date} ~ ${v.end_date} - ${v.vacation_day}일 사용<br>
									</c:if>
								</c:forEach>
							</td>
							<td>
								<c:forEach var="v" items="${emp_idx}"> <!-- Employee(직원) 테이블 -->
									<c:if test="${v.vacation_type == '월차'}">
										${v.start_date} ~ ${v.end_date} - ${v.vacation_day}일 사용<br>
									</c:if>
								</c:forEach>
							</td>
							<td>
								<c:forEach var="v" items="${emp_idx}"> <!-- Employee(직원) 테이블 -->
									<c:if test="${v.vacation_type == '반차'}">
										${v.start_date} ~ ${v.end_date} - 반차 사용<br>
									</c:if>
								</c:forEach>
							</td>
						<td></td>
						<td></td>
						</tr>
						<tr>
							<td style="height:200px; background-color: #e0f4ff;">사용 내역</td>
							<td colspan="3" style="height:200px;">휴가 사용 내역</td>
							<td>${vacation_id }</td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
	</main>
	
	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

<script>
function addRow() {
	  const tbody = document.getElementById("vacationTableBody");

	  const newRow = document.createElement("tr");
	  newRow.innerHTML = `
	    <td><input type="radio" name="selectItem"></td>
	    <td>
	      <select name="vacation">
	        <option value="연차">연차</option>
	        <option value="월차">월차</option>
	        <option value="반차">반차</option>
	      </select>
	    </td>
	    <td><input type="date" name="startDate"></td>
	    <td><input type="date" name="endDate"></td>
	    <td>승인대기</td>
	    <td></td>
	  `;

	  tbody.appendChild(newRow);
	}
function changeDateType(selectElement) {
	  const tr = selectElement.closest('tr');
	  const startDateInput = tr.querySelector('input[name="startDate"]');
	  const endDateInput = tr.querySelector('input[name="endDate"]');

	  if (selectElement.value === "반차") {
	    startDateInput.type = "time";
	    endDateInput.type = "time";
	  } else {
	    startDateInput.type = "date";
	    endDateInput.type = "date";
	  }
	}

	function deleteSelectedRow() {
	  const radios = document.getElementsByName("selectItem");

	  for (let i = 0; i < radios.length; i++) {
	    if (radios[i].checked) {
	      const row = radios[i].closest("tr");
	      row.remove();
	      break;
	    }
	  }
	}

	function deleteSelectedRow() {
	  const radios = document.getElementsByName("selectItem");

	  for (let i = 0; i < radios.length; i++) {
	    if (radios[i].checked) {
	      const row = radios[i].closest("tr");
	      row.remove();
	      break;
	    }
	  }
	}
	function changeDateType(selectElement) {
	    // 현재 선택한 값 읽기
	    var selectedValue = selectElement.value;
	    
	    // 같은 행(tr) 안에 있는 startDate, endDate input을 찾아야 함
	    var tr = selectElement.closest('tr'); // select 태그가 속한 tr
	    var startDateInput = tr.querySelector('input[name="startDate"]');
	    var endDateInput = tr.querySelector('input[name="endDate"]');

	    if (selectedValue === '반차') {
	        startDateInput.type = 'time';
	        endDateInput.type = 'time';
	    } else {
	        startDateInput.type = 'date';
	        endDateInput.type = 'date';
	    }
	}
</script>
</body>
</html>