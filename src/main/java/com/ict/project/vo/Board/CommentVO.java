package com.ict.project.vo.Board;
/* 작성자: 김재겸 */
public class CommentVO {
	private int comment_id, board_id;
	private String emp_email, content, create_at;
	private boolean is_deleted;
	
	//=====댓글 번호=====
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	
	//=====게시글 번호(외래키)=====
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	
	//=====작성자 이메일(외래키)=====
	public String getEmp_email() {
		return emp_email;
	}
	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}
	
	//=====댓글 내용=====
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	//=====작성일=====
	public String getCreate_at() {
		return create_at;
	}
	public void setCreate_at(String create_at) {
		this.create_at = create_at;
	}
	
	//=====삭제 여부=====
	public boolean isIs_deleted() {
		return is_deleted;
	}
	public void setIs_deleted(boolean is_deleted) {
		this.is_deleted = is_deleted;
	}
	
	
}
