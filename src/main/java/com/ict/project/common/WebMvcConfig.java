package com.ict.project.common;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginCheckInterceptor())
                .addPathPatterns("/**")  // 모든 경로에 대해 인터셉터 적용
                .excludePathPatterns(     // 제외할 경로 설정
                    "/login",            // 로그인 페이지
                    "/resources/**",     // 정적 리소스
                    "/css/**",          // CSS 파일
                    "/js/**",           // JavaScript 파일
                    "/images/**",       // 이미지 파일
                    "/error"            // 에러 페이지
                );
    }
} 