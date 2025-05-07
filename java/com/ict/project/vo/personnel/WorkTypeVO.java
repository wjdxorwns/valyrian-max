/* 작성자: 한찬욱 */
package com.ict.project.vo.personnel;

public class WorkTypeVO {		//	3. 근무 방식
	
	
	//   근무방식ID, 직원코드, 출근타입, 시작일, 종료일, 벌점, 업무내용
	private int worktype_id, request_idx, demerit ;
	private String worktype, start_date, end_date, job;
	
	
	public int getWorktype_id() {
		return worktype_id;
	}
	public void setWorktype_id(int worktype_id) {
		this.worktype_id = worktype_id;
	}
	public int getRequest_idx() {
		return request_idx;
	}
	public void setRequest_idx(int request_idx) {
		this.request_idx = request_idx;
	}
	public int getDemerit() {
		return demerit;
	}
	public void setDemerit(int demerit) {
		this.demerit = demerit;
	}
	public String getWorktype() {
		return worktype;
	}
	public void setWorktype(String worktype) {
		this.worktype = worktype;
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
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	
	
	
	

	
}