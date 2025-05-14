package com.ict.project.service;

import java.io.InputStream;
import java.util.Properties;

public class EmailUtil {
    private static Properties props = new Properties();
    
    static {
        try {
            InputStream input = EmailUtil.class.getClassLoader().getResourceAsStream("mail.properties");
            if (input == null) {
                throw new IllegalStateException("mail.properties file not found in classpath (src/main/resources)");
            }
            props.load(input);
            input.close();
            System.out.println("mail.properties loaded successfully: " + props);
        } catch (Exception e) {
            System.err.println("Failed to load mail.properties: " + e.getMessage());
            e.printStackTrace();
            throw new IllegalStateException("Cannot load mail.properties", e);
        }
    }
    
    public static String get(String key) {
        String value = props.getProperty(key);
        if (value == null) {
            System.err.println("Property not found in mail.properties: " + key);
            throw new IllegalStateException("Property not found: " + key);
        }
        return value;
    }
}