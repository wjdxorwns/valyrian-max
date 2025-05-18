package com.ict.project.service;

import java.util.Map;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.NorDAO;
import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.UsersVO;

@Service
public class NorServiceImpl implements NorService {

    @Autowired
    private NorDAO norDAO;

    @Override
    public UsersVO getUserByEmail(String emp_email) {
        return norDAO.getUserByEmail(emp_email);
    }

    @Override
    public EmployeeVO getEmployeeByUserIdx(int userIdx) {
        return norDAO.getEmployeeByUserIdx(userIdx);
    }
    
  	//	한찬욱 -- user_idx를 이용하여 MyPage 정보 불러오기  
    @Override
    public Map<String, Object> getEmployeeInfor(String emp_idx) {
    	return norDAO.getEmployeeInfor(emp_idx);
    }

	//	한찬욱 -- 사인 이미지 가져오기
	@Override
	public String getSignature(int user_idx) {
		return norDAO.getSignature(user_idx);
	}

	//	한찬욱 -- MyPageUpdate에서 DB로 Password 보내기	화면단에 무언가를 보여지는게 아니라 저장하는 것이라서 public void로 지정
	@Override
	public void updatePassword(int userIdx, String encryptedPassword) {
		norDAO.updatePassword(userIdx, encryptedPassword);	
	}

    //	한찬욱 -- MyPageUpdate에서 DB로 싸인 보내기
	@Override
	public void updateSignature(int userIdx, String signatureBase64Data) {
		// 1. Base64 데이터에서 순수 데이터 부분 추출 (앞의 "data:image/png;base64," 부분 제거)
		String pureBase64Data;
		if (signatureBase64Data == null || signatureBase64Data.isEmpty()) {
			// 서명이 비어있는 경우 (예: 사용자가 서명을 지웠을 때) 처리
			// DB에서 해당 사용자의 서명 정보를 삭제하거나, 특정 값으로 업데이트 할 수 있습니다.
			// 여기서는 간단히 빈 문자열로 파일명/경로를 설정하거나, 아예 DB 업데이트를 안 할 수도 있습니다.
			// 예시: norDAO.deleteSignature(userIdx); 또는 아래처럼 빈 값으로 업데이트
			// pureBase64Data = ""; // 또는 여기서 로직 종료
			// 이 부분은 정책에 따라 결정해야 합니다. 여기서는 서명이 있다면 저장하는 것으로 가정.
			// 만약 빈 서명도 업데이트(삭제)해야 한다면, 아래 파일 저장 로직을 건너뛰고
			// DAO 호출 시 빈 파일명/경로를 전달하거나, 별도의 delete DAO 메소드를 호출합니다.
			 Map<String, Object> params = new HashMap<>();
			 params.put("userIdx", userIdx);
			 params.put("signatureFileName", ""); // 빈 서명일 경우 파일명
			 params.put("signatureFilePath", ""); // 빈 서명일 경우 파일 경로
			 norDAO.updateSignature(params); // DAO는 이 빈 값들을 처리할 수 있어야 함 (예: NULL로 저장)
			 return; // 빈 서명이면 여기서 종료
		}

		if (signatureBase64Data.startsWith("data:image/png;base64,")) {
			pureBase64Data = signatureBase64Data.substring("data:image/png;base64,".length());
		} else {
			// 예기치 않은 형식의 데이터일 경우 에러 처리 또는 로깅
			// throw new IllegalArgumentException("Invalid base64 signature format");
			// 여기서는 일단 그대로 진행한다고 가정 (하지만 실제로는 형식 체크 중요)
			pureBase64Data = signatureBase64Data;
		}

		// 2. 파일명 및 경로 설정
		// 실제 운영 환경에서는 이 경로를 설정 파일 등에서 읽어오는 것이 좋습니다.
		String uploadDirectory = "C:\\workspaces\\pj\\project\\src\\main\\webapp\\resources\\images\\signature_uploads\\";
		
		// 디렉토리가 없으면 생성
		File directory = new File(uploadDirectory);
		if (!directory.exists()) {
			directory.mkdirs(); // 중간 경로까지 모두 생성
		}

		String fileName = userIdx + "_" + System.currentTimeMillis() + ".png";
		String fullFilePath = uploadDirectory + fileName;
		String dbFilePath = "/resources/images/signature_uploads/" + fileName; // DB에 저장할 상대 경로 (웹에서 접근 가능하도록)

		// 3. Base64 데이터를 byte[]로 디코딩하여 파일로 저장
		try {
			byte[] imageBytes = Base64.getDecoder().decode(pureBase64Data); // Java 8+
			// byte[] imageBytes = DatatypeConverter.parseBase64Binary(pureBase64Data); // Java 7 이전
			
			try (FileOutputStream fos = new FileOutputStream(fullFilePath)) {
				fos.write(imageBytes);
			}
			System.out.println("서명 파일 저장 성공: " + fullFilePath); // 테스트용 로그

		} catch (IOException e) {
			e.printStackTrace();
			// 파일 저장 실패 시 예외 처리 (예: 로깅 후 사용자 정의 예외 발생)
			throw new RuntimeException("서명 파일 저장 중 오류 발생", e);
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
			// Base64 디코딩 실패 시 (잘못된 형식의 데이터)
			throw new RuntimeException("잘못된 형식의 서명 데이터입니다.", e);
		}

		// 4. DB에 저장할 정보 Map에 담기
		Map<String, Object> params = new HashMap<>();
		params.put("userIdx", userIdx);
		params.put("signatureFileName", fileName);       // 생성된 파일명
		params.put("signatureFilePath", dbFilePath);     // DB에 저장할 (상대)경로
		
		// 5. DAO 호출하여 DB 업데이트
		norDAO.updateSignature(params); // norDAO는 해당 매퍼를 호출하는 인터페이스/클래스
	}
  
}
