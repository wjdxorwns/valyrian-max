package com.ict.project.service;

import com.ict.project.vo.personnel.CalendarVO;
import java.util.List;

public interface CalendarService {
	
    List<CalendarVO> getAllEvents(); // 캘린더vo안에 있는 모든 컬럼명 호출, 프론트단으로 데이터 송신할때 사용
    void insertEvent(CalendarVO vo); // todo 삽입 기능
    void deleteEvent(int calendar_idx); // todo 삭제 기능
    void updateEvent(CalendarVO vo); // todo 수정 기능
    CalendarVO getEventById(int calendar_idx); // 특정 일정 조회
}
