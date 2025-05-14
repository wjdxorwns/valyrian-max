package com.ict.project.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List; // List import 추가
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
public class ManagerController {

	@Autowired
	private ManagerService managerService;

	@Autowired
	private ManagerDAO managerDAO;


	/**
	 * 직원 등록 처리
	 */
	@PostMapping("/empDataRegister")
	public ModelAndView registerEmployee(EmployeeVO employee, UsersVO user, UsersignVO usersign,
			PersonnelChangeVO change, @RequestParam(value = "profileImg", required = false) MultipartFile profileImg,
			RedirectAttributes redirectAttributes) {
		ModelAndView mv = new ModelAndView("redirect:/empDataList"); 
		try {
			// 직원 및 사용자 관련 등록
			managerService.registerEmployee(employee, user, usersign, change);

			// 사진이 업로드되었을 경우만 처리
			if (profileImg != null && !profileImg.isEmpty()) {
				String fileName = UUID.randomUUID().toString() + "_" + profileImg.getOriginalFilename();
				// 경로에 실제 물리적 경로를 사용하거나, WAS의 배포 경로를 사용해야 합니다.
				// 현재 D 드라이브로 지정된 경로는 개발 환경에 따라 변경될 수 있습니다.
				// 운영 환경에서는 상대 경로 또는 설정 파일을 통해 관리하는 것이 좋습니다.
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
			// 오류 발생 시, 다시 등록 폼으로 이동
			mv.setViewName("/empDataRegister");
		}
		return mv;
	}

	/**
	 * 직원 목록 조회
	 */
	@GetMapping("/empDataList")
	public ModelAndView getEmployeeList(
			@RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "keyword", required = false) String keyword) {
		ModelAndView mv = new ModelAndView("PersonnelManagement/EmpManagement/empDataList");
		try {
			// 서비스 호출 변경: Map 리스트를 받도록
			mv.addObject("employeeList", managerService.getAllEmployees(searchType, keyword));
			// 검색 파라미터도 모델에 추가하여 JSP에서 검색어 유지
			mv.addObject("param", Map.of(
                "searchType", searchType != null ? searchType : "",
                "keyword", keyword != null ? keyword : ""
            ));

		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("error", "직원 목록 조회 중 오류가 발생했습니다.");
		}
		return mv;
	}

	/**
	 * 직원 등록 화면 이동
	 */
	@GetMapping("/empDataRegister")
    public ModelAndView showRegisterForm() {
        return new ModelAndView("PersonnelManagement/EmpManagement/empDataRegister");
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
	
	// Permission 페이지 호출과 동시에 리스트 보여주기
    @GetMapping("/Permission")
    public ModelAndView goToThePermissionAndView(
            HttpSession session,
            HttpServletResponse response) throws IOException {
    	
    	String emp_idx = (String) session.getAttribute("emp_idx");
        session.setAttribute("emp_idx", emp_idx);
        ModelAndView mv = new ModelAndView("Permission/permission");

        try {
            List<Map<String, String>> userList = managerService.getAllPermissionList();
            if (userList != null && !userList.isEmpty()) {
                mv.addObject("userList", userList);
            } else {
                mv.addObject("userList", null);
            }

        } catch (Exception e) {
            e.printStackTrace();
            mv.setViewName("error");
        }

        return mv;
    }

    /**
     * 권한 업데이트를 처리하는 메서드
     * @param changedPermissions 프론트엔드에서 전달받은 변경된 권한 정보
     *                          Map<String, Map<String, Boolean>> 형태
     *                          - 첫 번째 String: 사용자 ID (emp_idx)
     *                          - 두 번째 Map: 권한 타입과 값 (예: {"canAccessEmployee": true})
     * @return 업데이트 결과를 담은 Map 객체
     */
    @PostMapping("/updatePermissions")
    @ResponseBody
    public Map<String, Object> updatePermissions(@RequestBody Map<String, Map<String, Boolean>> changedPermissions) {
        Map<String, Object> result = new HashMap<>();
        try {
            for (String userId : changedPermissions.keySet()) {
                Map<String, Boolean> permissions = changedPermissions.get(userId);
                Map<String, Integer> intPermissions = new HashMap<>();
                
                // 모든 권한 타입에 대해 기본값 0 설정
                intPermissions.put("can_access_employee", 0);
                intPermissions.put("can_access_worktype", 0);
                intPermissions.put("can_access_personnel", 0);
                intPermissions.put("can_access_salary", 0);
                intPermissions.put("can_access_vacation", 0);
                
                // 변경된 권한만 업데이트
                for (Map.Entry<String, Boolean> entry : permissions.entrySet()) {
                    String key = entry.getKey();
                    String dbColumn;
                    
                    switch (key) {
                        case "canAccessEmployee":
                            dbColumn = "can_access_employee";
                            break;
                        case "canAccessWorktype":
                            dbColumn = "can_access_worktype";
                            break;
                        case "canAccessPersonnel":
                            dbColumn = "can_access_personnel";
                            break;
                        case "canAccessSalary":
                            dbColumn = "can_access_salary";
                            break;
                        case "canAccessVacation":
                            dbColumn = "can_access_vacation";
                            break;
                        default:
                            dbColumn = key;
                    }
                    intPermissions.put(dbColumn, entry.getValue() ? 1 : 0);
                }
                managerService.updatePermissions(userId, intPermissions);
            }
            result.put("status", "success");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "error");
            result.put("message", e.getMessage());
        }
        return result;
    }

}