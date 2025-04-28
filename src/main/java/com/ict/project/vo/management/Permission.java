package com.ict.project.vo.management;
/* 작성자: 김재겸 수정자: 한찬욱 */
public class Permission {			// 권한
	
	//	직원고유코드, 직원정보접근권한, 근무방식접근권한, 인사발령접근권한, 급여정보접근권한, 휴가정보접근권한
	private String emp_idx ; 
	private int  can_access_employee, can_access_worktype,
		can_access_personnel, can_access_salary, can_access_vacation;

	
	public String getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(String emp_idx) {
		this.emp_idx = emp_idx;
	}
	//===== 직원 정보 접근 권한 =====
	public int getCan_access_employee() {
		return can_access_employee;
	}
	public void setCan_access_employee(int can_access_employee) {
		this.can_access_employee = can_access_employee;
	}
	
	//===== 근무 방식 접근 권한 =====
	public int getCan_access_worktype() {
		return can_access_worktype;
	}
	public void setCan_access_worktype(int can_access_worktype) {
		this.can_access_worktype = can_access_worktype;
	}
	
	//===== 인사 발령 접근 권한 =====
	public int getCan_access_personnel() {
		return can_access_personnel;
	}
	public void setCan_access_personnel(int can_access_personnel) {
		this.can_access_personnel = can_access_personnel;
	}
	
	//===== 급여 정보 접근 권한 =====
	public int getCan_access_salary() {
		return can_access_salary;
	}
	public void setCan_access_salary(int can_access_salary) {
		this.can_access_salary = can_access_salary;
	}
	
	//===== 휴가 정보 접근 권한 =====
	public int getCan_access_vacation() {
		return can_access_vacation;
	}
	public void setCan_access_vacation(int can_access_vacation) {
		this.can_access_vacation = can_access_vacation;
	}
	
	
}
