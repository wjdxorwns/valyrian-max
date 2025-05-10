package com.ict.project.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.repository.PersonnelDAO;


@Service
public class PersonnelServiceImpl implements PersonnelService {

    @Autowired
    private PersonnelDAO personnelDAO;

    @Override
    public List<Map<String, Object>> searchEmployeesByName(String searchKeyword) {
        return personnelDAO.searchEmployeesByName(searchKeyword);
    }

    @Override
    public List<Map<String, Object>> searchEmployeesByDepartment(String searchKeyword) {
        return personnelDAO.searchEmployeesByDepartment(searchKeyword);
    }

    @Override
    public List<Map<String, Object>> searchEmployeesByPosition(String searchKeyword) {
        return personnelDAO.searchEmployeesByPosition(searchKeyword);
    }

    @Override
    public Map<String, Object> serchpaydetail(String emp_idx) {
        return personnelDAO.serchpaydetail(emp_idx);
    }

    @Override
    public List<Map<String, Object>> serchpaylist(Map<String, Object> params) {
        return personnelDAO.serchpaylist(params);
    }

    @Override
    public int insertPay(Map<String, Object> params) {
        return personnelDAO.insertPay(params);
    }

    @Override
    public int updatePay(Map<String, Object> params) {
        return personnelDAO.updatePay(params);
    }

    @Override
    public boolean isPayRecordExists(String emp_idx, Date payment_date) {
        return personnelDAO.isPayRecordExists(emp_idx, payment_date);
    }

    @Override
    public void updateEmployeePay(Map<String, Object> params) {
        personnelDAO.updateEmployeePay(params);
    }

	@Override
	public List<Map<String, Object>> serchpaylistAll(String emp_idx) {
		return personnelDAO.serchpaylistAll(emp_idx);
	}

	@Override
	public void updateLatestSalary(Map<String, Object> updateParams) {
	    personnelDAO.updateLatestSalary(updateParams);
	}

	@Override
	public Map<String, Object> getLatestSalary(String emp_idx) {
		return personnelDAO.getLatestSalary(emp_idx);
	}

	@Override
	public void updatePayById(Map<String, Object> params) {
	    personnelDAO.updatePayById(params);
	}


	
	

}
