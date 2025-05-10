// 작성자 : 김기섭(empDataRegister),
package com.ict.project.controller;


import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.project.repository.ManagerDAO;
import com.ict.project.service.ManagerService;
import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.PersonnelChangeVO;
import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.vo.personnel.pFile.EmpPictureVO;
import com.ict.project.vo.personnel.pFile.UsersignVO;

@Controller
@RequestMapping("/manager")
public class ManagerController {

	@Autowired
	private ManagerService managerService;

	@Autowired
	private ManagerDAO managerDAO;

	/**
	 * 직원 등록 처리
	 */
	@PostMapping("/PersonnelManagement/EmpManagement/empDataRegister")
	public ModelAndView registerEmployee(EmployeeVO employee, UsersVO user, UsersignVO usersign,
			PersonnelChangeVO change, @RequestParam(value = "profileImg", required = false) MultipartFile profileImg,
			RedirectAttributes redirectAttributes) {
		ModelAndView mv = new ModelAndView("redirect:/PersonnelManagement/EmpManagement/empDataList");
		try {
			// 직원 및 사용자 관련 등록
			managerService.registerEmployee(employee, user, usersign, change);

			// 사진이 업로드되었을 경우만 처리
			if (profileImg != null && !profileImg.isEmpty()) {
				String fileName = UUID.randomUUID().toString() + "_" + profileImg.getOriginalFilename();
				String savePath = "D:\\workspaces\\pj\\project\\src\\main\\webapp\\resources\\images\\" + fileName;

				// 실제 파일 저장
				profileImg.transferTo(new File(savePath));

				// VO 객체 생성 및 값 설정
				EmpPictureVO picVO = new EmpPictureVO();
				picVO.setEmp_idx(employee.getEmp_idx());
				picVO.setF_name(fileName);
				picVO.setF_path("D:\\\\workspaces\\\\pj\\\\project\\\\src\\\\main\\\\webapp\\\\resources\\\\images\\\\"
						+ fileName);
			//	picVO.setF_width(); // 필요시 실제 크기로 대체
			//	picVO.setF_height();

				// 사진 DB 등록
				managerService.registerEmpPicture(employee, picVO);
			}

			redirectAttributes.addFlashAttribute("message", "직원 등록이 완료되었습니다.");

		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", "직원 등록 중 오류가 발생했습니다: " + e.getMessage());
			mv.setViewName("/views/PersonnelManagement/EmpManagement/empDataRegister");
		}
		return mv;
	}

	/**
	 * 직원 목록 조회
	 */
	@GetMapping("/PersonnelManagement/EmpManagement/empDataList")
	public ModelAndView getEmployeeList() {
		ModelAndView mv = new ModelAndView("views/PersonnelManagement/EmpManagement/empDataList");
		try {
			mv.addObject("empList", managerService.getAllEmployees());
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("error", "직원 목록 조회 중 오류가 발생했습니다.");
		}
		return mv;
	}

	/**
	 * 직원 등록 화면 이동
	 */
	@GetMapping("/PersonnelManagement/EmpManagement/empDataRegister")
	public ModelAndView showRegisterForm() {
		return new ModelAndView("views/PersonnelManagement/EmpManagement/empDataRegister");
	}

	@GetMapping("/checkDuplicate")
	@ResponseBody
	public Map<String, Object> checkDuplicate(
			@RequestParam("field") String field,
			@RequestParam("value") String value) {
		
		Map<String, Object> result = new HashMap<>();
		boolean isDuplicate = false;
		String errorMessage = null;

		try {
			switch (field) {
				case "emp_email":
					// 이메일 형식 검증
					if (!isValidEmail(value)) {
						errorMessage = "올바른 이메일 형식이 아닙니다.";
					} else {
						isDuplicate = managerService.checkEmailDuplicate(value) > 0;
					}
					break;
					
				case "phone_number":
					// 전화번호 형식 검증
					if (!isValidPhoneNumber(value)) {
						errorMessage = "올바른 전화번호 형식이 아닙니다.";
					} else {
						isDuplicate = managerService.checkPhoneDuplicate(value) > 0;
					}
					break;
					
				default:
					errorMessage = "잘못된 필드명입니다.";
			}
		} catch (Exception e) {
			errorMessage = "중복확인 중 오류가 발생했습니다.";
		}

		result.put("duplicate", isDuplicate);
		if (errorMessage != null) {
			result.put("error", errorMessage);
		}
		
		return result;
	}

	private boolean isValidEmail(String email) {
		String emailRegex = "^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
		return email != null && email.matches(emailRegex);
	}

	private boolean isValidPhoneNumber(String phone) {
		String phoneRegex = "^01[0-9]-\\d{4}-\\d{4}$";
		return phone != null && phone.matches(phoneRegex);
	}
}