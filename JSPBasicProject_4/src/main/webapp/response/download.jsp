<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*, java.net.*"%>
<%
	String fn=request.getParameter("fn");
	String path="c:\\javaDev";
	try{
		response.setHeader("Content-Disposition", "attachment;filename="
							+URLEncoder.encode(fn, "UTF-8"));
		File file=new File(path+"\\"+fn);
		response.setContentLength((int)file.length());
		// 프로그래스바
		BufferedInputStream bis=new BufferedInputStream(new FileInputStream(file));
		BufferedOutputStream bos=new BufferedOutputStream(response.getOutputStream());
		byte[] buffer=new byte[1024];
		int i=0;
		while((i = bis.read(buffer, 0, buffer.length)) != -1) {
		    bos.write(buffer, 0, i);
		}
		bis.close();
		bos.close();
		out.clear();
		out=pageContext.push();
	}catch(Exception e){
		
	}
%>
