package com.ict.project.service;

import com.ict.project.vo.personnel.AttendanceVO;

import java.util.List;

public interface AttendanceService {

    AttendanceVO recordCheckin(String emp_idx);

    AttendanceVO recordCheckout(String emp_idx);

    List<AttendanceVO> getWeeklyAttendance(String emp_idx);

    List<AttendanceVO> getTodayAttendance();
}