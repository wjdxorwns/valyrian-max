package com.ict.service;

import org.springframework.stereotype.Service;

import com.ict.repository.user_mapper;

@Service
public class LoginService {
	private user_mapper userRepository = new user_mapper();

    public boolean authenticate(String email, String password) {
        return userRepository.validateUser(email, password);
    }
}
