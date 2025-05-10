<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- 작성자: 김재겸 -->

<html>
<head>
	<meta charset="UTF-8">
	<title>3부상조 _ 근무 지정 방식</title>
	
	<!-- 폰트 로드 -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/resources/css/KimJK/CSS_working_arrangement.css">
    <link rel="stylesheet" href="/resources/css/Main.css">
    <link rel="stylesheet" href="/resources/css/Header.css">
    <link rel="stylesheet" href="/resources/css/Footer.css">
</head>
<body>
	<jsp:include page="/resources/jsp/Header.jsp" />
	
	<main>
		<h2>근무 방식 및 근무지 신청</h2>
		<h4>근무 지정 방식</h4>
		
		<!-- 검색 기능 추가 -->
		<div class="style_input">
			<input type="text" placeholder="이름을 넣으세요" />
		</div>
		
		<div class="working_arrange_main">
			<div class="container_table">
				<table class="style_table">
				  <thead style="background-color: #003399; color: white;">
				  	<tr scope="col">
				  	  <th>번호</th>
				  	  <th>부서</th>
				  	  <th>이름</th>
				  	  <th>직책</th>
				  	  <th>근무방식</th>
				  	</tr>
				  </thead>
				  <tbody>
					<tr>
					  <td><!-- EmployeeVO.user_idx --></td>
					  <td><!-- EmployeeVO.dept_name --></td>
					  <td><!-- UserVO.user_name --></td>
					  <td><!-- EmployeeVO.attitude_type --></td>
					  <td>
						<select>
							<!-- 백엔드에서 enum 타입의 데이터를 가져와서 여기에 추가 -->
							<option value="출장">출장</option>
							<option value="재택">재택</option>
							<option value="회사">회사</option>
						</select>
					  </td>
					</tr>
				  </tbody>
				</table>
			</div>
		</div>
		<!-- 저장 버튼 추가 -->
		<div class="style_button">
			<button type="submit" onclick="submitForm()">저장</button>
		</div>
	</main>
	
	<jsp:include page="/resources/jsp/Footer.jsp" />
	
	<script>
		function submitForm() {
			// POST 요청을 통해 백엔드에 데이터 전송
			// 여기에 AJAX 요청 또는 폼 제출 로직 추가
		}
	</script>
</body>
</html>