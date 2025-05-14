package com.ict.project.repository;

import java.util.Collections;
import java.util.HashMap; // HashMap import 추가
import java.util.List;
import java.util.Map; // Map import 추가

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.project.vo.management.PermissionVO;
import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.PersonnelChangeVO;
import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.vo.personnel.VacationVO;
import com.ict.project.vo.personnel.pFile.EmpPictureVO;
import com.ict.project.vo.personnel.pFile.UsersignVO;

@Repository
public class ManagerDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private static final String NAMESPACE = "manager";

	// 직원 정보 전체 조회
		public List<EmployeeVO> getAllEmployees() {
			try {
				return sqlSessionTemplate.selectList("manager.getAllEmployees");
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
				return 0;
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
				throw new RuntimeException("직원 사진 등록 중 오류가 발생했습니다.", e);
			}
		}
		
		
		
		// 서명 등록
		public void insertUsersign(UsersignVO usersign) {
			try {
				sqlSessionTemplate.insert("manager.insertUsersign", usersign);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// 요청 등록
		public void insertRequest(EmployeeVO employee) {
			try {
				sqlSessionTemplate.insert("manager.insertRequest", employee);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// 권한 등록
		public void insertPermission(EmployeeVO employee) {
			try {
				sqlSessionTemplate.insert("manager.insertPermission", employee);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// permission 테이블에서 emp_idx 제거
			public int removePermission(String emp_idx) {
		    return sqlSessionTemplate.delete("manager.removePermission", emp_idx);
		}
		
		
		// 직원아이디(email) 중복 확인
		public int countByEmail(String email) {
			try {
				return sqlSessionTemplate.selectOne("manager.checkEmailDuplicate", email);
			} catch (Exception e) {
				e.printStackTrace();
				return 0;
			}
		}

		// 직원번호(emp_id) 중복 확인
		public int countByEmpId(String empId) {
			try {
				return sqlSessionTemplate.selectOne("manager.checkEmpIdDuplicate", empId);
			} catch (Exception e) {
				e.printStackTrace();
				return 0;
			}
		}

		// 전화번호 중복 확인
		public int countByPhoneNumber(String phoneNumber) {
			try {
				return sqlSessionTemplate.selectOne("manager.checkPhoneNumberDuplicate", phoneNumber);
			} catch (Exception e) {
				e.printStackTrace();
				return 0;
			}
		}
		// employee 테이블 업데이트
		public int updateEmployee(EmployeeVO employee) {
		    return sqlSessionTemplate.update("manager.updateEmployee", employee);
		}
		// user 테이블 업데이트
		public int updateUser(Map<String, Object> param) {
		    return sqlSessionTemplate.update("manager.updateUser", param);
		}
		// 사진 테이블 업데이트
		public int updateProfileImage(EmpPictureVO picture) {
		    return sqlSessionTemplate.update("manager.updateProfileImage", picture);
		}

		

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

		// 직원 상세 정보 조회 (통합)
		public Map<String, Object> getEmployeeDetail(String emp_idx) {
			try {
				return sqlSessionTemplate.selectOne("manager.getEmployeeDetail", emp_idx);
			} catch (Exception e) {
				e.printStackTrace();
				return Collections.emptyMap();
			}
		}

		// 사용자 정보 조회
		public UsersVO getUserByEmpIdx(String emp_idx) {
			try {
				return sqlSessionTemplate.selectOne("manager.getUserByEmpIdx", emp_idx);
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}

		


		// 휴가 정보 조회
		public VacationVO getVacationByEmpIdx(String emp_idx) {
			try {
				return sqlSessionTemplate.selectOne("manager.getVacationByEmpIdx", emp_idx);
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}


		// 권한 정보 조회
		public PermissionVO getPermissionByEmpIdx(String emp_idx) {
			try {
				return sqlSessionTemplate.selectOne("manager.getPermissionByEmpIdx", emp_idx);
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}
		
		// 직원 상세 조회
		public Map<String, Object> getEmployeeById(String emp_idx) {
			System.out.println("DAO emp_idx: " + emp_idx);
		    return sqlSessionTemplate.selectOne("manager.getEmployeeById", emp_idx);
		    
		}
		 // 퇴사시 직원 리스트에서 블라 처리
		public List<Map<String, Object>> getResignEmployees() {
		    return sqlSessionTemplate.selectList("manager.getResignEmployees");
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

 	
 	public List<UsersVO> getEmpIdSearch(UsersVO uVO) {
        try {
            return sqlSessionTemplate.selectList("manager.idList", uVO);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

	public List<Map<String, Object>> getSearchResign() {
		return sqlSessionTemplate.selectList("manager.resignList");
	}





	public List<Map<String, Object>> getSearchKeyWord(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("manager.keyword",paramMap);
	}


	public void updateQuitter(Map<String, Object> paramMap) {
		sqlSessionTemplate.update("manager.update",paramMap);
	}


	public void updateUserRemove(Map<String, Object> paramMap) {
		sqlSessionTemplate.update("manager.updateUserRemove",paramMap);
		
	}


}