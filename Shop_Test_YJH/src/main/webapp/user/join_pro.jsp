<!-- 
	회원 가입 처리
 -->
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	User user = new User();
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String pwConfirm = request.getParameter("pw_confirm");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String birth = year + "-" + month + "-" + day;  // 생년월일을 "YYYY-MM-DD" 형식으로 합치기
	
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String email = email1 + "@" + email2;  // 이메일 주소 합치기
	
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	// user 객체 세팅
	user.setId(id);
	user.setPassword(pw);
	user.setName(name);
	user.setGender(gender);
	user.setBirth(birth);
	user.setMail(email);
	user.setPhone(phone);
	user.setAddress(address);
	
	// 회원 등록 요청
	UserRepository userRepository = new UserRepository();
	int result = userRepository.insert(user);
	
	String root = request.getContextPath();
	// 가입성공
	if( result > 0 ) {
		response.sendRedirect(root + "/user/complete.jsp?msg=1");
	}
	// 가입실패
	else {
		response.sendRedirect(root + "/user/join.jsp?error");
	}

	
	
%>
    
    

    
    
    
    
    
    