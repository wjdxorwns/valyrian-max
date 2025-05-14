package com.ict.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ict.project.service.CalendarService;
import com.ict.project.vo.personnel.CalendarVO;

@Controller
@RequestMapping("/calendar")
public class CalendarController {

    private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);

    @Autowired
    private CalendarService calendarService;

    // 캘린더 화면 진입 (emp_idx 파라미터를 받아 세션에 저장)
    @GetMapping
    public ModelAndView goCalendar(@RequestParam("emp_idx") String emp_idx, HttpSession session) {
        logger.info("캘린더 페이지 요청 - emp_idx: {}", emp_idx);
        session.setAttribute("emp_idx", emp_idx);
        return new ModelAndView("MainPage/workingCalendar");
    }

    // 일정 목록 반환 (emp_idx 기반)
    @GetMapping("/list")
    @ResponseBody
    public ResponseEntity<List<Map<String, Object>>> getCalendarList(HttpSession session) {
        try {
            String emp_idx = (String) session.getAttribute("emp_idx");
            logger.info("일정 목록 조회 시작 - emp_idx: {}", emp_idx);

            if (emp_idx == null) {
                logger.warn("세션에 emp_idx가 없습니다.");
                return ResponseEntity.status(401).build();
            }

            List<CalendarVO> calendarList = calendarService.getAllEvents();
            List<Map<String, Object>> result = new ArrayList<>();

            for (CalendarVO vo : calendarList) {
                if (vo.getEmp_idx().equals(emp_idx)) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", vo.getCalendar_idx());  // FullCalendar용
                    map.put("calendar_idx", vo.getCalendar_idx());
                    map.put("title", vo.getTitle() != null ? vo.getTitle() : "");
                    map.put("start", vo.getStart_day());
                    map.put("end", vo.getEnd_day());
                    map.put("description", vo.getComment() != null ? vo.getComment() : "");
                    result.add(map);
                }
            }

            return ResponseEntity.ok(result);
        } catch (Exception e) {
            logger.error("일정 목록 조회 중 오류 발생", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    // 일정 추가
    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<Void> addEvent(@RequestBody CalendarVO vo, HttpSession session) {
        try {
            String emp_idx = (String) session.getAttribute("emp_idx");
            logger.info("일정 추가 요청 - emp_idx: {}", emp_idx);

            if (emp_idx == null) {
                return ResponseEntity.status(401).build();
            }

            if (vo.getTitle() == null || vo.getTitle().trim().isEmpty()) {
                return ResponseEntity.badRequest().build();
            }

            vo.setEmp_idx(emp_idx);
            calendarService.insertEvent(vo);
            logger.info("일정 추가 완료 - calendar_idx: {}", vo.getCalendar_idx());

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            logger.error("일정 추가 중 오류 발생", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    // 일정 삭제
    @PostMapping("/delete/{calendar_idx}")
    @ResponseBody
    public ResponseEntity<Void> deleteEvent(@PathVariable("calendar_idx") int calendar_idx, HttpSession session) {
        try {
            String emp_idx = (String) session.getAttribute("emp_idx");
            logger.info("일정 삭제 요청 - calendar_idx: {}, emp_idx: {}", calendar_idx, emp_idx);

            if (emp_idx == null) {
                return ResponseEntity.status(401).build();
            }

            CalendarVO vo = calendarService.getEventById(calendar_idx);
            if (vo == null) {
                return ResponseEntity.notFound().build();
            }

            if (!vo.getEmp_idx().equals(emp_idx)) {
                return ResponseEntity.status(403).build();
            }

            calendarService.deleteEvent(calendar_idx);
            logger.info("일정 삭제 성공 - calendar_idx: {}", calendar_idx);

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            logger.error("일정 삭제 중 오류 발생", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    // 일정 수정
    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<Void> updateEvent(@RequestBody CalendarVO vo, HttpSession session) {
        try {
            String emp_idx = (String) session.getAttribute("emp_idx");
            logger.info("일정 수정 요청 - calendar_idx: {}, emp_idx: {}", vo.getCalendar_idx(), emp_idx);

            if (emp_idx == null) {
                return ResponseEntity.status(401).build();
            }

            if (vo.getTitle() == null || vo.getTitle().trim().isEmpty()) {
                return ResponseEntity.badRequest().build();
            }

            CalendarVO existing = calendarService.getEventById(vo.getCalendar_idx());
            if (existing == null) {
                return ResponseEntity.notFound().build();
            }

            if (!existing.getEmp_idx().equals(emp_idx)) {
                return ResponseEntity.status(403).build();
            }

            vo.setEmp_idx(emp_idx);
            calendarService.updateEvent(vo);
            logger.info("일정 수정 완료 - calendar_idx: {}", vo.getCalendar_idx());

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            logger.error("일정 수정 중 오류 발생", e);
            return ResponseEntity.internalServerError().build();
        }
    }
}