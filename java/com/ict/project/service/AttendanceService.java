package com.ict.project.service;

import com.ict.project.vo.personnel.AttendanceVO;

import java.util.List;

public interface AttendanceService {

    void recordCheckin(String emp_idx);

    void recordCheckout(String emp_idx);

    List<AttendanceVO> getWeeklyAttendance(String emp_idx);

    List<AttendanceVO> getTodayAttendance();
}