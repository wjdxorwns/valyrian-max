package com.ict.project.service;

import java.util.Map;

import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.UsersVO;
// 작성자: 최성현
public interface NorService {
    // 이메일로 사용자 조회
    UsersVO getUserByEmail(String emp_email);

    // user_idx로 직원 조회
    EmployeeVO getEmployeeByUserIdx(int userIdx);
    
    //	한찬욱 -- user_idx를 이용하여 MyPage 정보 불러오기
	public Map<String, Object> getEmployeeInfor(String emp_idx);
	
	//	한찬욱 -- MyPage에서 Update로 넘어갈 때 empCode를 가지고 Update 화면에서 정보 불러오기
	/*
	 * public UsersVO getUserInfor(int user_idx);
	 */
	
	
}
