package com.ict.project.service;

import java.util.List;
import java.util.Map;

public interface AttendanceService {
	public List<Map<String, Object>> getAttendanceByMonth(String year, String month);
	
}
