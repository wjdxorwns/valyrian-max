package com.ict.project.vo.board.bFile;
/* 작성자: 한찬욱 */
public class BoardFileVO {			//	7-1. 게시글 첨부 파일
	
	//	첨부파일 고유ID, 참조 게시글ID, 원본 파일명, 저장 경로, 파일 형식, 파일 크기, 업로드 시간
	private int file_id, board_id, file_size ;
	private String file_name, file_path, file_type, uploaded_at ;
	
	
	public int getFile_id() {
		return file_id;
	}
	public void setFile_id(int file_id) {
		this.file_id = file_id;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public int getFile_size() {
		return file_size;
	}
	public void setFile_size(int file_size) {
		this.file_size = file_size;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public String getUploaded_at() {
		return uploaded_at;
	}
	public void setUploaded_at(String uploaded_at) {
		this.uploaded_at = uploaded_at;
	}
	
	
	
}