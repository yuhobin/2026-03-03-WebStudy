package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import java.util.*;
import com.sist.vo.*;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.sist.dao.*;

@Controller
public class FoodModel {
	@RequestMapping("food/list.do") // 중복되면 실행이 안된다 => 
	// 메소드 => 형식 3가지 
	/*
	 * 	Ajax ==========> void
	 * ----------------
	 * sendRedirect()	=> "redirect:../list.do"
	 * Forward()	
	 * ----------------- String "../main/main.jsp"
	 * 
	 *	핵심 기능 
	 * 	공통 기능 => 모아서 관리
	 */
	public String food_list(HttpServletRequest request, HttpServletResponse response) {
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		final int ROWSIZE=12;
		int start=(curpage*ROWSIZE)-ROWSIZE;
		List<FoodVO> list=FoodDAO.foodListData(start);
		int totalpage=FoodDAO.foodTotalPage();
		
		final int BLOCK=10;
		int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>totalpage)
			endPage=totalpage;
		
		request.setAttribute("list", list);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		request.setAttribute("main_jsp", "../food/list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("food/detail_before.do")
	public String food_detail_before(HttpServletRequest request, HttpServletResponse response) {
		String no=request.getParameter("no");
		Cookie cookie=new Cookie("food_"+no, no);
		cookie.setPath("/");
		cookie.setMaxAge(60*60*24);
		// 브라우저로 전송
		response.addCookie(cookie);
		// sendRedirect
		return "redirect:../food/detail.do?no="+no;
	}
	
	@RequestMapping("food/detail.do")
	public String food_detail(HttpServletRequest request, HttpServletResponse response) {
		String no=request.getParameter("no");
		FoodVO vo=FoodDAO.foodDetailData(Integer.parseInt(no));
		String[] addrs=vo.getAddress().split(" ");
		// 관광공사 => 위치 (위도 / 경도)
		List<FoodVO> list=FoodDAO.foodRearData(addrs[2]);
		
		request.setAttribute("list", list);
		request.setAttribute("vo", vo);
		
		request.setAttribute("main_jsp", "../food/detail.jsp");
		// include => JSP에 request가 공유
		return "../main/main.jsp";
	}
	
}
