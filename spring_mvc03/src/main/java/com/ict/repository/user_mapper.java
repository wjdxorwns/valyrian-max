package com.ict.repository;

import java.util.HashMap;
import java.util.Map;

public class user_mapper {
	private static Map<String, String> users = new HashMap<>();

    static {
        users.put("test@example.com", "1234"); // 임시 사용자
    }

    public boolean validateUser(String email, String password) {
        return users.containsKey(email) && users.get(email).equals(password);
    }
}
