// PersonnelDAO.java
package com.ict.project.repository;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.vo.management.RequestLoggingVO;

@Repository
public class PersonnelDAO {

	@Autowired
	private SqlSession sqlSession;

	// --- Vacation Related Methods ---
	// 신청 된 모든 휴가
	public List<Map<String, Object>> getAllVacations() {
		// Changed namespace from "com.ict.project.repository.PersonnelDAO" to
		// "personnel"
		return sqlSession.selectList("personnel.getAllVacations");
	}

	// 휴가 승인 대기
	public List<Map<String, Object>> getAllApprovals() {
		// Changed namespace
		return sqlSession.selectList("personnel.getAllApprovals");
	}

	// 휴가 승인 상태 업데이트 (승인/반려)
	public void updateVacationStatus(Map<String, Object> approval) {
		// Changed namespace
		sqlSession.update("personnel.updateVacationStatus", approval);
	}
	public void updateRequestVacationStatus(Map<String, Object> params) {
	    sqlSession.update("personnel.updateRequestVacationStatus", params);
	}
	public boolean resetVacationRequest(int requestIdx) {
    	return sqlSession.update("personnel.resetVacationRequest", requestIdx) > 0;
    }

	// 휴가 승인 데이터 로그 삽입
	public void insertVacationLogging(RequestLoggingVO logging) {
		// Changed namespace
		sqlSession.insert("personnel.insertVacationLogging", logging);
	}

	// 개인 휴가 현황 (Overall Inquiry - though controller only uses getUserInquiry)
	public List<Map<String, Object>> getAllInquiry() {
		// Changed namespace
		return sqlSession.selectList("personnel.getAllInquiry");
	}

	// 특정 사용자 휴가 현황
	public List<Map<String, Object>> getUserInquiry(int user_idx) {
		// Changed namespace
		return sqlSession.selectList("personnel.getUserInquiry", user_idx);
	}

	// 특정 사용자 잔여 연차 조회
	public Map<String, Object> getUserVacationDays(int user_idx) {
		// Changed namespace
		return sqlSession.selectOne("personnel.getUserVacationDays", user_idx);
	}

	// 휴가 차감
	public void deductVacationDays(Map<String, Object> approval) {
		// Changed namespace
		sqlSession.update("personnel.deductVacationDays", approval);
	}

	public List<Map<String, Object>> searchEmployeesByName(String searchKeyword) {
		return sqlSession.selectList("personnel.findByEmpNameContaining", searchKeyword);
	}

	public List<Map<String, Object>> searchEmployeesByDepartment(String searchKeyword) {
		return sqlSession.selectList("personnel.findByDeptNameContaining", searchKeyword);
	}

	public List<Map<String, Object>> searchEmployeesByPosition(String searchKeyword) {
		return sqlSession.selectList("personnel.findByPositionContaining", searchKeyword);
	}

	public Map<String, Object> serchpaydetail(String emp_idx) {
		return sqlSession.selectOne("personnel.paydtail", emp_idx);
	}

	public List<Map<String, Object>> serchpaylist(Map<String, Object> params) {
		return sqlSession.selectList("personnel.payList", params);
	}

	public int insertPay(Map<String, Object> params) {
		return sqlSession.insert("personnel.payinsert", params);
	}

	public int updatePay(Map<String, Object> params) {
		return sqlSession.update("personnel.updatePay", params);
	}

	public boolean isPayRecordExists(String emp_idx, Date payment_date) {
		Map<String, Object> param = new HashMap<>();
		param.put("emp_idx", emp_idx);
		param.put("payment_date", payment_date);
		Integer count = sqlSession.selectOne("personnel.checkPayRecord", param);
		return count != null && count > 0;
	}

	public void updateEmployeePay(Map<String, Object> params) {
		sqlSession.update("personnel.updateEmployeePay", params);
	}

	public List<Map<String, Object>> serchpaylistAll(String emp_idx) {
		return sqlSession.selectList("personnel.payListAll", emp_idx);
	}

	public void updateLatestSalary(Map<String, Object> params) {
		sqlSession.update("personnel.updateLatestSalary", params);
	}

	public Map<String, Object> getLatestSalary(String emp_idx) {
		return sqlSession.selectOne("personnel.getLatestSalary", emp_idx);
	}

	public void updatePayById(Map<String, Object> params) {
		sqlSession.update("personnel.updatePayById", params);
	}

	// 작성자: 김재겸 (05-13)
	public Map<String, Object> getEmployeeDetails(String empIdx) {
		return sqlSession.selectOne("personnel.getEmployeeDetails", empIdx);
	}

	public void updateWorkArrangement(String empIdx, String location, String attitudeType, String team) {
        Map<String, Object> params = new HashMap<>();
        params.put("emp_idx", empIdx);
        params.put("location", location);
        params.put("attitude_type", attitudeType);
        params.put("team", team);
        sqlSession.update("personnel.updateWorkArrangement", params);
    }

	
	public List<Map<String, Object>> getSalaryListByIds(List<Integer> salaryIds) {
	    return sqlSession.selectList("personnel.getSalaryListByIds", salaryIds);
	}
	
	// 휴가 신청 Request 테이블 삽입
    public int insertVacationRequest(Map<String, Object> params) {
        return sqlSession.update("personnel.insertVacationRequest", params);
    }

    // 휴가 정보 Vacation 테이블 삽입
    public void insertVacation(Map<String, Object> params) {
        sqlSession.insert("personnel.insertVacation", params);
    }
	
	public int getRequestIdx(String emp_idx) {
		return sqlSession.selectOne("personnel.getRequestIdx", emp_idx);
	}

}