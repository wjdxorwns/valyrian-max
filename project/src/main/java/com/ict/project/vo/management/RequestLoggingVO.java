/* 작성자: 한찬욱 */
package com.ict.project.vo.management;

public class RequestLoggingVO {	//	12. 승인 요청에 대한 로그
	
	//	승인요청고유코드, 직원고유코드, 게시판 승인요청, 달력승인요청,
	//	인사발령승인요청, 급여관련승인요청, 휴가관련승인요청, 근무방식승인요청
	private int logging_idx, request_idx ;
	private String logging_personnelchange, logging_salary, 
			logging_vacation, logging_worktype, reject, logging_date ;
	
	
	public int getLogging_idx() {
		return logging_idx;
	}
	public void setLogging_idx(int logging_idx) {
		this.logging_idx = logging_idx;
	}
	public int getRequest_idx() {
		return request_idx;
	}
	public void setRequest_idx(int request_idx) {
		this.request_idx = request_idx;
	}
	public String getLogging_personnelchange() {
		return logging_personnelchange;
	}
	public void setLogging_personnelchange(String logging_personnelchange) {
		this.logging_personnelchange = logging_personnelchange;
	}
	public String getLogging_salary() {
		return logging_salary;
	}
	public void setLogging_salary(String logging_salary) {
		this.logging_salary = logging_salary;
	}
	public String getLogging_vacation() {
		return logging_vacation;
	}
	public void setLogging_vacation(String logging_vacation) {
		this.logging_vacation = logging_vacation;
	}
	public String getLogging_worktype() {
		return logging_worktype;
	}
	public void setLogging_worktype(String logging_worktype) {
		this.logging_worktype = logging_worktype;
	}
	public String getReject() {
		return reject;
	}
	public void setReject(String reject) {
		this.reject = reject;
	}
	public String getLogging_date() {
		return logging_date;
	}
	public void setLogging_date(String logging_date) {
		this.logging_date = logging_date;
	}
	
	
	

}