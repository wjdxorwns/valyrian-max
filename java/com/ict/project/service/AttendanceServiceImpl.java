package com.ict.project.service;

import com.ict.project.repository.AttendanceDAO;
import com.ict.project.service.AttendanceService;
import com.ict.project.vo.personnel.AttendanceVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalTime;
import java.util.List;

@Service
public class AttendanceServiceImpl implements AttendanceService {

    @Autowired
    private AttendanceDAO attendanceDAO;

    @Override
    public void recordCheckin(String emp_idx) {
        AttendanceVO todayRecord = attendanceDAO.findTodayAttendance(emp_idx);
        if (todayRecord != null) {
            throw new RuntimeException("이미 출근 기록이 존재합니다.");
        }

        AttendanceVO attendance = new AttendanceVO();
        attendance.setEmp_idx(emp_idx);
        attendance.setStart_time(LocalTime.now());
        attendance.setWorktype(calculateWorkType(attendance.getStart_time()));

        attendanceDAO.insertAttendance(attendance);
    }

    @Override
    public void recordCheckout(String emp_idx) {
        AttendanceVO record = attendanceDAO.findTodayAttendance(emp_idx);
        if (record == null) {
            throw new RuntimeException("출근 기록이 없습니다.");
        }

        if (record.getEnd_time() != null) {
            throw new RuntimeException("이미 퇴근 기록이 존재합니다.");
        }

        record.setEnd_time(LocalTime.now());
        attendanceDAO.updateAttendance(record);
    }

    @Override
    public List<AttendanceVO> getWeeklyAttendance(String emp_idx) {
        return attendanceDAO.getWeeklyAttendance(emp_idx);
    }

    @Override
    public List<AttendanceVO> getTodayAttendance() {
        return attendanceDAO.getTodayAttendance();
    }

    private String calculateWorkType(LocalTime startTime) {
        LocalTime normalStart = LocalTime.of(9, 0);
        return startTime.isAfter(normalStart) ? "지각" : "정상출근";
    }
}