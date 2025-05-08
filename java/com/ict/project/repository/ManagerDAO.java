package com.ict.project.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.PersonnelChangeVO;
import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.vo.personnel.pFile.EmpPictureVO;
import com.ict.project.vo.personnel.pFile.UsersignVO;

@Repository
public class ManagerDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	

	// 직원 정보 전체 조회
	public List<EmployeeVO> getAllEmployees() {
		try {
			return sqlSessionTemplate.selectList("manager.getAllEmployees");
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// 직원 등록
	public int insertEmployee(EmployeeVO employee) {
		try {
			return sqlSessionTemplate.insert("manager.insertEmployee", employee);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	// 유저 등록
	public int insertUser(UsersVO user) {
		try {
			return sqlSessionTemplate.insert("manager.insertUser", user);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	// 유저 서명 등록
	public int insertUserSign(UsersignVO usersign) {
		try {
			return sqlSessionTemplate.insert("manager.insertUserSign", usersign);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	// 직원 사진 등록
	public int insertEmpPicture(EmpPictureVO picture) {
		try {
			return sqlSessionTemplate.insert("manager.insertEmpPicture", picture);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	// 인사이동 등록
	public int insertPersonnelChange(PersonnelChangeVO change) {
		try {
			return sqlSessionTemplate.insert("manager.insertPersonnelChange", change);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	// 이메일 중복 확인
	public int checkEmailDuplicate(String email) {
		try {
			return sqlSessionTemplate.selectOne("manager.checkEmailDuplicate", email);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	// 사번 중복 확인
	public int checkEmpIdDuplicate(String empId) {
		try {
			return sqlSessionTemplate.selectOne("manager.checkEmpIdDuplicate", empId);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
}