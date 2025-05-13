package com.ict.project.vo.Board;

/* 작성자: 김재겸 기여자: 한찬욱, 최성현 */
public class BoardVO { // 게시글 테이블

    // 게시글 고유 ID, 조회수
    private int board_id, view_count;
    // 제목, 본문, 작성자 고유 ID, 작성일, 수정일, 사진 파일명, 중요도, 비밀글 여부
    private String title, content, emp_idx, created_at, updated_at, f_name, importance, username;
    // 삭제 여부, 임시 저장 여부
    private boolean is_deleted, is_temp;

    // 게시글 번호 (프라이머리 키)
    public int getBoard_id() {
        return board_id;
    }
    public void setBoard_id(int board_id) {
        this.board_id = board_id;
    }

    // 조회수
    public int getView_count() {
        return view_count;
    }
    public void setView_count(int view_count) {
        this.view_count = view_count;
    }

    // 제목
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    // 본문
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    // 작성자 고유 ID
    public String getEmp_idx() {
        return emp_idx;
    }
    public void setEmp_idx(String emp_idx) {
        this.emp_idx = emp_idx;
    }

    // 작성일
    public String getCreated_at() {
        return created_at;
    }
    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    // 수정일 (수정된 부분)
    public String getUpdated_at() {
        return updated_at;
    }
    public void setUpdated_at(String updated_at) {
        this.updated_at = updated_at;
    }

    // 사진 파일명
    public String getF_name() {
        return f_name;
    }
    public void setF_name(String f_name) {
        this.f_name = f_name;
    }

    // 중요도
    public String getImportance() {
        return importance;
    }
    public void setImportance(String importance) {
        this.importance = importance;
    }

    // 사용자 이름 (emp_name을 매핑)
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    // 삭제 여부
    public boolean isIs_deleted() { // 'is_' 접두사는 boolean 타입에 사용됩니다.
        return is_deleted;
    }
    public void setIs_deleted(boolean is_deleted) {
        this.is_deleted = is_deleted;
    }

    // 임시 저장 여부
    public boolean isIs_temp() { // 'is_' 접두사는 boolean 타입에 사용됩니다.
        return is_temp;
    }
    public void setIs_temp(boolean is_temp) {
        this.is_temp = is_temp;
    }
}