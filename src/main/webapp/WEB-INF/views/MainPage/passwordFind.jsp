<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 - 3부상조</title>
<link href="<c:url value='/resources/css/Header.css' />" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css' />" rel="stylesheet">

<style>
/* 비밀번호 찾기 페이지 스타일 */
.forgot-container {
    display: flex;
    flex-direction: column; /* 폼이 수직으로 쌓이도록 */
    justify-content: center;
    align-items: center;
    min-height: calc(100vh - 120px);
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    padding: 20px;
}

.forgot-box {
    background: #fff;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 400px;
    text-align: center;
    margin-bottom: 20px; /* 폼 간 간격 */
}

.forgot-title {
    font-size: 28px;
    font-weight: 700;
    color: #333;
    margin-bottom: 10px;
}

.forgot-subtitle {
    font-size: 16px;
    color: #666;
    margin-bottom: 30px;
}

.input-group {
    margin-bottom: 20px;
    text-align: left;
}

.input-group label {
    display: block;
    font-size: 14px;
    color: #333;
    margin-bottom: 8px;
    font-weight: 500;
}

.input-group input {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    transition: border-color 0.3s;
}

.input-group input:focus {
    outline: none;
    border-color: #007bff;
}

.forgot-button {
    width: 100%;
    padding: 12px;
    background: #007bff;
    border: none;
    border-radius: 5px;
    color: #fff;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    transition: background 0.3s;
}

.forgot-button:hover {
    background: #0056b3;
}

.back-to-login {
    margin-top: 20px;
    font-size: 14px;
    color: #666;
}

.back-to-login a {
    color: #007bff;
    text-decoration: none;
}

.back-to-login a:hover {
    text-decoration: underline;
}

