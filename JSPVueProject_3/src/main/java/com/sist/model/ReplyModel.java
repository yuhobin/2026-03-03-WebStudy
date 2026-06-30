package com.sist.model;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.commons.Commons;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import java.util.*;
import com.sist.dao.*;
import com.sist.vo.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReplyModel {
	public void listData(int cno, int rno, HttpServletResponse response) {
		Map map=new HashMap();
		map.put("cno", cno);
		map.put("rno", rno);
		// mapper에서 WHERE cno=#{cno} AND rno=#{rno} 에 들어가는 값
		
		List<ReplyVO> list=ReplyDAO.replyListData(map);
		for(ReplyVO vo:list) {
			vo.setUMsg(vo.getMsg());
		}
		try {
			ObjectMapper mapper=new ObjectMapper();
			String json=mapper.writeValueAsString(list);
			
			Commons.sendData(response, "text/plain", json);
		} catch (Exception e) {}
	}
	@RequestMapping("reply/list_vue.do")
	public void reply_list_vue(HttpServletRequest request, HttpServletResponse response) {
		String cno=request.getParameter("cno");
		String rno=request.getParameter("rno");
		
		listData(Integer.parseInt(cno), Integer.parseInt(rno), response);
	}
	@RequestMapping("reply/insert_vue.do")
	public void reply_insert(HttpServletRequest request, HttpServletResponse response) {
		// => cno/rno
		String cno=request.getParameter("cno");
		String rno=request.getParameter("rno");
		String msg=request.getParameter("msg");
		
		//#{cno}, #{rno}, #{id}, #{name}, #{msg}
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		String name=(String)session.getAttribute("name");
		
		// 상태 관리 => 변수값 유지
		// Cookie (클라이언트 브라우저) : 문자열 / Session (서버) : Object
		
		ReplyVO vo=new ReplyVO();
		vo.setCno(Integer.parseInt(cno));
		vo.setRno(Integer.parseInt(rno));
		
		vo.setMsg(msg);
		vo.setId(id);
		vo.setName(name);
		
		ReplyDAO.replyInsert(vo);
		
		listData(Integer.parseInt(cno), Integer.parseInt(rno), response);
	}
	/*
	 * 	전송값 / 데이터베이스 / 응답값  따져보기
	 * 	채팅 ==> 챗봇 => 생성형 
	 */
	@RequestMapping("reply/delete_vue.do")
	public void reply_delete(HttpServletRequest request, HttpServletResponse response) {
		String cno=request.getParameter("cno");
		String rno=request.getParameter("rno");
		String no=request.getParameter("no");
		
		ReplyDAO.replyDelete(Integer.parseInt(no));
		listData(Integer.parseInt(cno), Integer.parseInt(rno), response);
	}
	@RequestMapping("reply/update_vue.do")
	public void reply_update(HttpServletRequest request, HttpServletResponse response) {
		String cno=request.getParameter("cno");
		String rno=request.getParameter("rno");
		String no=request.getParameter("no");
		String msg=request.getParameter("msg");
		ReplyVO vo=new ReplyVO();
		vo.setNo(Integer.parseInt(no));
		vo.setMsg(msg);
		
		ReplyDAO.replyUpdate(vo);
		listData(Integer.parseInt(cno), Integer.parseInt(rno), response);
	}
}
