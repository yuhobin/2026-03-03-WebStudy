package com.sist.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import com.sist.dao.*;
import java.util.*;

@WebServlet("/EmpList")
public class EmpList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 결과값을 브라우저에 어떤 형식으로 전송 : html
		response.setContentType("text/html;charset=UTF-8");
		// 어떤 메모리에 저장할지 설정 => 출력 버퍼 
		PrintWriter out=response.getWriter();
		// response안에는 해당 브라우저의 IP를 가지고 있다
		// 기억: Servlet은 각 클라이언트 당 1개씩 생성 => 쓰레드로 되어 있다
		// DAO 연결
		EmpDAO dao=new EmpDAO();
		List<EmpVO> list=dao.empListData(1);
		// HTML 이용해서 화면 출력
		out.println("<html>");
		out.println("<head>");
		out.println("<style type=\"text/css\">");
		out.println("table {");
		out.println("margin: 50px auto;");
		out.println("}");
		out.println("</style>");
		out.println("</head>");
		out.println("<body>");
		out.println("<table border=1 bordercolor=black width=500>");
		out.println("<tr>");
		out.println("<th>사번</th>");
		out.println("<th>이름</th>");
		out.println("<th>직위</th>");
		out.println("<th>입사일</th>");
		out.println("<th>급여</th>");
		out.println("<th>부서명</th>");
		out.println("<th>근무지</th>");
		out.println("</tr>");
		for(EmpVO vo:list) {
			out.println("<tr>");
			out.println("<td>"+vo.getEmpno()+"</td>");
			out.println("<td>"+vo.getEname()+"</td>");
			out.println("<td>"+vo.getJob()+"</td>");
			out.println("<td>"+vo.getDbday()+"</td>");
			out.println("<td>"+vo.getSal()+"</td>");
			out.println("<td>"+vo.getDvo().getDname()+"</td>");
			out.println("<td>"+vo.getDvo().getLoc()+"</td>");
			out.println("</tr>");
		}
		out.println("<tr>");
		out.println("</tr>");
		out.println("</table>");
		out.println("</body>");
		out.println("</html>");
		
	}
	/*
	 * 	단점 : HTML 구현이 어렵다 
	 * 			CSS / JavaScript 첨부가 어렵다 
	 * 			---------------- 분리 => JSP
	 * 	Servlet		JSP
	 * 	-------		----
	 * 				2. HTML / CSS / JavaScript
	 * 	1. 자바가 편리
	 * 	
	 * 	=> 자바 : 서블릿
	 * 	=> HTML / CSS / JavaScript 
	 */

}
