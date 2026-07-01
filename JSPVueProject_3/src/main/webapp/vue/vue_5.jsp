<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%--
	댓글 추가 시 
	=> 기존 댓글을 다시 랜더링이 안되게 만든다
		<div v-for="reply in replyList" :key="reply.no"
			v-memo="[reply.no, reply.msg]">
			{{reply.msg}}
		</div>
		=> 채팅 
 --%>
	<div class="app">
	
	</div>
	<script>
		let app=Vue.createApp({
			data(){
				return {
					
				}
			}
		}).mount('.app')
	</script>
</body>
</html>