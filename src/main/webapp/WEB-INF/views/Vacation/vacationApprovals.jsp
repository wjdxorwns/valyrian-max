<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>휴가 승인</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f7f7f7;
    padding: 20px;
    min-width: 1000px;
    margin: 0 auto;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    background-color: white;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}
th, td {
    padding: 15px;
    text-align: center;
    border: 1px solid #ddd;
    font-size: 14px;
}
th {
    background-color: #003399;
    color: white;
    font-weight: 500;
    white-space: nowrap;
}
td {
    background-color: white;
}
input[type="text"], input[type="date"], select, textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 14px;
}
input[type="text"]:read-only {
    background-color: #f5f5f5;
}
select {
    height: 40px;
    cursor: pointer;
}
textarea {
    resize: vertical;
    min-height: 80px;
    font-family: inherit;
}
.button-container {
    text-align: center;
    margin-top: 30px;
}
button {
    padding: 12px 30px;
    background-color: #003399;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 15px;
    font-weight: 500;
    transition: background-color 0.2s;
}
button:hover {
    background-color: #002277;
}
h2 {
    color: #003399;
    margin-bottom: 25px;
    font-size: 24px;
    font-weight: 500;
}
</style>
</head>
<body>

<h2>휴가 승인</h2>

<form id="vacationForm">
    <table>
        <thead>
            <tr>
                <th>이름</th>
                <th>직책</th>
                <th>부서</th>
                <th>휴가 종류</th>
                <th>시작일</th>
                <th>종료일</th>
                <th>신청 사유</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><input type="text" value="${sessionScope.userVO.emp_name}" readonly></td>
                <td><input type="text" value="${sessionScope.employeeVO.position}" readonly></td>
                <td><input type="text" value="${sessionScope.employeeVO.team}" readonly></td>
                <td>
                    <select name="vacation_type">
                        <option value="연차">연차</option>
                        <option value="공가">공가</option>
                    </select>
                </td>
                <td><input type="text" name="start_date" class="datepicker" required></td>
                <td><input type="text" name="end_date" class="datepicker" required></td>
                <td><textarea name="comment" placeholder="휴가 신청 사유를 입력하세요" required></textarea></td>
            </tr>
        </tbody>
    </table>

    <div class="button-container">
        <button type="button" onclick="submitVacation()">휴가 신청</button>
    </div>
</form>

<script>
$(document).ready(function() {
    $('.datepicker').datepicker({
        dateFormat: 'yy-mm-dd',
        minDate: 0
    });

    $('input[name="start_date"]').on('change', function() {
        $('input[name="end_date"]').datepicker('option', 'minDate', $(this).datepicker('getDate'));
    });
});

function submitVacation() {
    const form = document.getElementById('vacationForm');
    const formData = new FormData(form);
    
    // 필수 입력값 검증
    if (!formData.get('start_date') || !formData.get('end_date') || !formData.get('comment')) {
        alert('모든 필수 항목을 입력해주세요.');
        return;
    }
    
    // 시작일이 종료일보다 늦은 경우 체크
    const startDate = new Date(formData.get('start_date'));
    const endDate = new Date(formData.get('end_date'));
    if (startDate > endDate) {
        alert('종료일은 시작일보다 이후여야 합니다.');
        return;
    }
    
    $.ajax({
        url: '${pageContext.request.contextPath}/submitVacation',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            if (response.success) {
                alert('휴가 신청이 완료되었습니다.');
                location.reload();
            } else {
                alert('휴가 신청 중 오류가 발생했습니다.');
            }
        },
        error: function() {
            alert('서버 통신 중 오류가 발생했습니다.');
        }
    });
}
</script>

</body>
</html>