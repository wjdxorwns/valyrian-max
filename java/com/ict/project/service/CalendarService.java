package com.ict.project.service;

import com.ict.project.vo.personnel.CalendarVO;
import java.util.List;

public interface CalendarService {
	List<CalendarVO> getAllEvents();
	void insertEvent(CalendarVO vo);
	void deleteEvent(int calendar_idx);
	void updateEvent(CalendarVO vo);
	CalendarVO getEventById(int calendar_idx);
}