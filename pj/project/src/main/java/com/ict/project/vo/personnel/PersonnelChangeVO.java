package com.ict.project.vo.personnel;
/* 작성자: 김재겸 기여자 : 한찬욱 */
public class PersonnelChangeVO {	//	4. 인사 발령 테이블
	
	//	발령ID, 직원코드, 발령유형, 발령일, 이전 부서명, 변경 후 부서명, 고용타입
	private int change_id, request_idx;
	private String change_type, change_date, prev_dept_id, 
				new_dept_id, employment_type, prev_location_id, new_location_id;
	
	
	public int getChange_id() {
		return change_id;
	}
	public void setChange_id(int change_id) {
		this.change_id = change_id;
	}
	public int getRequest_idx() {
		return request_idx;
	}
	public void setRequest_idx(int request_idx) {
		this.request_idx = request_idx;
	}
	public String getChange_type() {
		return change_type;
	}
	public void setChange_type(String change_type) {
		this.change_type = change_type;
	}
	public String getChange_date() {
		return change_date;
	}
	public void setChange_date(String change_date) {
		this.change_date = change_date;
	}
	public String getPrev_dept_id() {
		return prev_dept_id;
	}
	public void setPrev_dept_id(String prev_dept_id) {
		this.prev_dept_id = prev_dept_id;
	}
	public String getNew_dept_id() {
		return new_dept_id;
	}
	public void setNew_dept_id(String new_dept_id) {
		this.new_dept_id = new_dept_id;
	}
	public String getEmployment_type() {
		return employment_type;
	}
	public void setEmployment_type(String employment_type) {
		this.employment_type = employment_type;
	}


    public String getPrev_location_id() {
        return prev_location_id;
    }

    public void setPrev_location_id(String prev_location_id) {
        this.prev_location_id = prev_location_id;
    }

    public String getNew_location_id() {
        return new_location_id;
    }

    public void setNew_location_id(String new_location_id) {
        this.new_location_id = new_location_id;
    }
}