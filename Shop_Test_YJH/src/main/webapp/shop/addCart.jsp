<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="productDAO" class="shop.dao.ProductRepository" />

<%
    // 세션에서 로그인한 사용자 ID 확인
    String loginId = (String) session.getAttribute("loginId");
    String productId = request.getParameter("id");

    // 해당 상품 정보 가져오기
    Product product = productDAO.getProductById(productId);
    
    // 장바구니 리스트 가져오기
    ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartList");
    
    // 장바구니가 없으면 새로 생성
    if (cartList == null) {
        cartList = new ArrayList<>();
    }

    // 상품이 이미 장바구니에 있는지 확인
    boolean productExists = false;
    for (Product item : cartList) {
        if (item.getProductId().equals(product.getProductId())) {
            item.setQuantity(item.getQuantity() + 1); // 수량 증가
            productExists = true;
            break;
        }
    }

    // 장바구니에 없으면 상품 추가
    if (!productExists) {
        product.setQuantity(1); // 처음 추가 시 수량 1로 설정
        cartList.add(product);
    }

    // 장바구니 리스트를 세션에 저장
    if (loginId != null) {
        session.setAttribute("loginId", cartList);
    } else {
        session.setAttribute("user", cartList);
    }

    // 상품 목록 페이지로 리디렉션
    response.sendRedirect("product.jsp");
%>