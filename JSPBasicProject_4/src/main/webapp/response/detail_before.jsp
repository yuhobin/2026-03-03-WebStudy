<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// response => 기능 : 쿠키 전송 / HTML 전송 / 화면 이동 
	// 사용자가 보내준 데이터 받기 => no
	String no=request.getParameter("no");
	Cookie cookie=new Cookie("food_"+no,no); // Map 형식
	// 1. 저장 기간
	cookie.setMaxAge(60*60*24);
	// 2. 브라우저로 전송
	response.addCookie(cookie);
	// 3. 화면 이동 => detail.jsp
	response.sendRedirect("detail.jsp?no="+no);
	
%>