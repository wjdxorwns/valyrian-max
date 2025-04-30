/* 작성자: 한찬욱 */
package com.ict.project.vo.management;

public class RequestVO {	//	11. 승인 관련 권한 부여
	
	// 미승인 : 0 / 승인 : 1
	//	emp_idx를 외래키 지정을 위한 별도의 키, 직원고유키, 게시판 권한 승인, 
	//	달력 권한 승인, 인사발령 권한승인, 급여 승인, 휴가 승인, 근무 방식 승인
	private int	request_idx, request_personnelchange, 
			request_salary, request_vacation, request_worktype;
	private String emp_idx, reject	;
	
	
	public int getRequest_idx() {
		return request_idx;
	}
	public void setRequest_idx(int request_idx) {
		this.request_idx = request_idx;
	}
	public int getRequest_personnelchange() {
		return request_personnelchange;
	}
	public void setRequest_personnelchange(int request_personnelchange) {
		this.request_personnelchange = request_personnelchange;
	}
	public int getRequest_salary() {
		return request_salary;
	}
	public void setRequest_salary(int request_salary) {
		this.request_salary = request_salary;
	}
	public int getRequest_vacation() {
		return request_vacation;
	}
	public void setRequest_vacation(int request_vacation) {
		this.request_vacation = request_vacation;
	}
	public int getRequest_worktype() {
		return request_worktype;
	}
	public void setRequest_worktype(int request_worktype) {
		this.request_worktype = request_worktype;
	}
	public String getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(String emp_idx) {
		this.emp_idx = emp_idx;
	}
	public String getReject() {
		return reject;
	}
	public void setReject(String reject) {
		this.reject = reject;
	}
	
	
	
	
	
	
	
}