package com.ict.project.repository;

import java.util.Collections;
import java.util.HashMap; // HashMap import 추가
import java.util.List;
import java.util.Map; // Map import 추가

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.vo.personnel.pFile.EmpPictureVO;

@Repository
public class ManagerDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private static final String NAMESPACE = "manager";

	// 직원 정보 전체 조회 (Map 형태로 반환)
	public List<Map<String, Object>> getAllEmployees(String searchType, String keyword) {
		try {
			Map<String, Object> params = new HashMap<>();
			params.put("searchType", searchType);
			params.put("keyword", keyword);
			return sqlSessionTemplate.selectList("manager.getAllEmployees", params);
		} catch (Exception e) {
			e.printStackTrace();
			return Collections.emptyList();
		}
	}

	// emp_idx 중복 확인
	public int checkEmpIdxDuplicate(String emp_idx) {
		try {
			return sqlSessionTemplate.selectOne("manager.checkEmpIdxDuplicate", emp_idx);
		} catch (Exception e) {
			e.printStackTrace();
			return 0; // 예외 발생 시 중복 아님으로 간주
		}
	}

	// 직원 등록
	public void insertEmployee(EmployeeVO employee) {
		try {
			sqlSessionTemplate.insert("manager.insertEmployee", employee);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 유저 등록
	public void insertUser(UsersVO user) {
		try {
			sqlSessionTemplate.insert("manager.insertUser", user);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 직원 사진 등록
	public void insertEmpPicture(EmpPictureVO vo) {
		try {
			sqlSessionTemplate.insert("manager.insertEmpPicture", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 직원아이디(email) 중복 확인
	public int countByEmail(String email) {
		try {
			return sqlSessionTemplate.selectOne("manager.checkEmailDuplicate", email);
		} catch (Exception e) {
			e.printStackTrace();
			return 0; // 실패 시 기본값
		}
	}

	// 직원번호(emp_id) 중복 확인
	public int countByEmpId(String empId) {
		try {
			return sqlSessionTemplate.selectOne("manager.checkEmpIdDuplicate", empId);
		} catch (Exception e) {
			e.printStackTrace();
			return 0; // 실패 시 기본값
		}
	}

	// 중복확인
	public int countByPhoneNumber(String phoneNumber) {
		try {
			return sqlSessionTemplate.selectOne("manager.checkPhoneNumberDuplicate", phoneNumber);
		} catch (Exception e) {
			e.printStackTrace();
			return 0; // 실패 시 기본값
		}
	}
	
	public List<Map<String, Object>> getAllPermissionList() {
		try {
			return sqlSessionTemplate.selectList(NAMESPACE + ".list");
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
 	
 	public void updatePermissions(String userId, Map<String, Integer> permissions) {
        try {
            sqlSessionTemplate.update(NAMESPACE + ".updatePermissions", Map.of("userId", userId, "permissions", permissions));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}