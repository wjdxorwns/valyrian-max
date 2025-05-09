<!-- 작성자: 한찬욱 | 기여자: 김재겸-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3부상조 - 어드민 직원에게 급여 지급</title>
<link href="<c:url value='/resources/css/HanCW/CSS_admin_pay_detail_update.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/JeoungTJ/Main.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Header.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/Footer.css'/>" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <main style="margin: 80px auto auto;">
        <jsp:include page="/resources/jsp/PayAside.jsp" />
        <jsp:include page="/resources/jsp/Header.jsp" />
        <div style="margin-top: 30px;">
            <h2>직원 급여 지급</h2>
            <h4>직원에게 급여를 책정합니다.</h4>
        </div>
        <div class="container">
            <div class="container1">
                <div class="infor_table">
                    <div class="profile_image">
                        <img src='<c:url value="/resources/images/18ceebb0bfd4c2da7.jpg" />' alt="프로필 이미지">
                    </div>
                    <div>
                        <div class="set">
                            <div class="info_title">이름</div>
                            <div>
                                <input type="text" class="box1" value="${not empty user.emp_name ? user.emp_name : '-'}" disabled/>
                            </div>
                        </div>
                        <div class="set">
                            <div class="info_title">이메일</div>
                            <div>
                                <input type="text" class="box1" value="${not empty user.emp_email ? user.emp_email : '-'}" disabled/>
                            </div>
                        </div>
                        <div class="set">
                            <div class="info_title">전화번호</div>
                            <div>
                                <input type="text" class="box1" value="${not empty user.phone_number ? user.phone_number : '-'}" disabled/>
                            </div>
                        </div>
                        <div class="set">
                            <div class="info_title">부서명</div>
                            <div>
                                <input type="text" class="box1" value="${not empty user.team ? user.team : '-'}" disabled/>
                            </div>
                        </div>
                        <div class="set">
                            <div class="info_title">직책</div>
                            <div>
                                <input type="text" class="box1" value="${not empty user.position ? user.position : '-'}" disabled/>
                            </div>
                        </div>
                        <div class="set">
                            <div class="info_title">호봉</div>
                            <div>
                                <input type="text" class="box1" value="${not empty user.pay_grade ? user.pay_grade : '-'}" disabled/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="under_table">
                    <div class="und_table">
                        <div class="set">
                            <div class="info_title">입사일</div>
                            <div>
                                <input type="text" class="box2" value="${not empty user.hire_date ? user.hire_date : '-'}" disabled/>
                            </div>
                        </div>
                        <div class="set">
                            <div class="info_title">성별</div>
                            <div>
                                <input type="text" class="box2" value="${not empty user.gender ? user.gender : '-'}" disabled/>
                            </div>
                        </div>
                    </div>
                    <div class="und_table">
                        <div class="set">
                            <div class="info_title">직원코드</div>
                            <div>
                                <input type="text" class="box2" name="emp_idx" value="${not empty user.emp_idx ? user.emp_idx : '-'}" disabled/>
                            </div>
                        </div>
                        <div class="set">
                            <div class="info_title">급여</div>
                            <div>
                                <input type="text" class="box2" value="${not empty user.pay ? user.pay : '-'}" disabled/>
                            </div>
                        </div>
                    </div>
                    <div class="set">
                        <div class="info_title">주소</div>
                        <div>
                            <input type="text" class="box3" value="${not empty user.home ? user.home : '-'}" disabled/>
                        </div>
                    </div>
                    <div class="set">
                        <div class="info_title">상세주소</div>
                        <div>
                            <input type="text" class="box3" value="${not empty user.detail_home ? user.detail_home : '-'}" disabled/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container2">
                <br><br><br><br><br><br><br><br><br><br><br><br><br>
                <form id="payForm" action="/admin_Pay_Update_Ok" method="post">
                    <div class="pay">
                        <div>기본급 : </div>
                        <div class="choice">
                            <input class="in" type="number" name="base_salary" min="0">
                            <button class="button3" type="button" onclick="calculateRealPay()">계산</button>
                        </div>
                    </div>
                    <div class="bonus" style="display:flex; align-items: baseline;">
                        <div>보너스 : </div>
                        <div class="choice">
                            <input class="in" type="number" name="bonus" min="0">
                        </div>
                    </div>
                    <div class="tex">
                        <div>세금</div>
                        <div>
                            <label for="percentage" class="choice">퍼센트 선택:</label>
                            <select class="percentage" name="taxRate" id="taxRate">
                                <option value="1">1%</option>
                                <option value="2">2%</option>
                                <option value="3">3%</option>
                            </select>
                        </div>
                    </div>
                    <div class="payment_date">
                        <div>지급일 : </div>
                        <div class="choice">
                            <input class="in" type="date" name="payment_date" required>
                        </div>
                    </div>
                    <div class="real_pay">실수령 금액</div>
                    기본급 - (세금×기본급) + 보너스 = 실수령 금액
                    <div>
                        <input class="pay_box" type="text" name="realPay" readonly>
                    </div>
                    <input type="hidden" name="emp_idx" value="${user.emp_idx}">
                    <div>
                        <input type="button" class="button2" value="저장하기" onclick="adminPayDetailUpdateOk()">
                        <input type="button" class="button2" value="돌아가기" onclick="history.back()">
                    </div>
                </form>
            </div>
        </div>
    </main>
    <jsp:include page="/resources/jsp/Footer.jsp" />
    <script type="text/javascript">
        function calculateRealPay() {
            const salaryInput = document.querySelector('input[name="base_salary"]').value;
            const salary = parseFloat(salaryInput) || 0;
            const taxRateSelect = document.querySelector(".percentage").value;
            const taxRate = parseFloat(taxRateSelect) / 100 || 0;
            const taxAmount = salary * taxRate;
            const bonusInput = document.querySelector('input[name="bonus"]').value;
            const bonus = parseFloat(bonusInput) || 0;
            const realPay = salary - taxAmount + bonus;
            const realPayInput = document.querySelector(".pay_box");
            realPayInput.value = realPay.toFixed(0);
            console.log("Calculated real pay: " + realPay);
        }

        function adminPayDetailUpdateOk() {
            const baseSalary = parseFloat(document.querySelector('input[name="base_salary"]').value) || 0;
            const bonus = parseFloat(document.querySelector('input[name="bonus"]').value) || 0;
            const paymentDate = document.querySelector('input[name="payment_date"]').value;
            const taxRate = document.querySelector('select[name="taxRate"]').value;
            const emp_idx = document.querySelector('input[name="emp_idx"]').value;

            if (baseSalary <= 0) {
                alert("기본급을 숫자로 입력하세요.");
                return;
            }
            if (!paymentDate) {
                alert("지급일을 선택하세요.");
                return;
            }
            if (!taxRate) {
                alert("세율을 선택하세요.");
                return;
            }
            if (!emp_idx) {
                alert("직원 코드가 없습니다.");
                return;
            }

            // 폼 제출
            document.getElementById("payForm").submit();
        }

        document.addEventListener("DOMContentLoaded", function () {
            const calcButton = document.querySelector(".button3");
            if (calcButton) {
                calcButton.addEventListener("click", calculateRealPay);
            }
        });
    </script>
</body>
</html>