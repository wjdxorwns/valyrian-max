package com.ict.project.vo.personnel;
/* 작성자: 김재겸 기여자 : 한찬욱 */
public class SalaryVO {				// 급여 명세서
	
	// 급여ID, 직원코드, 호봉, 기본급, 보너스, 지급일
	private int salary_id, pay_grade, base_salary, bonus;
	private String emp_idx, payment_date;
	
	
	public int getSalary_id() {
		return salary_id;
	}
	public void setSalary_id(int salary_id) {
		this.salary_id = salary_id;
	}
	
	public int getBase_salary() {
		return base_salary;
	}
	public void setBase_salary(int base_salary) {
		this.base_salary = base_salary;
	}
	public int getBonus() {
		return bonus;
	}
	public void setBonus(int bonus) {
		this.bonus = bonus;
	}
	
	public String getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}
	public int getPay_grade() {
		return pay_grade;
	}
	public void setPay_grade(int pay_grade) {
		this.pay_grade = pay_grade;
	}
	public String getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(String emp_idx) {
		this.emp_idx = emp_idx;
	}
	
	

}
