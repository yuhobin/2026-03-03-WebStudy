<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	함수 응용 : 영화 진흥원 => JSON으로 전송
	--------------------------------
	
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.container{
	margin-top: 50px;
}
.row{
	margin:  0px auto;
	width: 960px;
} 
</style>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript">
// 변수 선언 => 전역변수
let movie=[]
window.onload=function(){
	movieList(1)
	/*
	searchMainDailyBoxOffice.do
	searchMainRealTicket.do
	searchMainDailySeatTicket.do
	https://www.kobis.or.kr/kobis/business/main/
	*/
}
function movieList(no){
	// 서버 연결 movie_list.do?no=1
	axios.get('movie_list.do',{
		params:{
			no:no
		}
	// response= out.write(json)
	}).then(response=>{
		// response => JSON / 일반 문자열
		movie=response.data
		console.log(movie)
		// <tbody> 데이터 전송
		let html="";
		movie.forEach((m)=>{
			html+='<tr onmouseover="movieDetail('+m.rank+')">'
				+'<td class="text-center">'+m.rank+'</td>'
				+'<td class="text-center"><img src="https://www.kobis.or.kr'+m.thumbUrl+'" width=50 height=50></td>'
				+'<td>'+m.movieNm+'</td>'
				+'<td>'+m.director+'</td>'
				+'<td>'+m.genre+'</td>'
			+'</tr>'
		})
		document.querySelector('#list tbody').innerHTML=html
	})
}
// function movieDetail(mno)
// const movieDetail(mno)
// const movieDetail=function(mno)
function movieDetail(mno){
	let table=document.querySelector("#detail")
	table.style.display=''
	let m=movie.find(m=>m.rank===mno)
	console.log(m)
	let img=document.querySelector("#poster")
	img.src="https://www.kobis.or.kr"+m.thumbUrl
	
	let name=document.querySelector("#name")
	name.textContent=m.movieNm
	// $('#name').text(m.movieNm)  => Jquery
	let director=document.querySelector("#director")
	director.textContent=m.director
	let genre=document.querySelector("#genre")
	genre.textContent=m.genre
	let grade=document.querySelector("#grade")
	grade.textContent=m.watchGradeNm
	let story=document.querySelector("#story")
	story.textContent=m.synop
	
}
/*
 * 	1. 함수 호출
 		언제 호출하느냐
 			= onclick => button / img
 			= onmouseover / onmouseout
 			= onchange
 			= onkeydown / onkeyup
 	2. 이벤트 처리
	 		= onclick => button / img
			= onmouseover / onmouseout
			= onchange
			= onkeydown / onkeyup
 	3. 태그 읽기 => DOM
 			***document.querySelector(CSS 선택자)
 			document.getElementById(ID명) => id
 			document.getElementByClassName(class명) => class
 			document.getElementByTagName(태그명) => Tag이름 읽기
 			
 			바닐라JS => 순수하게 JavaScript만 이용해서 처리
 */
</script>
</head>
<body>
	<div class="container">
		<div class="row text-center">
			<h1 class="text-left">KOBIS 영화관통합전산망</h1>
			<button class="btn=lg btn-warning" onclick="movieList(1)">박스오피스</button>
			<button class="btn=lg btn-info" onclick="movieList(2)">실시간 예매율</button>
			<button class="btn=lg btn-success" onclick="movieList(3)">좌석 점유율</button>
		</div>
		<div class="row" style="margin-top: 20px">
			<div class="col-sm-8">
				<table class="table" id="list">
					<thead>
						<tr class="success">
							<th class="text-left">순위</th>
							<th class="text-left"></th>
							<th class="text-left">영화명</th>
							<th class="text-left">감독</th>
							<th class="text-left">장르</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
			<div class="col-sm-4">
				<table class="table" id="detail" style="display:none">
					<tbody>
						<tr>
							<td colspan="2" class="text-center">
							<img src="" style="width: 250px; height: 292px; object-fit:cover" id="poster">
						</tr>
						<tr>
							<td width="25%">영화명</td>
							<td width="75%" id="name"></td>
						</tr>
						<tr>
							<td width="25%">감독</td>
							<td width="75%" id="director"></td>
						</tr>
						<tr>
							<td width="25%">장르</td>
							<td width="75%" id="genre"></td>
						</tr>
						<tr>
							<td width="25%">등급</td>
							<td width="75%" id="grade"></td>
						</tr>
						<tr>
							<td colspan="2" id="story"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>