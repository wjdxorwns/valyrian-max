<!-- 최성현 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>3부상조 - 로그인</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap"
	rel="stylesheet">
<!-- CSS 파일 링크 -->
<link href="<c:url value='/resources/css/Header.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />"
	rel="stylesheet">

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
            <h1>고객지원</h1>
            <p>주식회사 인사플랫폼은 고객의 문의와 문제를 신속하고 친절하게 해결하기 위해 최선을 다하고 있습니다. 아래에서 문의 방법, 자주 묻는 질문, 지원 시간 등을 확인해 주세요.</p>

            <h2>1. 문의 방법</h2>
            <p>우리는 다양한 채널을 통해 고객의 문의를 받고 있습니다. 아래 방법 중 편리한 방식으로 연락 주세요.</p>
            <div class="highlight">
                <ul>
                    <li>이메일: <a href="mailto:support@insaplatform.com">support@insaplatform.com</a></li>
                    <li>전화: 02-1234-5678 (평일 09:00~18:00)</li>
                    <li>온라인 문의: <a href="/contact-form">문의 폼</a>을 통해 24시간 접수 가능</li>
                </ul>
            </div>

            <h2>2. 지원 시간</h2>
            <p>고객지원팀은 다음 시간 동안 운영됩니다. 긴급 문의는 이메일 또는 온라인 문의 폼을 이용해 주세요.</p>
            <ul>
                <li>운영 시간: 평일 09:00~18:00 (점심 시간: 12:00~13:00 제외)</li>
                <li>비운영 시간: 주말 및 공휴일</li>
            </ul>

            <h2>3. 자주 묻는 질문 (FAQ)</h2>
            <p>고객들이 자주 묻는 질문과 답변을 정리했습니다. 문의 전 확인해 보시면 빠르게 해결하실 수 있습니다.</p>
            <div class="highlight">
                <ul>
                    <li><strong>Q: 회원 가입은 어떻게 하나요?</strong><br>A: 홈페이지 우측 상단의 "회원 가입" 버튼을 클릭하여 정보를 입력하시면 됩니다.</li>
                    <li><strong>Q: 비밀번호를 잊어버렸습니다.</strong><br>A: 로그인 페이지에서 "비밀번호 찾기"를 클릭하여 이메일로 재설정 링크를 받아보세요.</li>
                    <li><strong>Q: 채용 공고는 어디서 확인하나요?</strong><br>A: 메인 페이지의 "채용 정보" 섹션에서 최신 공고를 확인하실 수 있습니다.</li>
                </ul>
            </div>

            <h2>4. 기술 지원</h2>
            <p>서비스 이용 중 기술적인 문제가 발생한 경우, 아래 연락처로 문의해 주세요. 신속히 문제를 진단하고 해결 방안을 안내드립니다.</p>
            <div class="highlight">
                <p>기술 지원팀<br>이메일: tech@insaplatform.com<br>전화: 02-9876-5432</p>
            </div>

            <h2>5. 피드백</h2>
            <p>주식회사 인사플랫폼은 고객의 피드백을 소중히 생각합니다. 서비스 개선을 위한 제안이나 의견이 있다면 언제든지 알려주세요.</p>
            <ul>
                <li>피드백 접수: <a href="mailto:feedback@insaplatform.com">feedback@insaplatform.com</a></li>
            </ul>

            <div class="footer">
                <p>최종 업데이트: 2025년 5월 1일</p>
            </div>
        </div>
	</main>

	<!-- Footer -->
	<jsp:include page="/resources/jsp/Footer.jsp" />

	<script>

	</script>
</body>
</html>