.error-message {
    color: #d32f2f;
    font-size: 14px;
    margin-top: 10px;
    text-align: left;
}
</style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/resources/jsp/Header.jsp" />

    <main>
        <section class="forgot-container">
            <div class="forgot-box">
                <h2 class="forgot-title">비밀번호 찾기</h2>
                <p class="forgot-subtitle">가입하신 이메일을 입력하세요.</p>
                <form id="forgotForm" action="<c:url value='/sendCode' />" method="post">
                    <div class="input-group">
                        <label for="email">이메일</label>
                        <input type="email" id="email" name="email" placeholder="이메일을 입력하세요" required>
                    </div>
                    <button type="submit" class="forgot-button" id="forgotButton">인증 코드 받기</button>
                    <div id="errorMessage" class="error-message" style="display: none;"></div>
                </form>
                <c:if test="${not empty emailError}">
                    <p class="error-message">${emailError}</p>
                </c:if>
                <div class="back-to-login">
                    <a href="<c:url value='/login' />">로그인 페이지로 돌아가기</a>
                </div>
            </div>
        </section>

        <!-- 인증 코드 입력 폼 -->
        <c:if test="${not empty verification}">
            <section class="forgot-container">
                <div class="forgot-box">
                    <h2 class="forgot-title">인증 코드 입력</h2>
                    <p class="forgot-subtitle">이메일로 발송된 인증 코드를 입력하세요.</p>
                    <form id="verificationForm" action="<c:url value='/verifyCode' />" method="post">
                        <div class="input-group">
                            <label for="verificationCode">인증 코드</label>
                            <input type="text" id="verificationCode" name="verificationCode" placeholder="인증 코드를 입력하세요" required autofocus>
                        </div>
                        <button type="submit" class="forgot-button" id="verifyButton">인증 코드 확인</button>
                    </form>
                    <c:if test="${not empty codeError}">
                        <p class="error-message">${codeError}</p>
                    </c:if>
                </div>
            </section>
        </c:if>
    </main>

    <!-- Footer -->
    <jsp:include page="/resources/jsp/Footer.jsp" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        // jQuery 로드 확인
        if (typeof jQuery === 'undefined') {
            console.error('jQuery is not loaded');
            alert('페이지 로드에 문제가 있습니다. 새로고침해 주세요.');
        } else {
            console.log('jQuery ' + jQuery.fn.jquery + ' loaded successfully');
        }

        // 이메일 입력 폼 제출 처리
        document.getElementById('forgotForm').addEventListener('submit', function(e) {
            e.preventDefault(); // 기본 폼 제출 방지
            const email = document.getElementById('email').value;
            if (!email) {
                alert('이메일을 입력해주세요.');
                return;
            }
            sendCode();
        });

        // 인증 코드 전송 함수
        function sendCode() {
            const url = "<c:url value='/sendCode' />";
            console.log("Sending request to: " + url);
            $("#forgotButton").prop("disabled", true).text("전송 중...");
            $("#errorMessage").hide().text("");
            $.post(url, { email: $("#email").val() }, function(response) {
                if (response === "success") {
                    alert("인증 코드가 전송되었습니다.");
                    $("#forgotButton").hide(); // 인증 코드 받기 버튼 숨김
                    // 인증 코드 입력 필드와 버튼 추가
                    const verificationInput = `
                        <div class="input-group">
                            <label for="verificationCode">인증 코드</label>
                            <input type="text" id="verificationCode" name="verificationCode" placeholder="인증 코드를 입력하세요" required autofocus>
                        </div>
                        <button type="button" class="forgot-button" id="verifyButton">인증 코드 확인</button>
                    `;
                    $("#forgotButton").after(verificationInput);
                    $("#verificationCode").focus();
                    // 인증 코드 확인 버튼 이벤트 리스너
                    $("#verifyButton").on("click", verifyCode);
                } else {
                    $("#errorMessage").text(response.startsWith("fail: ") ? response.substring(6) : "서버 오류입니다.").show();
                    alert("전송 실패: " + (response.startsWith("fail: ") ? response.substring(6) : "서버 오류입니다."));
                }
            }).fail(function(xhr, status, error) {
                console.error("AJAX error: ", xhr.status, status, error);
                $("#errorMessage").text("서버 오류: " + (xhr.status === 500 ? "서버 내부 오류가 발생했습니다. 관리자에게 문의하세요." : error)).show();
                alert("서버 오류: " + (xhr.status === 500 ? "서버 내부 오류가 발생했습니다. 관리자에게 문의하세요." : error));
            }).always(function() {
                if (response !== "success") {
                    $("#forgotButton").prop("disabled", false).text("인증 코드 받기");
                }
            });
        }

        // 인증 코드 확인 함수
        function verifyCode() {
            const url = "<c:url value='/verifyCode' />";
            console.log("Sending request to: " + url);
            $("#verifyButton").prop("disabled", true).text("확인 중...");
            $("#errorMessage").hide().text("");
            $.post(url, { code: $("#verificationCode").val() }, function(response) {
                let msg = {
                    match: "인증 성공",
                    mismatch: "코드가 일치하지 않습니다.",
                    expired: "인증 시간이 초과되었습니다.",
                    no_code: "인증 코드가 없습니다."
                };
                if (response === "match") {
                    alert(msg[response]);
                    window.location.href = "<c:url value='/passwordChange' />";
                } else {
                    $("#errorMessage").text(msg[response] || "오류: " + response).show();
                    alert(msg[response] || "오류: " + response);
                }
            }).fail(function(xhr, status, error) {
                console.error("AJAX error: ", xhr.status, status, error);
                $("#errorMessage").text("서버 오류: " + (xhr.status === 500 ? "서버 내부 오류가 발생했습니다. 관리자에게 문의하세요." : error)).show();
                alert("서버 오류: " + (xhr.status === 500 ? "서버 내부 오류가 발생했습니다. 관리자에게 문의하세요." : error));
            }).always(function() {
                $("#verifyButton").prop("disabled", false).text("인증 코드 확인");
            });
        }

        // 인증 코드 확인 (인증 폼이 표시될 때만 실행)
        <c:if test="${not empty verification}">
        document.getElementById('verificationForm').addEventListener('submit', function(e) {
            e.preventDefault();
            verifyCode();
        });
        </c:if>
    </script>
</body>
</html>