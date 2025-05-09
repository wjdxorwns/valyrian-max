package com.ict.project.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.vo.personnel.CalendarVO;

@Repository
public class CalendarDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private static final String NAMESPACE = "calendar";
	
    public List<CalendarVO> getAllEvents() {
    	try {
			return sqlSessionTemplate.selectList(NAMESPACE + ".getAllEvents");
		} catch (Exception e) {
			e.printStackTrace();
			new ModelAndView("error");
			return null;
		}
    }

    public void insertEvent(CalendarVO cvo) {
    	try {
			sqlSessionTemplate.insert(NAMESPACE + ".insertEvent", cvo);
		} catch (Exception e) {
			e.printStackTrace();
			new ModelAndView("error");
		}
    }

    public void deleteEvent(int calendar_idx) {
    	try {
			sqlSessionTemplate.delete(NAMESPACE + ".deleteEvent", calendar_idx);
		} catch (Exception e) {
			e.printStackTrace();
			new ModelAndView("error");
		}
    }

    public void updateEvent(CalendarVO cvo) {
    	try {
			sqlSessionTemplate.update(NAMESPACE + ".updateEvent", cvo);
		} catch (Exception e) {
			e.printStackTrace();
			new ModelAndView("error");
		}
    }

    public CalendarVO getEventById(int calendar_idx) {
    	try {
			return sqlSessionTemplate.selectOne(NAMESPACE + ".getEventById", calendar_idx);
		} catch (Exception e) {
			e.printStackTrace();
			new ModelAndView("error");
			return null;
		}
    }
}
