package com.ict.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.AttendanceDAO;

@Service
public class AttendanceServiceImpl implements AttendanceService {
	@Autowired
	private AttendanceDAO attendanceDAO;
	
	@Override
	public List<Map<String, Object>> getAttendanceByMonth(String year, String month) {
		return attendanceDAO.getAttendanceByMonth(year, month);
	}
}
