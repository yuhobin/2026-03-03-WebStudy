<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
	application : ServletContext
	서버 정보 / 자원 정보 / 로그 정보
	서버 정보		6.0
		= 서블릿 버전 
			getMajorVersion()
			getMinorVersion()
			getServerInfo()
	자원 정보 
		= ***getRealPath() : 실제 저장되는 위치 
	로그 정보 
		= log
		= getInitParameter()
		
	request / response / session
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	버전 : <%= application.getMajorVersion() %>
	버전 : <%= application.getMinorVersion() %> <br>
	<%= application.getMajorVersion()+"."+application.getMinorVersion() %>
	<%-- 서블릿 버전 --%>
	<br>
	서버이름: <%= application.getServerInfo() %> <br>
	<%
		// web.xml 파일 읽기
		String driver=application.getInitParameter("driver");
		String url=application.getInitParameter("url");
		String user=application.getInitParameter("username");
		String pwd=application.getInitParameter("password");
		
		application.log("driver:"+driver);
		application.log("url:"+url);
		application.log("username:"+user);
		application.log("password:"+pwd);
	%>
	***<%=application.getRealPath("/") %>
	
</body>
</html>	