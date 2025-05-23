package com.ict.project.controller;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List; // List import 추가
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.project.repository.ManagerDAO;
import com.ict.project.service.ManagerService;
import com.ict.project.vo.management.PermissionVO;
import com.ict.project.vo.management.RequestVO;
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
	private BCryptPasswordEncoder passwordEncoder;
	
	/**
	 * 직원 등록 처리
	 */
	@PostMapping("/empDataRegister")
	public String registerEmployee(@ModelAttribute EmployeeVO employeeVO, @ModelAttribute UsersVO userVO,
			@ModelAttribute UsersignVO usersignVO, @ModelAttribute PersonnelChangeVO changeVO,
			@ModelAttribute RequestVO requestVO, @ModelAttribute PermissionVO permissionVO,
			@RequestParam(value = "profileImg", required = false) MultipartFile profileImg,
			RedirectAttributes redirectAttributes, HttpServletRequest request, HttpSession session) throws Exception {
		String emp_idx = (String)session.getAttribute("emp_idx");
		try {
			// 직원 등록 처리
			String rawPassword = userVO.getEmp_password();
			String encPassword = passwordEncoder.encode(userVO.getEmp_password());
			userVO.setEmp_password(encPassword);

			managerService.registerEmployee(employeeVO, userVO, usersignVO, changeVO, requestVO, permissionVO);
		

			/// 사진이 업로드되었을 경우만 처리
			if (profileImg != null && !profileImg.isEmpty()) {
				String fileName = UUID.randomUUID().toString() + "_" + profileImg.getOriginalFilename();
				String savePath = "D:/workspaces/pj/project/src/main/webapp/resources/images/" + fileName;

				// 실제 파일 저장
				profileImg.transferTo(new File(savePath));

				// VO 객체 생성 및 값 설정
				EmpPictureVO picVO = new EmpPictureVO();
				picVO.setEmp_idx(employeeVO.getEmp_idx());
				picVO.setF_name(fileName);
				picVO.setF_path("D:/workspaces/pj/project/src/main/webapp/resources/images/" + fileName);
				picVO.setF_width(180); // 필요시 실제 크기로 대체
				picVO.setF_height(200);

				// 사진 DB 등록
				managerService.registerEmpPicture(employeeVO, picVO);
			}
			
			redirectAttributes.addFlashAttribute("message", "직원이 성공적으로 등록되었습니다.");
			return "redirect:/empDataList?emp_idx=" + emp_idx;
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", "직원 등록 중 오류가 발생했습니다.");
			return "redirect:/empDataRegister?emp_idx=" + emp_idx;
		}
	}

	@GetMapping("/empDataRegister")
	public ModelAndView showRegisterForm(HttpSession session) {
		String emp_idx = (String) session.getAttribute("emp_idx");
		session.setAttribute("emp_idx", emp_idx);
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
	
	// 직원 상세 조회
	@GetMapping("/empDataDetail")
	@ResponseBody
	public Map<String, Object> getEmployeeDetail(@RequestParam("emp_idx") String empIdx) {
		
		return managerService.getEmployeeDetail(empIdx);
	}

	// 변경된 직원 정보를 DB로 보내서 수정
	@PostMapping("/empDataUpdate")
	public String updateEmployee(@RequestParam Map<String, Object> paramMap, RedirectAttributes redirectAttributes) {
		// employeeVO에 폼의 모든 값이 자동으로 매핑됨
		managerService.updateEmployee(paramMap);
		redirectAttributes.addFlashAttribute("message", "수정이 완료되었습니다.");
		return "redirect:/empDataList";
	}
	
	
	@GetMapping("/Permission")
	public ModelAndView goToThePermissionAndView(HttpSession session, HttpServletResponse response) throws IOException {

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
	 * 
	 * @param changedPermissions 프론트엔드에서 전달받은 변경된 권한 정보 Map<String, Map<String,
	 *                           Boolean>> 형태 - 첫 번째 String: 사용자 ID (emp_idx) - 두 번째
	 *                           Map: 권한 타입과 값 (예: {"canAccessEmployee": true})
	 * @return 업데이트 결과를 담은 Map 객체
	 */
	@PostMapping("/updatePermissions")
	@ResponseBody
	public Map<String, Object> updatePermissions(@RequestBody Map<String, Map<String, Boolean>> changedPermissions) {
	    Map<String, Object> result = new HashMap<>();

	    try {
	        for (String userId : changedPermissions.keySet()) {
	            Map<String, Boolean> newPermissions = changedPermissions.get(userId);
	            Map<String, Integer> dbPermissions = managerService.getPermissions(userId); // 기존 값 가져오기

	            // 기존 권한 기반으로 수정되지 않은 항목은 유지
	            for (String key : Arrays.asList(
	                    "can_access_employee", "can_access_worktype", "can_access_personnel",
	                    "can_access_salary", "can_access_vacation")) {
	                
	                // 프론트에서 온 값이 있으면 덮어씌우기
	                String logicalKey = convertToLogicalKey(key); // 예: can_access_employee → canAccessEmployee
	                if (newPermissions.containsKey(logicalKey)) {
	                    dbPermissions.put(key, newPermissions.get(logicalKey) ? 1 : 0);
	                }
	            }

	            managerService.updatePermissions(userId, dbPermissions);
	        }
	        result.put("status", "success");
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("status", "error");
	        result.put("message", e.getMessage());
	    }

	    return result;
	}

	// key 변환용 헬퍼
	private String convertToLogicalKey(String dbKey) {
	    switch (dbKey) {
	        case "can_access_employee": return "canAccessEmployee";
	        case "can_access_worktype": return "canAccessWorktype";
	        case "can_access_personnel": return "canAccessPersonnel";
	        case "can_access_salary": return "canAccessSalary";
	        case "can_access_vacation": return "canAccessVacation";
	        default: return dbKey;
	    }
	}
    
	// 직원의 전자결제 시스템으로 넘어가기
	@GetMapping("/PermissionRequest")
	public ModelAndView goToTheElectronicPaymentAndView(HttpSession session, HttpServletResponse response)
			throws IOException {

		String emp_idx = (String) session.getAttribute("emp_idx");
		session.setAttribute("emp_idx", emp_idx);
		ModelAndView mv = new ModelAndView("Permission/permissionRequest");
		return mv;
	}

    
    @GetMapping("/hrManagement")
    public ModelAndView getResignGo(HttpSession session) {
    	String emp_idx = (String) session.getAttribute("emp_idx");
    	ModelAndView mv = new ModelAndView("PersonnelManagement/ResignManagement/resignDataList");
        List<Map<String, Object>> employeeList = managerService.getSearchResign();
        
        
        if (employeeList != null) {
            for (Map<String, Object> emp : employeeList) {
                Object genderObj = emp.get("gender");
                if (genderObj != null) {
                    String genderCode = genderObj.toString();
                    if ("0".equals(genderCode)) {
                        emp.put("gender", "남자");
                    } else if ("1".equals(genderCode)) 	{
                        emp.put("gender", "여자");
                    } else {
                        emp.put("gender", "-");
                    }
                }
            }
        }
        

        mv.addObject("employeeList", employeeList);
        
    	return mv;
    }
    
    @GetMapping("/resignedEmployees")
    public ModelAndView getresignedEmployees(@RequestParam("searchType") String searchType,
    										 @RequestParam("keyword") String keyword) {
    	ModelAndView mv= new ModelAndView("PersonnelManagement/ResignManagement/resignDataList");
    	Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("searchType", searchType);
        paramMap.put("keyword",keyword);
    	
    	
    	 List<Map<String, Object>> employeeList = managerService.getSearchKeyWord(paramMap);

    	 mv.addObject("employeeList", employeeList);
     return mv;
    }
    
    @PostMapping("/updateQuitter")
    public ModelAndView updateQuitterStatus(@RequestParam("emp_id") List<String> emp_id,
                                            @RequestParam("quitter") List<String> quitter) {
       
        for (int i = 0; i < emp_id.size(); i++) {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("emp_id", emp_id.get(i));
            paramMap.put("quitter", quitter.get(i));
            managerService.updateQuitter(paramMap);
            managerService.updateUserRemove(paramMap);
        }

        List<Map<String, Object>> employeeList = managerService.getSearchResign();

        ModelAndView mv = new ModelAndView("PersonnelManagement/ResignManagement/resignDataList");
        mv.addObject("employeeList", employeeList);

        return mv;
    }


}