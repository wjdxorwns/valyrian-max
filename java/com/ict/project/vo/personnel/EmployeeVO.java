// EmployeeVO.java
package com.ict.project.vo.personnel;

public class EmployeeVO {
    private String emp_idx;             // 직원 고유키 (VARCHAR)
    private int user_idx;               // 회원 고유 키 (int)
    private String emp_id;              // 직원 고유 코드 (VARCHAR)
    private String dept_name;           // 부서명 (ENUM) - '직원', '대기', '관리자', '슈퍼관리자' (Note: ENUM usually for DB, consider String for VO)
    private String position;            // 직책 (VARCHAR)
    private int pay_grade;              // 년차 (INT)
    private String hire_date;           // 입사일 (DATE) - String으로 변경
    private String team;                // 부서이름 (ENUM) - '인사1팀', '인사2팀', '인사3팀' (Note: ENUM usually for DB, consider String for VO)
    private String location;            // 현재 근무지 (VARCHAR)
    private String resignation_date;    // 퇴사일 (DATE) - String으로 변경
    private String attitude_type;       // 근무 방식 (ENUM) - '출장', '재택', '회사' (Note: ENUM usually for DB, consider String for VO)
    private String quitter;             // 퇴사자 (ENUM) - '입사', '퇴사', '퇴사대기' (Note: ENUM usually for DB, consider String for VO)
    private String employment_type;     // 고용 타입 (ENUM) - '정규직', '계약직', '아르바이트' (Note: ENUM usually for DB, consider String for VO)
    private String emp_name;            // Users 테이블에서 가져올 필드
    private int vacation_balance;       // 잔여 연차
    private String pay;                 // 급여 (String, consider if it should be double for actual calculations)

    public EmployeeVO() {}

    // Getter와 Setter 메소드 (Lombok 사용 권장)
    public String getEmp_idx() {
        return emp_idx;
    }

    public void setEmp_idx(String emp_idx) {
        this.emp_idx = emp_idx;
    }

    public int getUser_idx() {
        return user_idx;
    }

    public void setUser_idx(int user_idx) {
        this.user_idx = user_idx;
    }

    public String getEmp_id() {
        return emp_id;
    }

    public void setEmp_id(String emp_id) {
        this.emp_id = emp_id;
    }

    public String getDept_name() {
        return dept_name;
    }

    public void setDept_name(String dept_name) {
        this.dept_name = dept_name;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public int getPay_grade() {
        return pay_grade;
    }

    public void setPay_grade(int pay_grade) {
        this.pay_grade = pay_grade;
    }

    public String getHire_date() {
        return hire_date;
    }

    public void setHire_date(String hire_date) {
        this.hire_date = hire_date;
    }

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getResignation_date() {
        return resignation_date;
    }

    public void setResignation_date(String resignation_date) {
        this.resignation_date = resignation_date;
    }

    public String getAttitude_type() {
        return attitude_type;
    }

    public void setAttitude_type(String attitude_type) {
        this.attitude_type = attitude_type;
    }

    public String getQuitter() {
        return quitter;
    }

    public void setQuitter(String quitter) {
        this.quitter = quitter;
    }

    public String getEmployment_type() {
        return employment_type;
    }

    public void setEmployment_type(String employment_type) {
        this.employment_type = employment_type;
    }

    public String getEmp_name() {
        return emp_name;
    }

    public void setEmp_name(String emp_name) {
        this.emp_name = emp_name;
    }

    public int getVacation_balance() {
        return vacation_balance;
    }

    public void setVacation_balance(int vacation_balance) {
        this.vacation_balance = vacation_balance;
    }

    public String getPay() {
        return pay;
    }

    public void setPay(String pay) {
        this.pay = pay;
    }


    @Override
    public String toString() {
        return "EmployeeVO{" +
                "emp_idx='" + emp_idx + '\'' +
                ", user_idx=" + user_idx +
                ", emp_id='" + emp_id + '\'' +
                ", dept_name='" + dept_name + '\'' +
                ", position='" + position + '\'' +
                ", pay_grade=" + pay_grade +
                ", hire_date='" + hire_date + '\'' +
                ", team='" + team + '\'' +
                ", location='" + location + '\'' +
                ", resignation_date='" + resignation_date + '\'' +
                ", attitude_type='" + attitude_type + '\'' +
                ", quitter='" + quitter + '\'' +
                ", employment_type='" + employment_type + '\'' +
                ", emp_name='" + emp_name + '\'' +
                ", vacation_balance=" + vacation_balance +
                ", pay='" + pay + '\'' +
                '}';
    }
}