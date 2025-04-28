package com.ict.project.service;

import org.springframework.stereotype.Service;

import com.ict.project.repository.User_mapper;

@Service
public class LoginService {
	private User_mapper userRepository = new User_mapper();

    public boolean authenticate(String email, String password) {
        return userRepository.validateUser(email, password);
    }
}
