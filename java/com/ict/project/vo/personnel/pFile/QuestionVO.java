package com.ict.project.vo.personnel.pFile;
/* 작성자: 한찬욱 */
public class QuestionVO {		// 11. 문의 사항
	
	//	질문 번호, 이메일(아이디), 이름, 답변 상태, 관리자 답변, 질문 제목, 질문 내용, 날짜, 삭제여부 
	private int answer_id, deletable;
	private String emp_idx, emp_name, answer_status, answer_comment, 
				question_title, question_details, question_date;
	public int getAnswer_id() {
		return answer_id;
	}
	public void setAnswer_id(int answer_id) {
		this.answer_id = answer_id;
	}
	public int getDeletable() {
		return deletable;
	}
	public void setDeletable(int deletable) {
		this.deletable = deletable;
	}
	public String getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(String emp_idx) {
		this.emp_idx = emp_idx;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getAnswer_status() {
		return answer_status;
	}
	public void setAnswer_status(String answer_status) {
		this.answer_status = answer_status;
	}
	public String getAnswer_comment() {
		return answer_comment;
	}
	public void setAnswer_comment(String answer_comment) {
		this.answer_comment = answer_comment;
	}
	public String getQuestion_title() {
		return question_title;
	}
	public void setQuestion_title(String question_title) {
		this.question_title = question_title;
	}
	public String getQuestion_details() {
		return question_details;
	}
	public void setQuestion_details(String question_details) {
		this.question_details = question_details;
	}
	public String getQuestion_date() {
		return question_date;
	}
	public void setQuestion_date(String question_date) {
		this.question_date = question_date;
	}
	

}
