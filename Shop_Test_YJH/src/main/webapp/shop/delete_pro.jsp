<%@page import="shop.dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp" %>
<jsp:useBean id="productDAO" class="shop.dao.ProductRepository" />
<%
	String productId = request.getParameter("productId");

	int result = productDAO.delete(productId);
	
	if (result > 0) {
		response.sendRedirect(root + "/shop/products.jsp");
	} else {
		response.sendRedirect(root + "/shop/editProducts.jsp");
	}