<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" buffer="16kb" %>
<%--
	out : jspWriter
		=> HTML을 저장하는 메모리 공간 (출력버퍼)를 관리하는 클래스
		| JSP 실행 요청 
				|
			   톰캣(WAS => JSP/Servlet을 번역하는 엔진)
			   1) JSP => 자바파일로 변경 
			   		class a_jsp extends HttpServlet
			   		{
			   			JSP에 출력한 모든 내용
			   			public void _jspService
			   			{
			   				// HTML 태그
			   				out.write("<!DOCTYPE html>");
			   				..
			   				..
			   				..
			   				..
			   			}
			   		}
			   2) 컴파일 => 서블릿 파일 생성
			   3) 실행을 하면 메모리에 
			   		<!DOCTYPE html>
			   		<html> -----------------> 브라우저에서 실행
			   		
			   		** 사용자당 출력버퍼는 한개만 생성
			   		** 브라우저에서 읽어 가면 ==> 자동으로 reflush(autoFlash)
			   4) 출력버퍼의 크기는 8kb 
			   5) 주요 메소드 
			  		println() / print() / write() => <%= %>
			  		버퍼 크기 확인 : getBufferSize()
			  		남아있는 버퍼 : getRemaining()
			  		<%= %> ==> ${} (EL)
			  		최대한으로 <% %> => 제거 => 태그형 프로그램 : JSTL
			  		
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>전체 버퍼 크기: <%=out.getBufferSize() %></h3>
	<h3>남아있는 버퍼 : <%=out.getRemaining() %></h3>
	<h3>사용중인 버퍼 크기: <%=out.getBufferSize() - out.getRemaining() %></h3>
	<%
		int a=10;
		if(a%2==0){
	%>
		짝수입니다
	<%
		}
		else {
	%>
		홀수입니다
	<%	
		}
	%>
	<p>
	<%
		int b=11;
		if(b%2==0){
			out.write("짝수입니다");
		}else{
			out.write("홀수입니다");
		}
	%>
	<p>
	<%
		out.println("<h1>JSP</h1>");
		out.println("<h1>JSP</h1>");
		out.println("<h1>JSP</h1>");
		out.println("<h1>JSP</h1>");
		out.println("<h1>JSP</h1>");
		out.println("<h1>JSP</h1>");
		out.println("<h1>JSP</h1>");
		
	%>
	<%--
		<%= %> : out.print() 으로 변경
	 --%>
</body>
</html>