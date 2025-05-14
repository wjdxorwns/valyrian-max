<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
<style type="text/css">

</style>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<link href="<c:url value='/resources/css/KimYH/Qna.css'/>" rel="stylesheet">

<main>
<div class="content">
    <h2>질문 작성</h2>
    <form id="qnaForm" action="/qnaWriteOk" method="post">
        <div>
            <label for="question_title">제목</label>
            <input type="text" id="question_title" name="question_title" placeholder="질문 제목을 입력하세요" required>
        </div>
        <div>
            <label for="question_content">내용</label>
            <textarea id="question_details" name="question_details" placeholder="질문 내용을 입력하세요" required></textarea>
        </div>
        <div class="button-container">
            <button type="button" onclick="submitQna()">작성 완료</button>
            <button type="button" class="cancel-link" onclick="window.close();">취소</button>
        </div>
    </form>
</div>
</main>


<c:if test="${writeComplete eq true}">
<script>
    alert("QnA가 등록되었습니다.");
    window.opener.location.href = "/qna";
    window.close(); // 팝업 닫기
</script>
</c:if>

<script type="text/javascript">


function submitQna() {
    const title = document.getElementById("question_title").value.trim();
    const content = document.getElementById("question_details").value.trim();  // ✅ 바뀐 ID 사용

    if (title === "" || content === "") {
        alert("제목과 내용을 모두 입력해주세요.");
        return;
    }

    document.getElementById("qnaForm").submit(); 
}




</script>






</body>
</html>