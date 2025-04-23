package com.ict.project.service;

import com.ict.project.vo.personnel.UserVO;

public interface Nor_Service {

    UserVO login(String empEmail, String empPassword);

}