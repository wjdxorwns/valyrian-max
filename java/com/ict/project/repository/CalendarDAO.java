package com.ict.project.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.vo.personnel.CalendarVO;

@Repository
public class CalendarDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(CalendarDAO.class);
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private static final String NAMESPACE = "calendar";
	
    public List<CalendarVO> getAllEvents() {
    	try {
    		logger.debug("전체 일정 조회 시작");
			List<CalendarVO> result = sqlSessionTemplate.selectList(NAMESPACE + ".getAllEvents");
			logger.debug("전체 일정 조회 완료 - 조회된 일정 수: {}", result.size());
			return result;
		} catch (Exception e) {
			logger.error("전체 일정 조회 중 오류 발생", e);
			throw new RuntimeException("일정 조회 중 오류가 발생했습니다.", e);
		}
    }

    public void insertEvent(CalendarVO cvo) {
    	try {
    		logger.debug("일정 추가 시작 - emp_idx: {}, title: {}", cvo.getEmp_idx(), cvo.getTitle());
			sqlSessionTemplate.insert(NAMESPACE + ".insertEvent", cvo);
			logger.debug("일정 추가 완료");
		} catch (Exception e) {
			logger.error("일정 추가 중 오류 발생 - emp_idx: {}, title: {}", new Object[]{cvo.getEmp_idx(), cvo.getTitle()}, e);
			throw new RuntimeException("일정 추가 중 오류가 발생했습니다.", e);
		}
    }

    public void deleteEvent(int calendar_idx) {
    	try {
    		logger.debug("일정 삭제 시작 - calendar_idx: {}", calendar_idx);
			sqlSessionTemplate.delete(NAMESPACE + ".deleteEvent", calendar_idx);
			logger.debug("일정 삭제 완료 - calendar_idx: {}", calendar_idx);
		} catch (Exception e) {
			logger.error("일정 삭제 중 오류 발생 - calendar_idx: {}", calendar_idx, e);
			throw new RuntimeException("일정 삭제 중 오류가 발생했습니다.", e);
		}
    }

    public void updateEvent(CalendarVO cvo) {
    	try {
    		logger.debug("일정 수정 시작 - calendar_idx: {}, emp_idx: {}", cvo.getCalendar_idx(), cvo.getEmp_idx());
			sqlSessionTemplate.update(NAMESPACE + ".updateEvent", cvo);
			logger.debug("일정 수정 완료 - calendar_idx: {}", cvo.getCalendar_idx());
		} catch (Exception e) {
			logger.error("일정 수정 중 오류 발생 - calendar_idx: {}, emp_idx: {}", new Object[]{cvo.getCalendar_idx(), cvo.getEmp_idx()}, e);
			throw new RuntimeException("일정 수정 중 오류가 발생했습니다.", e);
		}
    }

    public CalendarVO getEventById(int calendar_idx) {
    	try {
    		logger.debug("일정 상세 조회 시작 - calendar_idx: {}", calendar_idx);
			CalendarVO result = sqlSessionTemplate.selectOne(NAMESPACE + ".getEventById", calendar_idx);
			logger.debug("일정 상세 조회 완료 - calendar_idx: {}", calendar_idx);
			return result;
		} catch (Exception e) {
			logger.error("일정 상세 조회 중 오류 발생 - calendar_idx: {}", calendar_idx, e);
			throw new RuntimeException("일정 조회 중 오류가 발생했습니다.", e);
		}
    }
}