<%@page import="com.sist.dao.BoardDAO"%>
<%@page import="com.sist.dao.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 화면 출력 (X) ==> 사용자 요청값을 받아서 처리
	// 데이터 4개
	String name=request.getParameter("name");
	String subject=request.getParameter("subject");
	String content=request.getParameter("content");
	String pwd=request.getParameter("pwd");
	
	BoardVO vo=new BoardVO();
	vo.setName(name);
	vo.setSubject(subject);
	vo.setContent(content);
	vo.setPwd(pwd);
	
	// 오라클 전송
	BoardDAO dao=new BoardDAO();
	dao.boardInsert(vo);
	
	// 화면 이동
	response.sendRedirect("list.jsp");
	
%>