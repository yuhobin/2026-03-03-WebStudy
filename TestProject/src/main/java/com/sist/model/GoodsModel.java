package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.sist.dao.*;
import com.sist.vo.*;
import java.util.*;

@Controller
public class GoodsModel {
	@RequestMapping("goods/goods_main_ajax.do")
	public String goods_list_ajax(HttpServletRequest request, HttpServletResponse response) {
		String cno=request.getParameter("category_no");
		String page=request.getParameter("page");
		String sort = request.getParameter("sort");  
		
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		int start = (curpage - 1) * 12;   
		
		
		Map map = new HashMap();    
		map.put("category_no", Integer.parseInt(cno));  
		map.put("start", start);   
		map.put("sort", sort);         

		List<GoodsVO> list = GoodsDAO.goodsListData(map);    
		int totalPage = GoodsDAO.goodsTotalPage(Integer.parseInt(cno));        

		//request.setAttribute("list", list);   
		request.setAttribute("main_jsp", "../goods/goods_main");
		 //return "../goods/goods_main_ajax.jsp"; 
		return "../main/main.jsp";
	}
}
