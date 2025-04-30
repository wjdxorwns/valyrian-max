package com.ict.project.vo.personnel;
/* 작성자: 한찬욱 */
public class CalendarVO {		//	10. 캘린더
	
	//	캘린더고유코드, 직원고유코드, 제목, 내용, 시작날짜, 종료날짜
	private int calendar_idx ;
	private String emp_idx, title, comment, start_day, end_day ;
	
	
	
	public int getCalendar_idx() {
		return calendar_idx;
	}
	public void setCalendar_idx(int calendar_idx) {
		this.calendar_idx = calendar_idx;
	}
	public String getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(String emp_idx) {
		this.emp_idx = emp_idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getStart_day() {
		return start_day;
	}
	public void setStart_day(String start_day) {
		this.start_day = start_day;
	}
	public String getEnd_day() {
		return end_day;
	}
	public void setEnd_day(String end_day) {
		this.end_day = end_day;
	}	
	
	
	
	
}