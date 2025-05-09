package com.ict.project.common;

// 작성자: 김재겸

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

public class LoginCheckInterceptor implements HandlerInterceptor {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginCheckInterceptor.class);
	
	// Dispather Servlet -> Controller 하기 전에 
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 조건이 맞으면 => Controller로 넘어갈려면 true || 아니면 false
		
		// 해당 프로젝트는 로그인 성공 시 session.setAttribute("loginchk", "ok");
		HttpSession session = request.getSession(false);
		
		// 세션이 없거나 로그인 체크 값이 없는 경우
		if (session == null) {
			logger.warn("Session is null");
			sendRedirect(request, response);
			return false;
		}
		
		// 세션 속성 체크
		String loginChk = (String) session.getAttribute("loginchk");
		String empEmail = (String) session.getAttribute("emp_email");
		String empIdx = (String) session.getAttribute("emp_idx");
		
		// 세션 정보 로깅
		logger.debug("Session check - loginchk={}, emp_email={}, emp_idx={}", 
			new Object[]{loginChk, empEmail, empIdx});
			
		if (loginChk == null || !"ok".equals(loginChk) || empEmail == null || empIdx == null) {
			logger.warn("Invalid session attributes - loginchk={}, emp_email={}, emp_idx={}", 
				new Object[]{loginChk, empEmail, empIdx});
			sendRedirect(request, response);
			return false;
		}
		
		// 로그인 된 상태
		logger.info("Authorized access - User: {}", empEmail);
		return true;
	}
	
	private void sendRedirect(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().write(
			"<script>" +
			"alert('로그인이 필요합니다.');" +
			"location.href='" + request.getContextPath() + "/login';" +
			"</script>"
		);
	}
}
