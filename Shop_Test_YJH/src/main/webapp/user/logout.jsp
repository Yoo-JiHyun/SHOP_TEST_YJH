<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.PersistentLogin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	// 자동 로그인, 토큰 쿠키 삭제
	Cookie cookieRememberMe = new Cookie("rememberMe", "");
	Cookie cookieToken = new Cookie("token", "");
	cookieRememberMe.setPath("/");
	cookieToken.setPath("/");
	cookieRememberMe.setMaxAge(0);
	cookieToken.setMaxAge(0);
	response.addCookie(cookieRememberMe);
	response.addCookie(cookieToken);
	
	PersistentLogin persistentLogin = new PersistentLogin();
	String loginId = (String) session.getAttribute("loginId");
	UserRepository userDAO = new UserRepository();
	if( loginId != null ) {
		boolean deleted = userDAO.deleteToken("loginId");
		
		if( deleted ) out.println("인증 토큰 데이터 삭제 성공!");
		else 		  out.println("인증 토큰 데이터 삭제 실패!");
		
	}
	// 세션 무효화
	session.invalidate();
	
	// 쿠키 전달
	response.sendRedirect("../index.jsp");
%>