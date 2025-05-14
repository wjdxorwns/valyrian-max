<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>근무 지정 방식</title>

<!-- Kakao Maps SDK -->
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=2fd56cec96d0ed0cbdcb396a032dc666"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 작성자: 김재겸 -->

<style>
/* 기본 스타일 */ 
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f7f7f7;
    padding: 30px;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}
th, td {
    padding: 12px;
    text-align: center;
    border: 1px solid #ddd;
}
thead {
    background-color: #003399;
    color: white;
}
select {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}
.map-container {
    width: 100%;
    height: 400px;
    margin-bottom: 20px;
}

.button-container {
    text-align: center;
}
button {
    padding: 10px 20px;
    background-color: #003399;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}
button:hover {
    background-color: #002277;
}
</style>
</head>
<body>

<h2>현재 근무중인 부서 및 근무지 확인</h2>

<form id="workArrangementForm">
    <!-- 로그인된 사원의 고유번호 -->
    <input type="hidden" name="emp_idx" value="${sessionScope.employeeVO.emp_idx}" />

    <table>
        <thead>
            <tr>
                <th>부서</th>
                <th>이름</th>
                <th>직책</th>
                <th>근무방식</th>
                <th>근무지</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>${sessionScope.employeeVO.team}</td>
                <td>${sessionScope.userVO.emp_name}</td>
                <td>${sessionScope.employeeVO.position}</td>
                <td>
                    <select name="attitude_type" id="workTypeSelect">
                        <option value="출장">출장</option>
                        <option value="재택">재택</option>
                        <option value="회사">회사</option>
                    </select>
                </td>
                <td>
                    <select name="location" id="workLocationSelect">
                        <option value="경기도 연천지부">경기도 연천지부</option>
                        <option value="전라남도 나주지부">전라남도 나주지부</option>
                        <option value="경상북도 경산지부">경상북도 경산지부</option>
                        <option value="강원도 속초지부">강원도 속초지부</option>
                    </select>
                </td>
            </tr>
        </tbody>
    </table>

    <!-- 지도 표시 영역 -->
    <div class="map-container">
        <div id="map" style="width:100%; height:300px; border-radius:8px; background-color:#f0f0f0;"></div>
    </div>

    <div class="button-container">
        <button type="button" onclick="updateWorkArrangement()">수정하기</button>
    </div>
</form>

<script type="text/javascript">
// 단일 DOMContentLoaded 이벤트 리스너
document.addEventListener("DOMContentLoaded", function() {
    const script = document.createElement('script');
    script.src = 'https://dapi.kakao.com/v2/maps/sdk.js?appkey=2fd56cec96d0ed0cbdcb396a032dc666';
    script.onload = function() {
        if (typeof kakao !== 'undefined') {
            initializeMap();
        } else {
            console.error('Kakao Maps SDK failed to load.');
        }
    };
    document.head.appendChild(script);
});

// 근무지별 좌표 정의
const locationCoordinates = {
    "경기도 연천지부": { lat: 38.0962, lng: 127.0759 },
    "전라남도 나주지부": { lat: 35.0166, lng: 126.7149 },
    "경상북도 경산지부": { lat: 35.8251, lng: 128.7378 },
    "강원도 속초지부": { lat: 38.2044, lng: 128.5911 }
};

let map, marker;

// 지도 생성 함수
function initializeMap() {
    const container = document.getElementById('map');
    if (!container) return; // 컨테이너가 없으면 종료

    const selectedLocation = document.getElementById('workLocationSelect').value;
    const coords = locationCoordinates[selectedLocation];

    const mapOption = {
        center: new kakao.maps.LatLng(coords.lat, coords.lng),
        level: 3
    };

    map = new kakao.maps.Map(container, mapOption);
    marker = new kakao.maps.Marker({
        position: map.getCenter(),
        map: map
    });

    // 근무지 선택 변경 시 지도 이동
    document.getElementById('workLocationSelect').addEventListener('change', function() {
        const coords = locationCoordinates[this.value];
        const newCenter = new kakao.maps.LatLng(coords.lat, coords.lng);

        map.setCenter(newCenter);
        marker.setPosition(newCenter);
    });
}

// AJAX 요청 함수
function updateWorkArrangement() {
    if (confirm("근무지 및 근무방식 발령을 요청하시겠습니까?")) {
        const empIdx = $('input[name="emp_idx"]').val();
        const location = $('#workLocationSelect').val();
        const attitudeType = $('#workTypeSelect').val();

        $.ajax({
            url: '/updateWorkArrangement',
            type: 'POST',
            data: {
                emp_idx: empIdx,
                location: location,
                attitude_type: attitudeType
            },
            success: function (response) {
                alert('요청 완료');
                location.reload();
            },
            error: function () {
                alert('서버 오류');
            }
        });
    }
}
</script>

</body>
</html>