package com.ict.project.vo.personnel;
/* �ۼ���: ������ */
public class VacationVO {				//	6. �ް�
	
	//	�ް�ID, �����ڵ�, �ް� ����, ������, ������, �ܿ� �ް� ��, ����
	private int vacation_id, request_idx;
	private String vacation_type, start_date, end_date, comment, status;
	

	
	public int getVacation_id() {
		return vacation_id;
	}
	public void setVacation_id(int vacation_id) {
		this.vacation_id = vacation_id;
	}
	public int getRequest_idx() {
		return request_idx;
	}
	public void setRequest_idx(int request_idx) {
		this.request_idx = request_idx;
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