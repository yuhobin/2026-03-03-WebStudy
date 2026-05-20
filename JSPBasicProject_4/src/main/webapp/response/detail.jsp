<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.sist.dao.*"%>
<%
	String no=request.getParameter("no");
	FoodDAO dao=FoodDAO.newInstance();
	FoodVO vo=dao.foodDetailData(Integer.parseInt(no));
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
#image {
	width: 100%;
	height: 350px;
	object-fit: cover;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<table class="table">
				<tbody>
					<tr>
						<td width=30% class="text-center" rowspan="8">
							<img src="<%=vo.getPoster()%>" id="image" class="img-rounded">
						</td>
						<td colspan="2">
							<h3><%=vo.getName() %>&nbsp;
								<span style="color:orange;"><%=vo.getScore() %></span></h3>
						</td>
					</tr>
					<tr>
						<th class="text-center" style="color:gray" width=15%>음식종류</th>
						<td width=55%><%=vo.getType() %></td>
					</tr>
					<tr>
						<th class="text-center" style="color:gray" width=15%>주소</th>
						<td width=55%><%=vo.getAddress() %></td>
					</tr>
					<tr>
						<th class="text-center" style="color:gray" width=15%>전화</th>
						<td width=55%><%=vo.getPhone() %></td>
					</tr>
					<tr>
						<th class="text-center" style="color:gray" width=15%>가격대</th>
						<td width=55%><%=vo.getPrice() %></td>
					</tr>
					<tr>
						<th class="text-center" style="color:gray" width=15%>영업시간</th>
						<td width=55%><%=vo.getTime() %></td>
					</tr>
					<tr>
						<th class="text-center" style="color:gray" width=15%>주차</th>
						<td width=55%><%=vo.getParking() %></td>
					</tr>
					<tr>
						<th class="text-center" style="color:gray" width=15%>테마</th>
						<td width=55%><%=vo.getTheme() %></td>
					</tr>
					<tr>
						<td colspan="3"><%=vo.getContent() %></td>
					</tr>
					<tr>
						<td colspan="3" class="text-right">
							<a href="list.jsp" class="btn btn-xs btn-success">목록</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>