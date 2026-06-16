<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.row {
	margin: 0px auto;
	width: 800px;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
	// 처음에 모든 수정창 숨기기
	$('.ups').hide();
	
	$('.updateBtns').on('click',function(){
		// 내가 누른 버튼의 댓글 번호(no) 가져오기
		let no = $(this).attr("data-no");
		
		// 지금 누른 대상의 수정창(#up+no)을 찾음
		let targetForm = $('#up' + no);
		
		// 현재 그 수정창이 눈에 보이는지 확인 (숨겨져 있으면 true, 보이고 있으면 false)
		if(targetForm.is(':hidden')) {
			// 열기 전에 다른 열려있는 수정창들을 싹 닫고 버튼도 '수정'으로 되돌림
			$('.ups').hide();
			$('.updateBtns').text("수정");
			
			// 내 것만 열고 글자를 '취소'로 변경
			$(this).text("취소");
			targetForm.show("slow");
		}
		else {
			// 이미 열려있었다면 닫고 글자를 '수정'으로 변경
			$(this).text("수정");
			targetForm.hide();
		}
	});
});
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<table class="table">
				<tr>
					<td width=40% class="text-center" rowspan="8"><img
						src="${vo.poster }"
						style="width: 320px; height: 350px; object-fix: cover'"></td>
					<td colspan="2">
						<h3>${vo.name }&nbsp;<span style="color: orange;">${vo.score }</span>
						</h3>
					</td>
				</tr>
				<tr>
					<td width=10%>주소</td>
					<td width=50%>${vo.address }</td>
				</tr>
				<tr>
					<td width=10%>전화</td>
					<td width=50%>${vo.phone }</td>
				</tr>
				<tr>
					<td width=10%>음식종류</td>
					<td width=50%>${vo.type }</td>
				</tr>
				<tr>
					<td width=10%>가격대</td>
					<td width=50%>${vo.price }</td>
				</tr>
				<tr>
					<td width=10%>주차</td>
					<td width=50%>${vo.parking }</td>
				</tr>
				<tr>
					<td width=10%>영업시간</td>
					<td width=50%>${vo.time }</td>
				</tr>
				<tr>
					<td width=10%>테마</td>
					<td width=50%>${vo.theme }</td>
				</tr>
				<tr>
					<td colspan="3">${vo.content }</td>
				</tr>
				<tr>
					<td colspan="3" class="text-right"><a href="../main/main.do"
						class="btn btn-xs btn-info">목록</a></td>
				</tr>
			</table>
		</div>
		<div class="row" style="margin-top: 10px">
			<h3>댓글</h3>
			<hr>
			<c:if test="${rcount<1 }">
				<table class="table">
					<tr>
						<td class="text-center">댓글이 없습니다</td>
					</tr>
				</table>
			</c:if>
			<c:if test="${rcount>0 }">
				<table class="table">
					<tr>
						<td><c:forEach var="rvo" items="${rList }">
								<table class="table">
									<tr>
										<td class="text-left">◑ ${rvo.name } (${rvo.dbday})</td>
										<td class="text-right"><c:if
												test="${rvo.id==sessionScope.id }">
												<span class="btn btn-xs btn-success updateBtns" data-no="${rvo.no}">수정</span>
												<a href="../reply/delete.do?no=${rvo.no}&fno=${vo.no}" class="btn btn-xs btn-info">삭제</a>
											</c:if></td>
									</tr>
									<tr>
										<td style="white-space: pre-wrap;" colspan="2">${rvo.msg}</td>
									</tr>
									<tr style="display:none" class="ups" id="up${rvo.no}">
										<td colspan="2">
											<table class="table">
												<form method=post action="../reply/update.do">
													<tr>
														<td>
															<input type="hidden" name="fno" value="${vo.no}">
															<input type="hidden" name="no" value="${rvo.no}">
															<textarea rows="4" cols="70" style="float: left"
																name="msg">${rvo.msg}</textarea>
															<button type=submit class="btn-primary"
																style="width: 100px; height: 92px; float: left">댓글수정</button>
														</td>
													</tr>
												</form>
											</table>
										</td>
									</tr>
								</table>
							</c:forEach></td>
					</tr>
				</table>
			</c:if>
			<c:if test="${sessionScope.id!=null }">
				<table class="table">
					<form method=post action="../reply/insert.do">
						<tr>
							<td><input type="hidden" name="fno" value="${vo.no }">
								<textarea rows="4" cols="80" style="float: left" name="msg"></textarea>

								<button type=submit class="btn-primary"
									style="width: 100px; height: 92px; float: left">댓글쓰기</button></td>
						</tr>
					</form>
				</table>
			</c:if>
		</div>
	</div>
</body>
</html>