package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.CalendarDAO;
import com.ict.project.vo.personnel.CalendarVO;

@Service
public class CalendarServiceImpl implements CalendarService {

    @Autowired
    private CalendarDAO calendarDAO;

    @Override
    public List<CalendarVO> getAllEvents() {
        return calendarDAO.getAllEvents();
    }

    @Override
    public void insertEvent(CalendarVO vo) {
        calendarDAO.insertEvent(vo);
    }

    @Override
    public void deleteEvent(int calendar_idx) {
        calendarDAO.deleteEvent(calendar_idx);
    }

    @Override
    public void updateEvent(CalendarVO vo) {
        calendarDAO.updateEvent(vo);
    }

    @Override
    public CalendarVO getEventById(int calendar_idx) {
        return calendarDAO.getEventById(calendar_idx);
    }
}