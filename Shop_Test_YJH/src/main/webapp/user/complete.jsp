<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" /> <jsp:include page="/layout/link.jsp" />
	<link rel="stylesheet" href="/static/css/style.css">
</head>
<body>   
	<% 
		String root = request.getContextPath();
		String msg = request.getParameter("msg");
		String loginId = (String) session.getAttribute("loginId");
	%>
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">회원 정보</h1>
		
	</div>
	<!-- 회원 가입/수정/탈퇴 완료 -->
	<div class="container mb-5">
		<%
			if( msg.equals("1") ) {
		%>
			<h1 class="text-center">회원 가입이 완료되었습니다.</h1>
			<br>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
			<a href="../index.jsp" class="btn btn-primary btn-lg px-4 gap-3">메인 화면</a>
			</div>
		<%
			}
		%>
	</div>
	
	<div class="container mb-5">
		<%
			if( msg.equals("0") ) {
		%>
			<h1 class="text-center"><%= loginId %>님 환영 합니다.</h1>
			<br>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
			<a href="../index.jsp" class="btn btn-primary btn-lg px-4 gap-3">메인 화면</a>
			</div>
		<%
			}
		%>
	</div>
	
	<div class="container mb-5">
		<%
			if( msg.equals("2") ) {
		%>
			<h1 class="text-center">회원 정보가 수정되었습니다.</h1>
			<br>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
			<a href="../index.jsp" class="btn btn-primary btn-lg px-4 gap-3">메인 화면</a>
			</div>
		<%
			}
		%>
	</div>
	
	<div class="container mb-5">
		<%
			if( msg.equals("3") ) {
		%>
			<h1 class="text-center">회원 정보가 삭제되었습니다.</h1>
			<br>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
			<a href="../index.jsp" class="btn btn-primary btn-lg px-4 gap-3">메인 화면</a>
			</div>
			
		<%
			}
		%>
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>







