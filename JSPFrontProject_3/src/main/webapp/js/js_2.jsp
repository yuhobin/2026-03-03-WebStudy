<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	내장 객체 
	Number 
		parseInt() : 숫자 변환
		toLocalString() => 1000
	String 
		문자열 인덱스 번호 => 0번 부터 
		=> 자바와 동일 
		length() : 문자 개수 => 비밀번호 유효성 검사 => 입력이 되었는지 
		indexOf / lastIndexOf => 문자위치 찾기
		replace() => 문자 변경
		replaceAll() => 정규식 변경
		split() => []
		subStirng(startIndex, endIndex) : 문자를 자르는 경우
							  -------- endIndex-1
			=> substr(start, count) : 오라클 
							 ----- 개수
		trim() : 좌우 공백 제거 
		startsWith / endsWith / contains(X) => ***includes
	Array
		push() : 데이터 첨부 (마지막)
		pop() : 데이터 삭제 (마지막)
		slice() : 원하는 위치에서 데이터를 잘라서 새로운 배열 생성
		length() : 배열에 저장된 데이터 개수
		find() : 배열 찾기
	Date : 날짜 시간 관리
		let today=new Date()
		year : today.getFullYear()
		month : today.getMonth() => 0부터
		date : today.getDate()
		day : 요일 => today.getDay()
		----------------- fullcalendar : 라이브러리
		
	Math
		round() / ceil()
	BOM (브라우저 내장 객체)
		window : open / close
		location : href ==> 화면 이동 sendRedirect()
		history : back() / go(-1)
		document : 객체모델 선택자 / 화면 출력
					| querySelector()
		=> alert
		
		-------------------------------------라이브러리화 : Jquery
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
// 예약, 결제일 => SYSDATE
// 댓글
window.onload=function(){
	/*let today=new Date()
	let year=today.getFullYear()
	let month=today.getMonth()+1
	let day=today.getDate()
	let week=today.getDay()
	let strWeek=["일","월","화","수","목","금","토"]
	document.write("<h1>오늘은 "+year+"년 "+month+"월 "+day+"일 "+strWeek[week]+"요일</h1>")*/
	
	// 1. String 
	// split
	let str='red, black, green, blue, yellow, pink'
	let colors=str.split(",")
	let html='<ul>'
	colors.forEach((color)=>{
		html+='<li>'+color+'</li>'
	})
	html+='</ul>'
	document.body.innerHTML=html
}
</script>
</head>
<body>

</body>
</html>