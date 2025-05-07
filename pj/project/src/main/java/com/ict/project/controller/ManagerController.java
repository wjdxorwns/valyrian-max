package com.ict.project.controller;

import org.springframework.beans.factory.annotation.Autowired;

// 작성자 : 김재겸

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.ManagerService;


@Controller
public class ManagerController {
	@Autowired
    private ManagerService managerService;

    @GetMapping("/employeeInforForm")
    public ModelAndView getemployeeInforForm() {
        return new ModelAndView("PersonnelManagement/EmpManagement/employeeInforForm");
    }

    @PostMapping("/empList")
    public ModelAndView getEmpList() {
        ModelAndView mv = new ModelAndView("PersonnelManagement/EmpManagement/employeeInforForm");
        try {
            mv.addObject("empList", managerService.getAllEmp());
        } catch (Exception e) {
            e.printStackTrace();
            mv.addObject("error", "검색결과없음 검색결과없음");
        }
        return mv;
    }
}
