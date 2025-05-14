package com.ict.project.controller;

import java.io.File;
import java.io.IOException;
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
	private ManagerDAO managerDAO;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	/**
	 * 직원 등록 처리
	 */
	@GetMapping("/empDataRegister")
	public String registerEmployee(
			@ModelAttribute EmployeeVO employeeVO,
			@ModelAttribute UsersVO userVO,
			@ModelAttribute UsersignVO usersignVO,
			@ModelAttribute PersonnelChangeVO changeVO,
			@ModelAttribute RequestVO requestVO,
			@ModelAttribute PermissionVO permissionVO,
			@RequestParam(value = "profileImg", required = false) MultipartFile profileImg,
			RedirectAttributes redirectAttributes,
			HttpServletRequest request) throws Exception {
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
				picVO.setF_path("D:/workspaces/pj/project/src/main/webapp/resources/images/"
						+ fileName);
				picVO.setF_width(180); // 필요시 실제 크기로 대체
				picVO.setF_height(200);

				// 사진 DB 등록
				managerService.registerEmpPicture(employeeVO, picVO);
			}
			
			redirectAttributes.addFlashAttribute("message", "직원이 성공적으로 등록되었습니다.");
			return "/PersonnelManagement/EmpManagement/empDataList";
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", "직원 등록 중 오류가 발생했습니다.");
			return "/PersonnelManagement/EmpManagement/empDataRegister";
		}
	}

	/**
	 * 직원 등록 화면 이동
	 
	@GetMapping("/PersonnelManagement/EmpManagement/empDataRegister")
	public ModelAndView showRegisterForm() {
		return new ModelAndView("PersonnelManagement/EmpManagement/empDataRegister");
	}
*/
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

	//직원 상세조회
	@GetMapping("/PersonnelManagement/EmpManagement/empDataDetail")
	public ModelAndView getEmployeeDetail(@RequestParam("emp_idx") String emp_idx) {
	    
	    Map<String, Object> employeeData = managerService.getEmployeeById(emp_idx);
	    ModelAndView mv = new ModelAndView("/PersonnelManagement/EmpManagement/empDataDetail");
	    mv.addObject("employeeData", employeeData);
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
	
	
	// 직원 정보 업데이트
	@PostMapping("/PersonnelManagement/EmpManagement/empDataUpdate")
	public String updateEmployee(
	    @ModelAttribute EmployeeVO employeeVO,
	    @RequestParam Map<String, Object> param,
	    @ModelAttribute EmpPictureVO empPictureVO,
	   // @ModelAttribute PersonnelChangeVO personnelChangeVO,
	    @RequestParam(value = "profileImg", required = false) MultipartFile profileImg,
	    RedirectAttributes redirectAttributes
	) {
	    try {
	        // 1. employee, users, personnel_change 등 정보 수정
	        managerService.updateEmployee(employeeVO);
	        managerService.updateUser(param);
	      //  managerService.updatePersonnelChange(personnelChangeVO);
	        if ("관리자".equals(employeeVO.getDept_name()) || "슈퍼관리자".equals(employeeVO.getDept_name())) {
	        	// 권한이 "관리자" 또는 "슈퍼관리자"면 permission 테이블에 emp_idx 추가
	            managerService.addPermissionIfNotExists(employeeVO.getEmp_idx());
	        } else {
	            // 권한이 "직원" 등으로 변경되면 permission 테이블에서 emp_idx 제거
	            managerService.removePermission(employeeVO.getEmp_idx());
	        }
	        
	        
	        // 2. 사진이 업로드된 경우만 처리 (수정)
	        if (profileImg != null && !profileImg.isEmpty()) {
	            String fileName = UUID.randomUUID().toString() + "_" + profileImg.getOriginalFilename();
	            // 하드코딩된 실제 저장 경로 (운영 환경에 맞게 수정)
	            String uploadDir = "D:/workspaces/pj/project/src/main/webapp/resources/images/";
	            File dir = new File(uploadDir);
	            if (!dir.exists()) dir.mkdirs();
	            File destFile = new File(uploadDir + fileName);
	            profileImg.transferTo(destFile);

	            // EmpPictureVO 값 세팅
	            empPictureVO.setEmp_idx(employeeVO.getEmp_idx());
	            empPictureVO.setF_name(fileName);
	            empPictureVO.setF_path("D:/workspaces/pj/project/src/main/webapp/resources/images/" + fileName); // DB에는 웹 경로만 저장
	            empPictureVO.setF_width(180); // 필요시 실제 크기로 대체
	            empPictureVO.setF_height(200);

	            // 사진 DB "수정"
	            managerService.updateProfileImage(empPictureVO);
	        }
	        if (param.get("phone_number") == null || param.get("phone_number").toString().trim().isEmpty()) {
	            param.remove("phone_number");
	        }
	        
	        
	        redirectAttributes.addFlashAttribute("message", "직원 정보가 성공적으로 수정되었습니다.");
	    } catch (Exception e) {
	        e.printStackTrace();
	        redirectAttributes.addFlashAttribute("error", "직원 정보 수정 중 오류가 발생했습니다.");
	    }
	    return "PersonnelManagement/EmpManagement/empDataList";
	}

    /**
     * 권한 업데이트를 처리하는 메서드
     * @param changedPermissions 프론트엔드에서 전달받은 변경된 권한 정보
     *                          Map<String, Map<String, Boolean>> 형태
     *                          - 첫 번째 String: 사용자 ID (emp_idx)
     *                          - 두 번째 Map: 권한 타입과 값 (예: {"canAccessEmployee": true})
     * @return 업데이트 결과를 담은 Map 객체
     */
	
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
    public ModelAndView getResignGo() {
    	ModelAndView mv = new ModelAndView("PersonnelManagement/ResignManagement/resignDateList");
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
    	ModelAndView mv= new ModelAndView("PersonnelManagement/ResignManagement/resignDateList");
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

        ModelAndView mv = new ModelAndView("PersonnelManagement/ResignManagement/resignDateList");
        mv.addObject("employeeList", employeeList);

        return mv;
    }


}