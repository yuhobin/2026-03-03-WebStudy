package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.BoardDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.sist.vo.*;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;
/*
 * 	main
 * 		-------------------------------------------------
 * 						메뉴
 * 		-------------------------------------------------
 * 
 * 			<jsp:include page="${main_jsp}"></jsp:include>
 * 
 * 
 * 
 * 		-------------------------------------------------
 * 						footer
 * 		-------------------------------------------------
 * 
 * 
 * 
 *  main
 * 		-------------------------------------------------
 * 						메뉴 header
 * 		-------------------------------------------------
 * 				|
 * 				|<jsp:include page="${mypage_jsp}"></jsp:include> 이중 include 페이지 안에 부메뉴로 진입할때 (홈에서 클릭해서 들어가서 사이드 메뉴바)
 * 				|
 * 				|
 * 				|
 * 		-------------------------------------------------
 * 						footer
 * 		-------------------------------------------------
 */
@Controller
public class BoardModel {
	// 사용자 정의 메소드는 반드시 호출
	@RequestMapping("board/list.do")
	public String board_list(HttpServletRequest request, HttpServletResponse response) {
		// DB 연동 => 
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		// 요청 처리
		int curpage=Integer.parseInt(page);
		final int ROWSIZE=10;
		int start=(ROWSIZE*curpage)-ROWSIZE;
		List<BoardVO> list=BoardDAO.boardListData(start);
		int count=BoardDAO.boardTotalPage();
		int totalpage=(int)(Math.ceil(count/ROWSIZE));
		count=count-((curpage*ROWSIZE)-ROWSIZE);
		// 요청 결과값을 JSP로 전송
		request.setAttribute("list", list);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("count", count);
		/*
		 *  Date date=new Date();
		 *  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		 *  String today=sdf.format(date)
		 */
		request.setAttribute("today", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		
		request.setAttribute("main_jsp", "../board/list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("board/insert.do")
	public String board_insert(HttpServletRequest request, HttpServletResponse response) {
		
		request.setAttribute("main_jsp", "../board/insert.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("board/insert_ok.do")
	public String board_insert_ok(HttpServletRequest request, HttpServletResponse response) {
		String name=request.getParameter("name");
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		String pwd=request.getParameter("pwd");
		
		BoardVO vo=new BoardVO();
		vo.setName(name);
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setPwd(pwd);
		
		/*
		 * System.out.println(name); System.out.println(subject);
		 * System.out.println(content); System.out.println(pwd);
		 */
		
		BoardDAO.boardInsert(vo); 
		
		return "redirect:../board/list.do";
	}
	@RequestMapping("board/detail.do")
	public String board_detail(HttpServletRequest request, HttpServletResponse response) {
		/*
		 * 	데이터를 보내주는 경우 
		 * 	데이터를 안보내주는 경우 : 페이지 / 검색어
		 */
		// 사용자가 보낸 데이터 받기
		String no=request.getParameter("no");
		// 데이터 베이스 연동
		BoardVO vo=BoardDAO.boardDetailData(Integer.parseInt(no));
		// 결과값(출력할 데이터) 전송
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../board/detail.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("board/delete.do")
	public void board_delete(HttpServletRequest request, HttpServletResponse response) {
		String no=request.getParameter("no");
		String pwd=request.getParameter("pwd");
		
		// DB 연동
		String res=BoardDAO.boardDelete(Integer.parseInt(no), pwd);
		try {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.write(res);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// yes / no 전송
	}
	@RequestMapping("board/update.do")
	public void board_update(HttpServletRequest request, HttpServletResponse response) {
		String name=request.getParameter("name");
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		String pwd=request.getParameter("pwd");
		String no=request.getParameter("no"); 
		
		BoardVO vo=new BoardVO();
		vo.setName(name);
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setPwd(pwd);
		vo.setNo(Integer.parseInt(no));
		
		String res=BoardDAO.boardUpdate(vo);
		try {
			response.setContentType("text/html;char=UTF-8");
			PrintWriter out=response.getWriter();
			out.write(res);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
}
