package com.ict.project.vo.board;
/* 작성자: 김재겸 기여자 : 한찬욱 */
public class BoardVO {				// 게시글 테이블
	
	//	게시글 고유 ID, 게시글 제목, 게시글 본문, 작성자 고유 ID, 게시글마지막수정시간/수정시간자동갱신
	//	조회수, 삭제 여부, 임시저장여부, 게시글사진파일명, 중요도 표시 
	private int board_id, view_count, emp_idx;
	private String title, content, created_at, update_at, f_name, importance;
	private boolean is_deleted, is_temp;
	
	
	//=====게시글 번호(프라이머리 키)=====
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	
	//=====조회수=====
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	
	//=====제목=====
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	//=====본문=====
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
	//=====작성일=====
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	
	//=====수정일=====
	public String getUpdate_at() {
		return update_at;
	}
	public void setUpdate_at(String update_at) {
		this.update_at = update_at;
	}
	
	//=====사진 파일명=====
	public String getF_name() {
		return f_name;
	}
	public void setF_name(String f_name) {
		this.f_name = f_name;
	}
	
	//=====삭제 여부=====
	public boolean isIs_deleted() {
		return is_deleted;
	}
	public void setIs_deleted(boolean is_deleted) {
		this.is_deleted = is_deleted;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public String getImportance() {
		return importance;
	}
	public void setImportance(String importance) {
		this.importance = importance;
	}
	public boolean isIs_temp() {
		return is_temp;
	}
	public void setIs_temp(boolean is_temp) {
		this.is_temp = is_temp;
	}
	
	
	
}
