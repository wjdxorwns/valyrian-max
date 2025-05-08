package com.ict.project.common;

// 작성자: 김재겸

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginCheckInterceptor implements HandlerInterceptor{
	
	// Dispather Servlet -> Controller 하기 전에 
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 조건이 맞으면 => Controller로 넘어갈려면 true || 아니면 false
		
		// 해당 프로젝트는 로그인 성공 시 session.setAttribute("loginchk", "ok");
		HttpSession session = request.getSession(false); // 기존 세션 유지, (없으면 null로 ㄱㄱ)
		if(session==null || session.getAttribute("emp_email")==null) {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(""
					+ "<script>"
					+ "alert('로그인이 필요합니다.');"
					+ "location.href='" + request.getContextPath() + "/MainPage' ;"
					+ "</script>");
			response.getWriter().flush();
			return false;
		}
		
		return true;
	}
}
