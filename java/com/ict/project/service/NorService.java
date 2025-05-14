package com.ict.project.service;

import java.util.Map;

import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.UsersVO;

public interface NorService {
    // 이메일로 사용자 조회
    UsersVO getUserByEmail(String emp_email);

    // user_idx로 직원 조회
    EmployeeVO getEmployeeByUserIdx(int userIdx);
    
    //	한찬욱 -- user_idx를 이용하여 MyPage 정보 불러오기
   	public Map<String, Object> getEmployeeInfor(String emp_idx);
   	
   	//	한찬욱 -- MyPageUpdate에서 DB로 Password 보내기	화면단에 무언가를 보여지는게 아니라 저장하는 것이라서 public void로 지정
       public void updatePassword(int userIdx, String encryptedPassword);
       
       //	한찬욱 -- MyPageUpdate에서 DB로 싸인 보내기
       public void updateSignature(int userIdx, String signatureData);

}
