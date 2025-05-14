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
            <h1>회사 소개</h1>
            <p>주식회사 인사플랫폼은 인사 관리와 채용 솔루션을 통해 기업과 인재를 연결하는 혁신적인 플랫폼을 제공합니다. 우리는 효율적이고 투명한 인사 관리로 더 나은 직장 문화를 만들어갑니다.</p>

            <h2>1. 회사 개요</h2>
            <p>주식회사 인사플랫폼은 2020년에 설립된 인사 관리 전문 기업으로, 최신 기술과 데이터 분석을 활용해 기업의 인사 프로세스를 최적화합니다.</p>
            <div class="highlight">
                <ul>
                    <li>설립일: 2020년 3월 1일</li>
                    <li>대표자: 김민수</li>
                    <li>본사: 서울특별시 강남구 테헤란로 123</li>
                    <li>사업 분야: 인사 관리 솔루션, 채용 플랫폼, HR 컨설팅</li>
                </ul>
            </div>

            <h2>2. 미션 및 비전</h2>
            <p>우리의 미션은 모든 기업이 인재를 효율적으로 관리하고, 모든 인재가 자신의 가치를 발휘할 수 있는 환경을 만드는 것입니다.</p>
            <ul>
                <li><strong>미션</strong>: 기술로 인사 관리를 혁신하여 기업과 인재의 성장을 지원합니다.</li>
                <li><strong>비전</strong>: 2030년까지 아시아 최고의 HR 솔루션 제공 기업이 되겠습니다.</li>
            </ul>

            <h2>3. 주요 서비스</h2>
            <p>주식회사 인사플랫폼은 다양한 HR 솔루션을 제공하여 기업의 성공을 돕습니다.</p>
            <ul>
                <li>채용 플랫폼: 맞춤형 채용 솔루션으로 최적의 인재 매칭</li>
                <li>인사 관리 시스템: 직원 데이터 관리, 성과 평가, 근태 관리</li>
                <li>HR 컨설팅: 조직 문화 개선, 인사 전략 수립</li>
            </ul>

            <h2>4. 연혁</h2>
            <p>주식회사 인사플랫폼의 주요 연혁은 다음과 같습니다.</p>
            <div class="highlight">
                <ul>
                    <li>2020년 3월: 주식회사 인사플랫폼 설립</li>
                    <li>2021년 6월: 첫 채용 플랫폼 'HireEasy' 출시</li>
                    <li>2022년 9월: 인사 관리 시스템 'HRPro' 런칭</li>
                    <li>2024년 12월: 아시아 시장 진출</li>
                </ul>
            </div>

            <h2>5. 문의</h2>
            <p>주식회사 인사플랫폼에 대해 더 알고 싶으시거나 문의 사항이 있으시면 아래 연락처로 연락 주세요.</p>
            <div class="highlight">
                <p>담당자: 고객 지원팀<br>연락처: contact@insaplatform.com<br>전화: 02-1234-5678</p>
            </div>

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