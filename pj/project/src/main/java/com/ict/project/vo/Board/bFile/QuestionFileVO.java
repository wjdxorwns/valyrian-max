package com.ict.project.vo.Board.bFile;
/* 작성자: 한찬욱 */
public class QuestionFileVO {		//	11-1 문의사항 첨부파일
	
	//	QnA 첨부파일 ID, 게시글 ID, QnA 파일명, QnA 저장경로, QnA 파일 타입, QnA 크기, QnA 업로드 시각
	private int qna_file_id, qna_answer_id, qna_file_size ;
	private String qna_file_name, qna_file_path, qna_file_type, qna_upload_at ;

	
	public int getQna_file_id() {
		return qna_file_id;
	}
	public void setQna_file_id(int qna_file_id) {
		this.qna_file_id = qna_file_id;
	}
	public int getQna_answer_id() {
		return qna_answer_id;
	}
	public void setQna_answer_id(int qna_answer_id) {
		this.qna_answer_id = qna_answer_id;
	}
	public int getQna_file_size() {
		return qna_file_size;
	}
	public void setQna_file_size(int qna_file_size) {
		this.qna_file_size = qna_file_size;
	}
	public String getQna_file_name() {
		return qna_file_name;
	}
	public void setQna_file_name(String qna_file_name) {
		this.qna_file_name = qna_file_name;
	}
	public String getQna_file_path() {
		return qna_file_path;
	}
	public void setQna_file_path(String qna_file_path) {
		this.qna_file_path = qna_file_path;
	}
	public String getQna_file_type() {
		return qna_file_type;
	}
	public void setQna_file_type(String qna_file_type) {
		this.qna_file_type = qna_file_type;
	}
	public String getQna_upload_at() {
		return qna_upload_at;
	}
	public void setQna_upload_at(String qna_upload_at) {
		this.qna_upload_at = qna_upload_at;
	}

	
	
}
