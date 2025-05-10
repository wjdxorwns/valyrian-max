package com.ict.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CalendarService;
import com.ict.project.vo.personnel.CalendarVO;

@RestController
@ResponseBody
public class CalendarController {

    @Autowired
    private CalendarService calendarService;
    
    @GetMapping(value="/calendar")
    public ModelAndView goCalendar() {
    	return new ModelAndView("MainPage/workingCalendar");
    }

    @GetMapping(value = "/calendar/list", produces = "application/json")
    public List<Map<String, Object>> getCalendarList(HttpSession session) {
        String emp_idx = (String) session.getAttribute("emp_idx");
        List<CalendarVO> calendarList = calendarService.getAllEvents();
        List<Map<String, Object>> result = new ArrayList<>();

        for (CalendarVO vo : calendarList) {
            // 자신의 일정만 보이도록 필터링
            if (vo.getEmp_idx().equals(emp_idx)) {
                Map<String, Object> map = new HashMap<>();
                map.put("title", vo.getTitle());
                map.put("start", vo.getStart_day());
                map.put("end", vo.getEnd_day());
                map.put("description", vo.getComment());
                map.put("id", vo.getCalendar_idx());
                result.add(map);
            }
        }
        return result;
    }

    @PostMapping(value = "/add", produces = "application/json")
    public void addEvent(@RequestBody CalendarVO vo, HttpSession session) {
        String emp_idx = (String) session.getAttribute("emp_idx");
        vo.setEmp_idx(emp_idx);
        calendarService.insertEvent(vo);
    }

    @PostMapping(value = "/delete/{id}", produces = "application/json")
    public void deleteEvent(@PathVariable("id") int calendar_idx, HttpSession session) {
        String emp_idx = (String) session.getAttribute("emp_idx");
        // 자신의 일정만 삭제할 수 있도록 확인
        CalendarVO vo = calendarService.getEventById(calendar_idx);
        if (vo != null && vo.getEmp_idx().equals(emp_idx)) {
            calendarService.deleteEvent(calendar_idx);
        }
    }

    @PostMapping(value = "/update", produces = "application/json")
    public void updateEvent(@RequestBody CalendarVO vo, HttpSession session) {
        String emp_idx = (String) session.getAttribute("emp_idx");
        // 자신의 일정만 수정할 수 있도록 확인
        CalendarVO existingEvent = calendarService.getEventById(vo.getCalendar_idx());
        if (existingEvent != null && existingEvent.getEmp_idx().equals(emp_idx)) {
            vo.setEmp_idx(emp_idx);
            calendarService.updateEvent(vo);
        }
    }
}
