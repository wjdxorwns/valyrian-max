<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>트라이어드 솔루션 - 비즈니스 플랫폼</title>
<!-- 폰트 로드 -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
<!-- Font Awesome for social icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- CSS 파일 링크 -->
<link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/index.css' />" rel="stylesheet">
<style>
/* 중요 공지사항 배지 스타일 */
.importance-badge {
    background-color: #ff6b6b;
    color: #fff;
    padding: 0.2rem 0.5rem;
    border-radius: 4px;
    font-size: 0.8rem;
    margin-left: 0.5rem;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // 페이지 로드 후 Ajax 요청을 통해 공지사항 불러오기
    $(document).ready(function() {
        fetchNotices();
    });

    function fetchNotices() {
        $.ajax({
            url: '<c:url value="/notice/latest-ajax" />', // Ajax 요청 URL
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log("AJAX 응답 데이터:", response); // 디버깅용: 응답 데이터 전체 확인
                let noticeList = response.notices;
                let lastUpdateDate = response.lastUpdateDate;
                
                // 최신 업데이트 시간 표시
                if (lastUpdateDate) {
                    $('.txt-sub3').text('최신 업데이트: ' + lastUpdateDate);
                } else {
                    $('.txt-sub3').text('최신 업데이트 정보가 없습니다.');
                }

                // 공지사항 목록 생성
                let postList = $('.post-list');
                postList.empty(); // 기존 리스트 초기화

                if (noticeList && noticeList.length > 0) {
                    // 상위 3개만 가져오기
                    let latestThreeNotices = noticeList.slice(0, 3);

                    $.each(latestThreeNotices, function(index, notice) {
                        console.log("처리 중인 공지사항:", notice); // 디버깅용: 각 공지사항 객체 확인
                        let importanceBadge = notice.importance === '중요' ? 
                            '<span class="importance-badge">중요</span>' : '';
                        
                        // created_at이 null 또는 undefined일 경우 'N/A' 처리 (필수)
                        let createdAt = notice.created_at ? notice.created_at : 'N/A';
                        
                        // username이 null 또는 undefined일 경우 '알 수 없음' 처리 (필수)
                        let username = notice.username ? notice.username : '알 수 없음';

                        // 백틱 대신 문자열 연결 사용
                        let listItem = '';
                        listItem += '<li class="post-item">';
                        listItem += '    <a href="notice/detail?id=' + notice.board_id + '">';
                        listItem += '        <h3 class="post-title">' + notice.title + '</h3>';
                        listItem += '        <p class="post-meta">';
                        listItem += '            <span>작성자: ' + username + '</span>';
                        listItem += '            <span>작성일: ' + createdAt + '</span>';
                        listItem += '            ' + importanceBadge;
                        listItem += '        </p>';
                        listItem += '    </a>';
                        listItem += '</li>';

                        postList.append(listItem);
                    });
                } else {
                    postList.append('<li class="post-item"><p>공지사항이 없습니다.</p></li>');    
                }
            },
            error: function(xhr, status, error) {
                console.error('공지사항 로드 실패:', error);
                console.error("응답 텍스트:", xhr.responseText); // 추가: 서버에서 받은 오류 응답 텍스트 확인
                $('.post-list').html('<li class="post-item"><p>공지사항을 불러오는 중 오류가 발생했습니다.</p></li>');
            }
        });
    }
