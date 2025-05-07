/* 작성자: 한찬욱 */
package com.ict.project.vo.personnel.pFile;

public class UsersignVO {	//	1-1 싸인 저장 
	
	//	사인고유번호, 회원고유키, 사인명, 사인파일의 저장경로, 생성날짜, 수정날짜
	private int	sign_idx, user_idx ;
	private String sign_name ,sign_path, update_day ;
	public int getSign_idx() {
		return sign_idx;
	}
	public void setSign_idx(int sign_idx) {
		this.sign_idx = sign_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getSign_name() {
		return sign_name;
	}
	public void setSign_name(String sign_name) {
		this.sign_name = sign_name;
	}
	public String getSign_path() {
		return sign_path;
	}
	public void setSign_path(String sign_path) {
		this.sign_path = sign_path;
	}
	public String getUpdate_day() {
		return update_day;
	}
	public void setUpdate_day(String update_day) {
		this.update_day = update_day;
	}

	
	

	
}