package com.ict.project.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.AttendanceService;

@Repository
public class AttendanceDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<Map<String, Object>> getAttendanceByMonth(String year, String month) {
		try {
			
			return sqlSessionTemplate.selectList("attendance.getAttendanceByMonth", Map.of("year", year, "month", month));
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	

}