</script>
</head>
<body>
    <div class="wrap">
        <!-- 헤더 -->
        <jsp:include page="/resources/jsp/Header.jsp" />

        <!-- 콘텐츠 -->
        <div class="content">
            <!-- 비주얼 섹션 -->
            <div class="visual">
                <div class="container">
                    <div class="txt-box">
                        <h2 class="txt-main">트라이어드 솔루션<span class="strong">비즈니스 플랫폼</span></h2>
                        <p class="txt-sub">혁신적인 솔루션으로<br>당신의 비즈니스를 한 단계 업그레이드하세요.</p>
                    </div>
                </div>
            </div>

            <!-- 바로가기 섹션 -->
            <div class="shortcut">
                <div class="container">
                    <ul class="shortcut-list clearfix">
                        <li class="shortcut-list-item"><a href="calendar">
                            <h3 class="txt-main">캘린더</h3>
                            <p class="txt-sub">트라이어드 솔루션의 캘린더로<br>일정을 효율적으로 관리하세요.</p>
                            <p class="img-box"><span class="screen-hidden"></span></p>
                        </a></li>
                        <li class="shortcut-list-item"><a href="attendance">
                            <h3 class="txt-main">근태 관리</h3>
                            <p class="txt-sub">출근 및 퇴근 시간을<br>실시간으로 간편하게 기록하세요.</p>
                            <p class="img-box"><span class="screen-hidden"></span></p>
                        </a></li>
                        <li class="shortcut-list-item"><a href="electronicpayment">
                            <h3 class="txt-main">전자 결제</h3>
                            <p class="txt-sub">빠르고 안전한<br>전자 결제 승인 프로세스를 경험하세요.</p>
                            <p class="img-box"><span class="screen-hidden"></span></p>
                        </a></li>
                        <li class="shortcut-list-item"><a href="notice">
                            <h3 class="txt-main">공지사항</h3>
                            <p class="txt-sub">최신 소식과 자료를<br>쉽게 공유하고 확인하세요.</p>
                            <p class="img-box"><span class="screen-hidden"></span></p>
                        </a></li>
                    </ul>
                </div>
            </div>

            <!-- 최근 소식 섹션 -->
            <div class="article recent-posts">
                <div class="container clearfix">
                    <div class="txt-box">
                        <span class="txt-sub2">최근 소식</span>
                        <h3 class="txt-main">공지사항 업데이트</h3>
                        <p class="txt-sub">트라이어드 솔루션의 최신 공지사항을 확인하세요.</p>
                        <span class="txt-sub3">최신 업데이트 정보가 없습니다.</span>
                    </div>
                    <div class="graphic-box clearfix">
                        <ul class="post-list">
                            <!-- 공지사항 목록은 Ajax로 로드 -->
                        </ul>
                    </div>
                </div>
            </div>

            <!-- 이용 절차 섹션 -->
            <div class="article info-step">
                <div class="container clearfix">
                    <div class="txt-box">
                        <span class="txt-sub2">트라이어드 솔루션</span>
                        <h3 class="txt-main">이용 절차</h3>
                        <p class="txt-sub">간단한 절차로<br>트라이어드 솔루션의 모든 서비스를<br>시작할 수 있습니다.</p>
                    </div>
                    <div class="graphic-box clearfix">
                        <div class="div-step">
                            <p class="step-txt">STEP<span class="step-num">01</span></p>
                            <p class="step-icon">
                                <img src="resources/images/icons8-로그인-50.png" alt="로그인 아이콘">
                            </p>
                            <p class="step-txt-sub">트라이어드 플랫폼에<br>로그인 및 계정 등록</p>
                        </div>
                        <div class="div-step">
                            <p class="step-txt">STEP<span class="step-num">02</span></p>
                            <p class="step-icon">
                                <img src="resources/images/icons8-서비스-50.png" alt="서비스 아이콘">
                            </p>
                            <p class="step-txt-sub">서비스 체험 및<br>기능 탐색</p>
                        </div>
                        <div class="div-step">
                            <p class="step-txt">STEP<span class="step-num">03</span></p>
                            <p class="step-icon">
                                <img src="resources/images/icons8-문서-서명-50.png" alt="계약 아이콘">
                            </p>
                            <p class="step-txt-sub">서비스 이용<br>계약 체결</p>
                        </div>
                        <div class="div-step">
                            <p class="step-txt">STEP<span class="step-num">04</span></p>
                            <p class="step-icon">
                                <img src="resources/images/icons8-적용-스킨-타입-7-48.png" alt="적용 아이콘">
                            </p>
                            <p class="step-txt-sub">운영 환경 적용 및<br>서비스 시작</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 회사 정보 섹션 -->
            <div class="article company-info">
                <div class="container clearfix">
                    <div class="txt-box">
                        <span class="txt-sub2">회사 정보</span>
                        <h3 class="txt-main">트라이어드 솔루션을 만나보세요</h3>
                        <p class="txt-sub">당신의 비즈니스 파트너, 트라이어드 솔루션의 위치를 확인하세요.</p>
                    </div>
                    <div class="graphic-box clearfix">
                        <div class="info-details">
                            <p><strong>회사명:</strong> 트라이어드 솔루션 주식회사</p>
                            <p><strong>주소:</strong> 서울특별시 강남구 테헤란로 123, 5층 (역삼동, 트라이어드 타워)</p>
                            <p><strong>전화번호:</strong> 02-9876-5432</p>
                            <p><strong>이메일:</strong> contact@triadsolutions.com</p>
                        </div>
                        <div class="map-container">
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3165.365763499896!2d127.0317673152096!3d37.49939597981169!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca3f0d2b0c5b7%3A0x7e8f2b1a3c4d5e6f!2z7ISc7Jq47Yq567OE7IucIOq4iOyKpO2EsO2BrOu2gCDthYztgqTsmrTsnbwgMTIz!5e0!3m2!1sko!2skr!4v1698779876543!5m2!1sko!2skr"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 푸터 -->
        <jsp:include page="/resources/jsp/Footer.jsp" />
    </div>
</body>
</html>