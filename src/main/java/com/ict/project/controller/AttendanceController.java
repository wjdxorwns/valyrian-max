package com.ict.project.controller;

import com.ict.project.vo.personnel.AttendanceVO;
import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.service.AttendanceService;
import com.ict.project.service.EmployeeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/attendance")
public class AttendanceController {

    private static final Logger logger = LoggerFactory.getLogger(AttendanceController.class);

    @Autowired
    private AttendanceService attendanceService;

    @Autowired
    private EmployeeService employeeService;

    @GetMapping
    public ModelAndView attendancePage() {
        return new ModelAndView("MainPage/attendance");
    }

    @GetMapping("/favicon.ico")
    public void handleFaviconRequest() {
        // 요청을 무시하고 아무것도 반환하지 않습니다.
        logger.debug("favicon.ico 요청이 서버에서 무시되었습니다.");
    }

    @PostMapping("/checkin")
    public ResponseEntity<Map<String, Object>> recordCheckin(HttpSession session) {
        String empIdx = getEmpIdxFromSession(session);
        if (empIdx == null) {
            logger.warn("출근 기록 실패: 유효한 세션 또는 emp_idx 없음");
            Map<String, Object> response = new HashMap<>();
            response.put("error", "인증되지 않은 사용자입니다. 로그인 후 다시 시도하세요.");
            return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
        }

        try {
            AttendanceVO attendance = attendanceService.recordCheckin(empIdx);
            EmployeeVO employee = employeeService.findByEmpIdx(empIdx);
            Map<String, Object> response = new HashMap<>();
            response.put("emp_name", employee != null ? employee.getEmp_name() : "Unknown");
            response.put("work_date", attendance.getWork_date());
            response.put("start_time", attendance.getStart_time());
            response.put("worktype", attendance.getWorktype());
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (RuntimeException e) {
            logger.error("출근 기록 오류: {}", e.getMessage());
            Map<String, Object> response = new HashMap<>();
            response.put("error", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/checkout")
    public ResponseEntity<Map<String, Object>> recordCheckout(HttpSession session) {
        String empIdx = getEmpIdxFromSession(session);
        if (empIdx == null) {
            logger.warn("퇴근 기록 실패: 유효한 세션 또는 emp_idx 없음");
            Map<String, Object> response = new HashMap<>();
            response.put("error", "인증되지 않은 사용자입니다. 로그인 후 다시 시도하세요.");
            return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
        }

        try {
            AttendanceVO attendance = attendanceService.recordCheckout(empIdx);
            EmployeeVO employee = employeeService.findByEmpIdx(empIdx);
            Map<String, Object> response = new HashMap<>();
            response.put("emp_name", employee != null ? employee.getEmp_name() : "Unknown");
            response.put("work_date", attendance.getWork_date());
            response.put("end_time", attendance.getEnd_time());
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (RuntimeException e) {
            logger.error("퇴근 기록 오류: {}", e.getMessage());
            Map<String, Object> response = new HashMap<>();
            response.put("error", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/weekly")
    public ResponseEntity<List<AttendanceVO>> getWeeklyAttendance(HttpSession session) {
        String empIdx = getEmpIdxFromSession(session);
        if (empIdx == null) {
            logger.warn("주간 근태 조회 실패: 유효한 세션 또는 emp_idx 없음");
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            List<AttendanceVO> attendanceList = attendanceService.getWeeklyAttendance(empIdx);
            return new ResponseEntity<>(attendanceList, HttpStatus.OK);
        } catch (RuntimeException e) {
            logger.error("주간 근태 조회 오류: {}", e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/today")
    public ResponseEntity<List<AttendanceVO>> getTodayAttendance(HttpSession session) {
        UsersVO user = (UsersVO) session.getAttribute("userVO"); // 세션에서 userVO 가져오기
        if (user == null) {
            logger.warn("오늘 근태 조회 실패: 세션에서 userVO를 찾을 수 없음");
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        String adminStatus = (String) session.getAttribute("user.admin");
        if (!"ok".equals(adminStatus)) {
            logger.warn("오늘 근태 조회 실패: 관리자 권한 없음, adminStatus={}", adminStatus);
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            List<AttendanceVO> attendanceList = attendanceService.getTodayAttendance();
            return new ResponseEntity<>(attendanceList, HttpStatus.OK);
        } catch (RuntimeException e) {
            logger.error("오늘 근태 조회 오류: {}", e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private String getEmpIdxFromSession(HttpSession session) {
        UsersVO user = (UsersVO) session.getAttribute("userVO"); // 세션 키 이름 유지
        if (user == null) {
            logger.warn("세션에서 userVO를 찾을 수 없음");
            return null;
        }

        EmployeeVO employee = employeeService.findByUserIdx(user.getUser_idx());
        if (employee == null) {
            logger.warn("employee를 찾을 수 없음: user_idx={}", user.getUser_idx());
            return null;
        }

        logger.debug("emp_idx 조회 성공: emp_idx={}", employee.getEmp_idx());
        return employee.getEmp_idx();
    }
}