package com.ict.project.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.repository.ManagerDAO;
import com.ict.project.service.ManagerService;
import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.PersonnelChangeVO;
import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.vo.personnel.pFile.EmpPictureVO;
import com.ict.project.vo.personnel.pFile.UsersignVO;

// 작성자 : 김재겸

@Controller
@RequestMapping("/manager")
public class ManagerController {
	
	@Autowired
    private ManagerService managerService;

	 @Autowired
	   private ManagerDAO ManagerDAO;
    
    /**
     * 직원 등록 처리
     */
    @PostMapping("/PersonnelManagement/EmpManagement/empDataRegister")
    public ModelAndView registerEmployee(EmployeeVO employee, UsersVO user,
                                         UsersignVO usersign, EmpPictureVO picture,
                                         PersonnelChangeVO change) {
        ModelAndView mv = new ModelAndView("redirect:/PersonnelManagement/EmpManagement/empDataList");
        try {
        	 managerService.registerEmployee(employee, user, usersign, picture, change);
             mv.addObject("message", "직원 등록이 완료되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            mv.addObject("error", "직원 등록 중 오류가 발생했습니다: " + e.getMessage());
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

    
    /**
     * 직원 등록 중복 확인
     */
    @GetMapping("/manager/check-duplicate")
    @ResponseBody
    public Map<String, Boolean> checkDuplicate(@RequestParam String field, @RequestParam String value) {
        boolean isDuplicate = false;

        switch (field) {
            case "emp_email":
                isDuplicate = ManagerDAO.checkEmailDuplicate(value) > 0;
                break;
            case "emp_id":
                isDuplicate = ManagerDAO.checkEmpIdDuplicate(value) > 0;
                break;
        }

        Map<String, Boolean> response = new HashMap<>();
        response.put("duplicate", isDuplicate);
        return response;
    }



}