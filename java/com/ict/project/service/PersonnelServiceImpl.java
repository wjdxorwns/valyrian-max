package com.ict.project.service;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.PersonnelDAO;

@Service
public class PersonnelServiceImpl implements PersonnelService{
	
	@Autowired
    private PersonnelDAO personnelDAO;

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

}
