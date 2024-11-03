<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();

	String phone = request.getParameter("phone");
	String orderPw = request.getParameter("orderPw");
	
	OrderRepository orderRepository = new OrderRepository();
	
	// 비회원 주문 내역 세션에 등록 처리
	List<Product> orderList = orderRepository.list(phone, orderPw);
	
	if( orderList != null && !orderList.isEmpty()) {
		session.setAttribute("orderList", orderList);
		session.setAttribute("orderPhone", phone);
		
	response.sendRedirect(root + "/user/order.jsp");
	
	} else {
		out.println("<script type='text/javascript'>");
        out.println("alert('주문 내역을 찾을 수 없습니다. 다시 시도해주세요.');");
        out.println("window.location.href='" + root + "/user/order.jsp';"); // 주문 내역 페이지로 리다이렉트
        out.println("</script>");
	}

%>