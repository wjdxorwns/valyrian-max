```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>개인정보처리방침</title>
    <!-- CSS 파일 링크 -->
    <link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
    <style>
        .privacy-container {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fff;
            color: #333;
            line-height: 1.6;
            max-width: 800px;
            margin: 120px auto 50px; /* 헤더 높이(80px) + 여백 조정 */
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .privacy-container h1 {
            font-size: 2.2em;
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
        }
        .privacy-container h2 {
            font-size: 1.5em;
            color: #34495e;
            margin-top: 30px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        .privacy-container p, .privacy-container li {
            font-size: 1em;
            color: #4a4a4a;
            margin-bottom: 15px;
        }
        .privacy-container ul {
            padding-left: 20px;
        }
        .privacy-container li {
            list-style-type: disc;
            margin-bottom: 10px;
        }
        .privacy-container .highlight {
            background-color: #e8f4f8;
            padding: 15px;
            border-left: 4px solid #3498db;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .privacy-container .footer {
            text-align: center;
            margin-top: 40px;
            font-size: 0.9em;
            color: #7f8c8d;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />

    <main>
        <div class="privacy-container">
            <h1>개인정보처리방침</h1>
            <p>주식회사 인사플랫폼(이하 "회사")은 이용자의 개인정보를 소중히 보호하기 위해 「개인정보보호법」 및 관련 법령을 준수하며, 아래와 같이 개인정보처리방침을 수립·공개합니다.</p>

            <h2>1. 개인정보의 처리 목적</h2>
            <p>회사는 다음의 목적을 위해 개인정보를 처리합니다. 처리한 개인정보는 다음 목적 이외의 용도로는 사용되지 않습니다.</p>
            <ul>
                <li>회원 가입 및 관리: 회원제 서비스 제공, 본인 확인, 개인 식별</li>
                <li>서비스 제공: 채용 정보 제공, 인사 관리, 맞춤형 서비스 제공</li>
                <li>마케팅 및 광고: 이벤트 및 광고성 정보 제공, 이용자 분석</li>
            </ul>

            <h2>2. 처리하는 개인정보 항목</h2>
            <p>회사는 아래와 같은 개인정보를 수집·이용합니다.</p>
            <div class="highlight">
                <ul>
                    <li>필수 항목: 이름, 이메일 주소, 연락처, 생년월일</li>
                    <li>선택 항목: 학력, 경력, 자격증</li>
                    <li>자동 수집 항목: IP 주소, 쿠키, 방문 기록</li>
                </ul>
            </div>

            <h2>3. 개인정보의 보유 및 이용 기간</h2>
            <p>회사는 개인정보의 수집·이용 목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 아래의 경우에는 예외적으로 보관합니다.</p>
            <ul>
                <li>법령에 따라 보존해야 하는 경우: 전자상거래 등에서의 소비자 보호에 관한 법률(5년)</li>
                <li>회원 탈퇴 후 재가입 방지를 위해: 30일간 보관</li>
            </ul>

            <h2>4. 개인정보의 제3자 제공</h2>
            <p>회사는 이용자의 동의 없이 개인정보를 제3자에게 제공하지 않습니다. 다만, 법령에 따라 요구되는 경우에는 예외로 제공될 수 있습니다.</p>

            <h2>5. 개인정보의 안전성 확보 조치</h2>
            <p>회사는 개인정보 보호를 위해 다음과 같은 조치를 취하고 있습니다.</p>
            <ul>
                <li>기술적 조치: 암호화, 방화벽 설치, 접근 통제</li>
                <li>관리적 조치: 내부 관리 계획 수립, 정기적 직원 교육</li>
            </ul>

            <h2>6. 이용자의 권리와 행사 방법</h2>
            <p>이용자는 언제든지 자신의 개인정보를 조회하거나 수정할 수 있으며, 삭제를 요청할 수 있습니다. 권리 행사는 아래 연락처로 요청해 주시기 바랍니다.</p>
            <div class="highlight">
                <p>개인정보 보호 담당자: 김민수<br>연락처: privacy@insaplatform.com<br>전화: 02-1234-5678</p>
            </div>

            <h2>7. 개인정보처리방침의 변경</h2>
            <p>본 방침은 법령 및 회사 정책에 따라 변경될 수 있으며, 변경 시 홈페이지를 통해 공지합니다.</p>

            <div class="footer">
                <p>시행일자: 2025년 5월 1일</p>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />

    <script>
        // 필요한 경우 JavaScript 추가
    </script>
</body>
</html>
```