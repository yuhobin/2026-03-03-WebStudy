<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%--
    JSP =>  Java 코딩은 <% %> 영역을 벗어나면 일반 텍스트 (문자열)
    => 위치 속성
     static : 태그의 코딩에 따라 순서대로 배치  = 디폴트
     relative : 상대 좌표에 따라 이용 (옆에 있는 태그 기준점)
     absolute : 절대 좌표
     fixed : 고정 좌표
     sticky : 스크롤시마다 고정 
   => 위치 설정 
   		top / left / right / bottom
   		
   => 유동 속성 
   		float => 메뉴 / 버튼 => left / right
   		z-index => 레이어 개념 => 채팅창 / 상담창
   -----------------------------------------------
 --%>
 <%
 	List<String> images=new ArrayList();
 	images.add("../images/m1.jpg");
 	images.add("../images/m2.jpg");
 	images.add("../images/m3.jpg");
 	images.add("../images/m4.jpg");
 	images.add("../images/m5.jpg");
 	
 	List<String> key=new ArrayList();
 	key.add("a");
 	key.add("b");
 	key.add("c");
 	key.add("d");
 	key.add("e");
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
div.wrap{
	width: 900px;
	height: 900px;
	border: 1px solid red;
	position: absolute;
}
img {
	width: 200px;
	height: 200px;
	position: absolute;
}
.a{
	top: 0px;
	left: 0px;
}
.b{
	top: 0px;
	right: 0px;
}
.c{
	bottom: 0px;
	left:0px;
}
.d{
	bottom: 0px;
	right: 0px;
}
.e{
	top: 350px;
	left: 350px;
}
</style>
</head>
<body>
	<h1>Absolute</h1>
	<div class="wrap"> <!-- wrap / wrapper / container -->
		<%
			for(int i=0; i<images.size(); i++) {
		%>
			<img src="<%=images.get(i) %>" class="<%=key.get(i)%>">
		<%
			}
		%>
	</div>
</body>
</html>