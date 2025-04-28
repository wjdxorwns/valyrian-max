/* 작성자: 한찬욱 */
package com.ict.project.vo.management;

public class ApproveVO {	// 승인 관련 권한 부여
	
	// 미승인 : 0 / 승인 : 1
	//	emp_idx를 외래키 지정을 위한 별도의 키, 직원고유키, 게시판 권한 승인, 
	//	달력 권한 승인, 인사발령 권한승인, 급여 승인, 휴가 승인, 근무 방식 승인
	private int	approve_idx, approve_board, approve_caleder, approve_personnelchange, 
			approve_salary, approve_vacation, approve_worktype;
	private String emp_idx	;
	
	
	public int getApprove_idx() {
		return approve_idx;
	}
	public void setApprove_idx(int approve_idx) {
		this.approve_idx = approve_idx;
	}
	public int getApprove_board() {
		return approve_board;
	}
	public void setApprove_board(int approve_board) {
		this.approve_board = approve_board;
	}
	public int getApprove_caleder() {
		return approve_caleder;
	}
	public void setApprove_caleder(int approve_caleder) {
		this.approve_caleder = approve_caleder;
	}
	public int getApprove_personnelchange() {
		return approve_personnelchange;
	}
	public void setApprove_personnelchange(int approve_personnelchange) {
		this.approve_personnelchange = approve_personnelchange;
	}
	public int getApprove_salary() {
		return approve_salary;
	}
	public void setApprove_salary(int approve_salary) {
		this.approve_salary = approve_salary;
	}
	public int getApprove_vacation() {
		return approve_vacation;
	}
	public void setApprove_vacation(int approve_vacation) {
		this.approve_vacation = approve_vacation;
	}
	public int getApprove_worktype() {
		return approve_worktype;
	}
	public void setApprove_worktype(int approve_worktype) {
		this.approve_worktype = approve_worktype;
	}
	public String getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(String emp_idx) {
		this.emp_idx = emp_idx;
	}
	
	
	
	
	
}
