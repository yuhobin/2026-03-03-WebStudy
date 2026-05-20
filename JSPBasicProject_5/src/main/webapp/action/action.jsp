<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	
	JSP 액션 태그
	<jsp:~>
	--------
	***<jsp:include> : 특정 위치에 다른 JSP를 추가 => pageContext
					   ---------------------
					   	<th:include file="">
	<jsp:forward> : 파일 이동  => request를 유지
					request를 가지고 있는 jsp => URL
	<jsp:useBean> : 객체 생성
	<jsp:setProperty> : setXxx에 값을 자동으로 채워준다
	<jsp:getProperty> : getXxx를 호출 
	<jsp:param> : 추가적인 데이터가 있는 경우

 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- 화면 변경은 동일 --%>
	<a href="redirect.jsp?id=admin&name=홍길동">redirect전송</a>
	<p>
	<a href="forward.jsp?id=admin&name=홍길동">forward전송</a>
</body>
</html>