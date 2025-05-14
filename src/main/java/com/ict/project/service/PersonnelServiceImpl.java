package com.ict.project.service;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.PersonnelDAO;
// 작성자: 정택준
@Service
public class PersonnelServiceImpl implements PersonnelService{
	@Autowired
	private PersonnelDAO personnelDAO;
	
	@Override
	public List<Map<String, Object>> searchEmployeesByName(String searchKeyword) {
		
		return personnelDAO.searchEmployeesByName(searchKeyword);
	}

	@Override
	public List<Map<String, Object>> searchEmployeesByDepartment(String searchKeyword) {
		// TODO Auto-generated method stub
		return personnelDAO.searchEmployeesByDepartment(searchKeyword);
	}

	@Override
	public List<Map<String, Object>> searchEmployeesByPosition(String searchKeyword) {
		// TODO Auto-generated method stub
		return personnelDAO.searchEmployeesByPosition(searchKeyword);
	}
	
	// 작성자: 김용호
	@Override
    public List<Map<String, Object>> getAllVacations() {
        return personnelDAO.getAllVacations();
    }

	@Override
	public List<Map<String, Object>> getAllApprovals() {
		return personnelDAO.getAllApprovals();
	}

	@Override
	public boolean updateVacationStatuses(List<Map<String, Object>> approval) {
		try {
			Set<String> processedIds = new HashSet<>();
			for(Map<String, Object> approval1 : approval) {
				String vacationId = String.valueOf(approval1.get("vacation_id"));
				if(!processedIds.contains(vacationId)) {
					personnelDAO.updateVacationStatus(approval1);
					processedIds.add(vacationId);
				}
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 작성자: 김재겸 (05-13)
	@Override
	public Map<String, Object> getEmployeeDetails(String empIdx) {
		return personnelDAO.getEmployeeDetails(empIdx);
	}

	@Override
	public boolean updateWorkArrangement(String empIdx, String location, String attitudeType) {
    	try {
        	personnelDAO.updateWorkArrangement(empIdx, location, attitudeType);
      	  	return true;
    	} catch (Exception e) {
       	 	e.printStackTrace();
       	 	return false;
   	 	}
}
}
