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

	// 요청 휴가의 전체 목록
	public List<Map<String, Object>> getAllVacations() {
		// Changed namespace from "com.ict.project.repository.PersonnelDAO" to
		// "personnel"
		return sqlSession.selectList("personnel.getAllVacations");
	}

	// 요청휴가의 결재 대기와 결재 완료 목록
	public List<Map<String, Object>> getAllApprovals() {
		// Changed namespace
		return sqlSession.selectList("personnel.getAllApprovals");
	}

	// 결재정보 입력
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

	// 결재정보 로깅데이터 입력
	public void insertVacationLogging(RequestLoggingVO logging) {
		// Changed namespace
		sqlSession.insert("personnel.insertVacationLogging", logging);
	}

	// 개인 휴가현황
	public List<Map<String, Object>> getAllInquiry() {
		// Changed namespace
		return sqlSession.selectList("personnel.getAllInquiry");
	}

	// 개인 휴가현황
	public List<Map<String, Object>> getUserInquiry(int user_idx) {
		// Changed namespace
		return sqlSession.selectList("personnel.getUserInquiry", user_idx);
	}

	// 개인 휴가현황
	public Map<String, Object> getUserVacationDays(int user_idx) {
		// Changed namespace
		return sqlSession.selectOne("personnel.getUserVacationDays", user_idx);
	}

	// �쑕媛� 李④컧
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

	// �븳李ъ슧
	// 愿�由ъ옄�쓽 洹쇰Т吏� �씠�룞 �떊泥��쓣 諛쏆� �뀒�씠釉� 議고쉶
	public List<Map<String, Object>> getPersonChangeInfor() {
		List<Map<String, Object>> result = sqlSession.selectList("personnel.getPersonChangeInfor");

		return result;
	}

	// 愿�由ъ옄�쓽 洹쇰Т吏� �씠�룞 �듅�씤 �럹�씠吏� �듅�씤/諛섎젮 泥섎━
	public int updatePersonChangeStatus(Map<String, Object> requestData) {
		// 癒쇱� �젅肄붾뱶 議댁옱 �뿬遺� �솗�씤
		int exists = sqlSession.selectOne("personnel.checkRequestLoggingExists", requestData);
		requestData.put("recordExists", exists);
		int result = sqlSession.update("personnel.updateLoggingpersonnelChangeStatus", requestData);

		// �깉濡쒖슫 �젅肄붾뱶 �궫�엯�씤 寃쎌슦 personnelchange�룄 �뾽�뜲�씠�듃
		if (exists == 0) {
			sqlSession.update("personnel.updatePersonnelChangeLocation", requestData);
		}
		return result;
	}

	// 洹쇰Т吏� �씠�룞 �떊泥��쓣 �듅�씤 or 諛섎젮 �뻽�쓣 �븣 �긽�깭 珥덇린�솕
	public boolean resetPersonChangeStatus(Map<String, Object> requestData) {
		try {
			sqlSession.update("personnel.resetPersonChangeStatus", requestData);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// �옉�꽦�옄: 源��옱寃� (05-13)
	public Map<String, Object> getEmployeeDetails(String empIdx) {
		return sqlSession.selectOne("personnel.getEmployeeDetails", empIdx);
	}

	public void updateWorkArrangement(String empIdx, String location, String attitudeType) {
		Map<String, Object> params = new HashMap<>();
		params.put("emp_idx", empIdx);
		params.put("location", location);
		params.put("attitude_type", attitudeType);
		sqlSession.update("personnel.updateWorkArrangement", params);
	}

}