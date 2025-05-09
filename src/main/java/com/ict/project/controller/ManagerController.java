package com.ict.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.ManagerService;

// 작성자 : 김재겸

@Controller
public class ManagerController {
	@Autowired
    private ManagerService managerService;

    @GetMapping("/employee_Infor_Form")
    public ModelAndView getemployee_Infor_Form() {
        return new ModelAndView("PersonnelManagement/EmpManagement/employee_Infor_Form");
    }

    @PostMapping("/emp_list")
    public ModelAndView getEmpList() {
        ModelAndView mv = new ModelAndView("PersonnelManagement/EmpManagement/employee_Infor_Form");
        try {
            mv.addObject("emplist", managerService.getAllEmp());
        } catch (Exception e) {
            e.printStackTrace();
            mv.addObject("error", "검색결과없음검색결과없음");
        }
        return mv;
    }
}