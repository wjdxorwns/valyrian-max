package com.ict.project.service;

import java.util.List;
import java.util.Map;

import com.ict.project.vo.personnel.VacationVO;

public interface PersonnelService {
	
	List<Map<String, Object>> getAllVacations();
	List<Map<String, Object>> getAllApprovals();
	boolean updateVacationStatuses(List<Map<String, Object>> approval);

}
