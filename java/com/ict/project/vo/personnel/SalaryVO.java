package com.ict.project.vo.personnel;
/* 작성자: 김재겸 기여자 : 한찬욱 */
public class SalaryVO {				//	5. 급여 명세서
	
	// 급여ID, 직원코드, 호봉, 기본급, 보너스, 지급일
	private int salary_id, request_idx, base_salary, bonus;
	private String payment_date;
	
	
	
	public int getSalary_id() {
		return salary_id;
	}
	public void setSalary_id(int salary_id) {
		this.salary_id = salary_id;
	}
	public int getRequest_idx() {
		return request_idx;
	}
	public void setRequest_idx(int request_idx) {
		this.request_idx = request_idx;
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
	
	
	

	
	
	
}