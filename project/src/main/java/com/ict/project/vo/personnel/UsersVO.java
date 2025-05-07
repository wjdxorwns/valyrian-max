/* 작성자: 한찬욱 */
package com.ict.project.vo.personnel;

public class UsersVO {	//	1. 회원가입 

	// 회원고유키, 이메일, 직원이름, 비밀번호, 집주소, 상세집주소, 휴대전화번호, 생성날짜, 삭제
	private int user_idx, remove;
	private String emp_email, emp_name, emp_password, home, 
				detail_home, phone_number, generation_day, gender, brithday;
	
	
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getEmp_email() {
		return emp_email;
	}
	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getEmp_password() {
		return emp_password;
	}
	public void setEmp_password(String emp_password) {
		this.emp_password = emp_password;
	}
	public String getHome() {
		return home;
	}
	public void setHome(String home) {
		this.home = home;
	}
	public String getDetail_home() {
		return detail_home;
	}
	public void setDetail_home(String detail_home) {
		this.detail_home = detail_home;
	}
	public String getPhone_number() {
		return phone_number;
	}
	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}
	public int getRemove() {
		return remove;
	}
	public void setRemove(int remove) {
		this.remove = remove;
	}
	public String getGeneration_day() {
		return generation_day;
	}
	public void setGeneration_day(String generation_day) {
		this.generation_day = generation_day;
	}

	

}