
package com.ict.project.vo.personnel;
/* 작성자: 한찬욱 */
public class VacationVO {				// 휴가
	
	//	휴가ID, 직원코드, 휴가 종류, 시작일, 종료일, 잔여 휴가 수, 상태
	private int vacation_id, vacation_day ;
	private String emp_idx, vacation_type, start_date, end_date, comment, status;
	
	
	public int getVacation_id() {
		return vacation_id;
	}
	public void setVacation_id(int vacation_id) {
		this.vacation_id = vacation_id;
	}

	public String getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(String emp_idx) {
		this.emp_idx = emp_idx;
	}
	public int getVacation_day() {
		return vacation_day;
	}
	public void setVacation_day(int vacation_day) {
		this.vacation_day = vacation_day;
	}
	public String getVacation_type() {
		return vacation_type;
	}
	public void setVacation_type(String vacation_type) {
		this.vacation_type = vacation_type;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	

}