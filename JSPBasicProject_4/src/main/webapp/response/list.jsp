<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.sist.dao.*"%>
<%--
	page : contentType="text/html; charset=UTF-8"
						JSON : text/plain
						------------------ AJAX / VueJS / ReactJS
						XML : text/xml
			import="java.util.*, com.sist.dao.*"
			errorPage="erroe.jsp"
			Spring에서도 사용 => JSP(유지보수) => SpringBoot => ThymeLeaf
 --%>
<%
 	// 사용자로부터 요청값을 받는다 => page
 	String strPage=request.getParameter("page");
 	// 맨처음에는 페이지를 보낼 수 없다 => 디폴트 page를 설정
 	if(strPage==null)
 		strPage="1";
 	// 1. 현재 페이지 
 	int curpage=Integer.parseInt(strPage);
 	// 2. DAO 객체 생성
 	FoodDAO dao=FoodDAO.newInstance();
 	// 3. 출력할 목록을 받는다
 	List<FoodVO> list=dao.foodListData(curpage);
 	// 4. 총페이지 받기
 	int totalpage=dao.foodTotalPage();
 	
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.container {
	margin-top: 50px;
}

.row {
	margin: 0px auto;
	width: 960px;
}

p {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<%
				for(FoodVO vo:list)
				{
			%>
			<div class="col-md-3">
				<div class="thumbnail">
					<a href="detail_before.jsp?no=<%=vo.getNo()%>"> 
						<img src="<%=vo.getPoster() %>" style="width: 240px; height: 150px">
						<div class="caption">
							<p><%=vo.getName() %></p>
						</div>
					</a>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<div class="row text-center" style="margin-top: 10px">
			<a href="list.jsp?page=<%= curpage>1?curpage-1:curpage %>" class="btn btn-sm btn-primary">이전</a>
			<%=curpage %> page / <%=totalpage %> pages
			<a href="list.jsp?page=<%=curpage<totalpage?curpage+1:curpage %>" class="btn btn-sm btn-primary">다음</a>
		</div>
	</div>
</body>
</html>