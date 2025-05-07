package com.ict.project.controller;

import com.ict.project.vo.personnel.AttendanceVO;
import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.service.AttendanceService;
import com.ict.project.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequestMapping("/attendance")
public class AttendanceController {

    @Autowired
    private AttendanceService attendanceService;

    @Autowired
    private EmployeeService employeeService;

    @GetMapping
    public ModelAndView attendancePage() {
        return new ModelAndView("MainPage/attendance");
    }

    @PostMapping("/checkin")
    public ResponseEntity<String> recordCheckin(HttpSession session) {
        String empIdx = getEmpIdxFromSession(session);
        if (empIdx == null) {
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }

        try {
            attendanceService.recordCheckin(empIdx);
            return new ResponseEntity<>("출근 등록 완료", HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/checkout")
    public ResponseEntity<String> recordCheckout(HttpSession session) {
        String empIdx = getEmpIdxFromSession(session);
        if (empIdx == null) {
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }

        try {
            attendanceService.recordCheckout(empIdx);
            return new ResponseEntity<>("퇴근 등록 완료", HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/weekly")
    public ResponseEntity<List<AttendanceVO>> getWeeklyAttendance(HttpSession session) {
        String empIdx = getEmpIdxFromSession(session);
        if (empIdx == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            List<AttendanceVO> attendanceList = attendanceService.getWeeklyAttendance(empIdx);
            return new ResponseEntity<>(attendanceList, HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private String getEmpIdxFromSession(HttpSession session) {
        UsersVO user = (UsersVO) session.getAttribute("userVO");
        if (user == null) {
            return null;
        }

        EmployeeVO employee = employeeService.findByUserIdx(user.getUser_idx());
        return (employee != null) ? employee.getEmp_idx() : null;
    }
}