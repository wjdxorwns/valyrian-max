package com.ict.project.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.AttendanceService;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {
	@Autowired
	private AttendanceService attendanceService;

	@GetMapping("/search")
	public ModelAndView searchAttendance(@RequestParam("year") String year, @RequestParam("month") String month) {
		
		ModelAndView mv = new ModelAndView("resources/jsp/myDeptEmpResult");
		
		try {
			List<Map<String, Object>> attendanceList = attendanceService.getAttendanceByMonth(year, month);
			mv.addObject("attendanceList", attendanceList);
			mv.addObject("year", year);
			mv.addObject("month", month);
			
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("error", "오류가 발생했습니다.");
		}
		
		return mv;
	}
}
