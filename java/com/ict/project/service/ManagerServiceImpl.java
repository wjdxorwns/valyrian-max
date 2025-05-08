package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.project.repository.ManagerDAO;
import com.ict.project.vo.personnel.EmployeeVO;
import com.ict.project.vo.personnel.PersonnelChangeVO;
import com.ict.project.vo.personnel.UsersVO;
import com.ict.project.vo.personnel.pFile.EmpPictureVO;
import com.ict.project.vo.personnel.pFile.UsersignVO;

@Service
public class ManagerServiceImpl implements ManagerService{
	@Autowired
    private ManagerDAO managerDAO;


    @Override
    public void registerEmployee(EmployeeVO employee, UsersVO user, UsersignVO usersign,
                                 EmpPictureVO picture, PersonnelChangeVO change) {
        managerDAO.insertEmployee(employee);
        managerDAO.insertUser(user);
        managerDAO.insertUserSign(usersign);
        managerDAO.insertEmpPicture(picture);
        managerDAO.insertPersonnelChange(change);
    }

    @Override
    public List<EmployeeVO> getAllEmployees() {
        return managerDAO.getAllEmployees();
    }

}