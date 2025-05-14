<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container_left">
    <!-- 사진과 옆내용 -->
    <div class="infor_table">
        <!-- 사진 -->				
        <div class="profile_image" style="border: solid 1px black; width: 299px; height: 300px;">
            <img style="" src="/images/profile/${eVO.f_name}.jpg">
        </div>
        <!-- 직원이름, 이메일, 휴대전화번호, 부서명, 직책, 호봉 -->
        <div>
            <div class="set">
                <div class="info_title">이름</div>
                <div>
                    <input type="text" class="box1" value="${eVO.emp_name}" readonly />
                </div>
            </div>
            
            <div class="set">
                <div class="info_title">이메일</div>
                <div>
                    <input type="text" class="box1" value="${eVO.emp_email}" readonly />
                </div>
            </div>
            
            <div class="set">		
                <div class="info_title">전화번호</div>
                <div><input type="text" class="box1" value="${eVO.phone_number}" readonly /></div>
            </div>

            <div class="set">		
                <div class="info_title">부서명</div>
                <div><input type="text" class="box1" value="${eVO.team}" readonly /></div>
            </div>							

            <div class="set">		
                <div class="info_title">직책</div>
                <div><input type="text" class="box1" value="${eVO.position}" readonly /></div>
            </div>							

            <div class="set">		
                <div class="info_title">호봉</div>
                <div><input type="text" class="box1" value="${eVO.pay_grade}" readonly /></div>
            </div>
        </div>					
    </div>
    <!-- 사진 아랫내용 -->
    <div>
        <div class="und_table">
            <div class="set">
                <div class="info_title">입사일</div>
                <div><input type="text" class="box2" value="${eVO.hire_date}" readonly /></div>
            </div>
            <div class="set">
                <div class="info_title">잔여 연차</div>
                <div><input type="text" class="box2" value="${eVO.vacation_day}" readonly /></div>
            </div>
        </div>
        <div>
            <div class="und_table">
                <div class="set">
                    <div class="info_title">직원코드</div>
                    <div>
                        <input type="text" class="box2" value="${eVO.emp_idx}" readonly />
                    </div>
                </div>
                <div class="set">
                    <div class="info_title">성별</div>
                    <div>
                        <input type="text" class="box2" value="${eVO.gender}" readonly />
                    </div>
                </div>			
            </div>
            <div class="set">
                <div class="info_title">주소</div>
                <div><input type="text" class="box3" value="${eVO.home}" readonly /></div>
            </div>
            <div class="set">		
                <div class="info_title">상세주소</div>
                <div>
                    <input type="text" class="box3" value="${eVO.detail_home}" readonly />
                </div>
            </div>		
        </div>	
    </div>		
</div> 