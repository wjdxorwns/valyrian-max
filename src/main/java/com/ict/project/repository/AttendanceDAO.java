	package com.ict.project.repository;
	
	import com.ict.project.vo.personnel.AttendanceVO;
	import org.apache.ibatis.session.SqlSession;
	import org.springframework.beans.factory.annotation.Autowired;
	import org.springframework.stereotype.Repository;
	
	import java.util.List;
	
	@Repository
	public class AttendanceDAO {
	
	    @Autowired
	    private SqlSession sqlSession;
	
	    private static final String MAPPER_NAMESPACE = "com.ict.project.repository.AttendanceDAO.";
	
	    public void insertAttendance(AttendanceVO attendance) {
	        sqlSession.insert(MAPPER_NAMESPACE + "insertAttendance", attendance);
	    }
	
	    public void updateAttendance(AttendanceVO attendance) {
	        sqlSession.update(MAPPER_NAMESPACE + "updateAttendance", attendance);
	    }
	
	    public AttendanceVO findTodayAttendance(String empIdx) {
	        return sqlSession.selectOne(MAPPER_NAMESPACE + "findTodayAttendance", empIdx);
	    }
	
	    public List<AttendanceVO> getWeeklyAttendance(String empIdx) {
	        return sqlSession.selectList(MAPPER_NAMESPACE + "getWeeklyAttendance", empIdx);
	    }
	
	    public List<AttendanceVO> getTodayAttendance() {
	        return sqlSession.selectList(MAPPER_NAMESPACE + "getTodayAttendance");
	    }
	}
