<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 사용자 값 받기
	String mode=request.getParameter("mode");
	if (mode==null)
		mode="1";
	int index=Integer.parseInt(mode);
	String jsp="";
	switch(index) {
	case 1:
		jsp="home.jsp";
		break;
	case 2:
		jsp="script.jsp";
		break;
	case 3:
		jsp="directive.jsp";
		break;
	case 4:
		jsp="object.jsp";
		break;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
.row{
	margin: 0px auto;
	width: 960px;
}
</style>
</head>
<%-- 조립식 (역할 분담) --%>
<body>
	<%
		pageContext.include("header.jsp");
	%>
	<%
		pageContext.include(jsp);
	%>
</body>
</html>