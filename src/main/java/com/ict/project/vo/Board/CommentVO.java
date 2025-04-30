package com.ict.project.vo.Board;
/* 작성자: 김재겸 기여자 : 한찬욱 */
public class CommentVO {			//	8. 댓글 테이블
	
	//	댓글 고유 ID, 참조 게시글 ID, 작성자 고유 ID, 댓글 내용, 댓글 작성 시간, 
	//	댓글 수정 시간, 삭제여부
	private int comment_id, board_id;
	private String emp_idx, content, create_at, update_at;
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
	

	
	public String getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(String emp_idx) {
		this.emp_idx = emp_idx;
	}
	public String getUpdate_at() {
		return update_at;
	}
	public void setUpdate_at(String update_at) {
		this.update_at = update_at;
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