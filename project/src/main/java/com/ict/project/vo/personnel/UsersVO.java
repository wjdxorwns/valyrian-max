package com.ict.project.vo.personnel;

public class UsersVO {
    private int user_idx;           // 회원 고유 키 (int)
    private String emp_email;       // 이메일 (VARCHAR)
    private String emp_name;        // 직원 이름 (VARCHAR)
    private String emp_password;    // 비밀번호 (VARCHAR)
    private String home;            // 집주소 (VARCHAR)
    private String detail_home;     // 상세 집주소 (VARCHAR)
    private String phone_number;    // 휴대전화번호 (VARCHAR)
    private int gender;             // 성별 (TINYINT)
    private String birthday;        // 생일 (DATE) - String으로 변경
    private int remove;             // 삭제 (TINYINT)

    public UsersVO() {}

    // 모든 필드를 포함하는 생성자 (선택 사항)
    public UsersVO(int user_idx, String emp_email, String emp_name, String emp_password,
                   String home, String detail_home, String phone_number, int gender,
                   String birthday, int remove) {
        this.user_idx = user_idx;
        this.emp_email = emp_email;
        this.emp_name = emp_name;
        this.emp_password = emp_password;
        this.home = home;
        this.detail_home = detail_home;
        this.phone_number = phone_number;
        this.gender = gender;
        this.birthday = birthday;
        this.remove = remove;
    }
    
    public int getUser_idx() {
        return user_idx;
    }

    public void setUser_idx(int user_idx) {
        this.user_idx = user_idx;
    }

    public String getEmp_email() {
        return emp_email;
    }

    public void setEmp_email(String emp_email) {
        this.emp_email = emp_email;
    }

    public String getEmp_name() {
        return emp_name;
    }

    public void setEmp_name(String emp_name) {
        this.emp_name = emp_name;
    }

    public String getEmp_password() {
        return emp_password;
    }

    public void setEmp_password(String emp_password) {
        this.emp_password = emp_password;
    }

    public String getHome() {
        return home;
    }

    public void setHome(String home) {
        this.home = home;
    }

    public String getDetail_home() {
        return detail_home;
    }

    public void setDetail_home(String detail_home) {
        this.detail_home = detail_home;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public int getRemove() {
        return remove;
    }

    public void setRemove(int remove) {
        this.remove = remove;
    }

    @Override
    public String toString() {
        return "UsersVO{" +
                "user_idx=" + user_idx +
                ", emp_email='" + emp_email + '\'' +
                ", emp_name='" + emp_name + '\'' +
                ", emp_password='" + emp_password + '\'' +
                ", home='" + home + '\'' +
                ", detail_home='" + detail_home + '\'' +
                ", phone_number='" + phone_number + '\'' +
                ", gender=" + gender +
                ", birthday='" + birthday + '\'' +
                ", remove=" + remove +
                '}';
    }
}