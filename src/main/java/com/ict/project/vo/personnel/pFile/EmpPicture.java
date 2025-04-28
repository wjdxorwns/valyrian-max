/* 작성자: 한찬욱 */
package com.ict.project.vo.personnel.pFile;

public class EmpPicture { // 이미지 테이블
	
	//	파일고유번호, 직원고유코드, 파일이름, 파일경로, 파일너비, 파일높이
	private int f_id ;
	private String emp_idx, f_name, f_path, f_width, f_height;
	
	
	public int getF_id() {
		return f_id;
	}
	public void setF_id(int f_id) {
		this.f_id = f_id;
	}
	
	public String getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(String emp_idx) {
		this.emp_idx = emp_idx;
	}
	public String getF_name() {
		return f_name;
	}
	public void setF_name(String f_name) {
		this.f_name = f_name;
	}
	public String getF_path() {
		return f_path;
	}
	public void setF_path(String f_path) {
		this.f_path = f_path;
	}
	public String getF_width() {
		return f_width;
	}
	public void setF_width(String f_width) {
		this.f_width = f_width;
	}
	public String getF_height() {
		return f_height;
	}
	public void setF_height(String f_height) {
		this.f_height = f_height;
	}
	
	

}
