package com.ict.project.vo.personnel;
/* 작성자: 김재겸 기여자 : 한찬욱 */
public class EmployeeVO {	//	2. 직원
	
	//	직원고유키, 회원고유키, 직원고유코드, 비밀번호, 부서명, 직책, 호봉, 입사일, 퇴사일, 근무방식, 퇴사자
	private int user_idx, pay_grade;
	private String emp_idx, emp_id, dept_name, position, hire_date, team, location,
				resignation_date, attitude_type, quitter, employment_type ;
	
	public String getEmp_idx() {

		return emp_idx;
	}
	public void setEmp_idx(String emp_idx) {

		this.emp_idx = emp_idx;
	}
	public int getUser_idx() {

		return user_idx;
	}
	public void setUser_idx(int user_idx) {

		this.user_idx = user_idx;
	}
	public int getPay_grade() {

		return pay_grade;
	}
	public void setPay_grade(int pay_grade) {

		this.pay_grade = pay_grade;
	}
	public String getEmp_id() {

		return emp_id;
	}
	public void setEmp_id(String emp_id) {

		this.emp_id = emp_id;
	}
	public String getDept_name() {

		return dept_name;
	}
	public void setDept_name(String dept_name) {

		this.dept_name = dept_name;
	}
	public String getPosition() {

		return position;
	}
	public void setPosition(String position) {

		this.position = position;
	}
	public String getHire_date() {
		return hire_date;}
	public void setHire_date(String hire_date) {

		this.hire_date = hire_date;
	}
	public String getResignation_date() {
		return resignation_date;
	}
	public void setResignation_date(String resignation_date) {
		this.resignation_date = resignation_date;
	}
	public String getAttitude_type() {
		return attitude_type;
	}
	public void setAttitude_type(String attitude_type) {
		this.attitude_type = attitude_type;
	}
	public String getQuitter() {
		return quitter;
	}
	public void setQuitter(String quitter) {
		this.quitter = quitter;
	}
	public String getEmployment_type() {
		return employment_type;
	}
	public void setEmployment_type(String employment_type) {
		this.employment_type = employment_type;
	}


    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team;
    }
}