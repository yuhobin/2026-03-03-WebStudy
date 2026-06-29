<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	1. MVC
	2. MyBatis
	3. JSP
	------------- Back
	4. Jquery
	5. Ajax(프로젝트 전체적으로는 ajax로 제작) : 예약 
	6. Vue(일부기능만 vue로 제작) : 검색 / 댓글
	------------------- 게시판 / 회원 가입 / 로그인 / 회원 수정 / 회원 탙퇴 
	=> 목록 페이지 / 상세보기 / 좋아요 / 찜하기 
	=> 공지사항 
	=> 관리 / 마이페이지
	   ---
	--------------------------- 최종 : ThymeLeaf + Pinia
	Next (react)
	=> CI/CD => 우분투 명령어 => AWS
	
	
	Parent = list
	   |
	Child = pagecard
		parent => Child
				값을 전송
				
				데이터가 많은 경우
				props: {
				
				}
				데이터가 1개인 경우
				props:['변수']
				
				함수 호출
				------
				emits:['함수명']
				
				<pagecard : start-page="startPage"
							@함수명="pageChange">
				parent <=====>Child
					=> camelCase => startPage
					=> -
				
		
		데이터 전송 : props
		이벤트 전달 : emit
		==================> $parent
		
		pagecard
			|
			| $emit('page-change', 5)
		  parent	<pagecard @page-change="pageChange">
		  (pageChange(5))
		    |
		   curpage=5
		    |
		   axios : 처리
		   
		  $emit을 사용하는 이유
		  	1. Child Component에서는 Parent의 데이터를 직접 변경하면 안된다
		  	   ---------------------------
		  	   Parent에서 변경
		  	2. $emit('page-change',5)
		  		=> 페이지를 5페이지를 변경해 달라
		  		=> pageChange(5)
		  		
		  	props는 parent = child로 데이터 전송 
		  	$emit child = parent 이벤트 전달하는 경우에 사용
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
.row {
  margin: 0px auto;
  width: 100%;
}
p {
   overflow: hidden;
   white-space: nowrap;
   text-overflow: ellipsis;
}
.a-link:hover{
	cursor: pointer;
}
.btn-xs {
	margin-left: 2px;
}
h3{
	text-align: center;
}
</style>
<script type="text/javascript" src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="row">
			<h3>내용보기</h3>
			<table class="table">
				<tbody>
					<tr>
						<th width="20%" class="danger text-center">번호</th>
						<td width="30%" class="text-left">{{detail.no}}</td>
						<th width="20%" class="danger text-center">작성일</th>
						<td width="30%" class="text-left">{{detail.dbday}}</td>
					</tr>
					<tr>
						<th width="20%" class="danger text-center">이름</th>
						<td width="30%" class="text-left">{{detail.name}}</td>
						<th width="20%" class="danger text-center">조회수</th>
						<td width="30%" class="text-left">{{detail.hit}}</td>
					</tr>
					<tr>
						<th width="20%" class="danger text-center">제목</th>
						<td colspan="3">{{detail.subject}}</td>
					</tr>
					<tr>
						<td colspan="4" class="text-left" valign="top" height="200">
							<pre style="white-space: pre-wrap; background: white; border: none">{{detail.content}}</pre>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="text-right">
							<a :href="'../board/update.do?no='+no" class="btn btn-xs btn-warning">수정</a>
							<span class="btn btn-xs btn-warning"
								@click="btnClick()"
							>{{isOn?'삭제':'취소'}}</span>
							<a href="../board/list.do" class="btn btn-xs btn-warning">목록</a>
						</td>
					</tr>
					<tr v-show="bShow">
						<td colspan="4" class="text-right">
							비밀번호:<input type="password" size="15" class="input-sm" ref="pwdRef" v-model="pwd">
									<!-- v-model : data()안에 있는 변수 연결 
										입력시에 바로 pwd변수에 값을 채워준다
										let pwd=$('#pwd').val() => 처리 => 단방향
									-->
									<button class="btn-sm btn-primary" @click="del()">삭제</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<script>
		let detailApp=Vue.createApp({
			// 변수설정
			data(){
				return {
					bShow:false,
					msg:'삭제',
					isOn:true,
					pwd:'',
					detail:{}, // VO 
					no:${param.no}
				}
			},
			// 자동 호출 => 생명주기 함수
			/*
				created() : Vue객체가 생성
				mounted() : 브라우저에 화면이 출력되는 경우
					window.onload=function(){} = 바닐라JS
					$(function(){})
						componentDidMount() : React
							=> useEffect
				updated() : data()안에 있는 데이터가 수정되는 경우
				unmounted() : 화면 이동 / 브라우저 종료 / 새로고침
			*/
			// 브라우저에 화면 출력전에 호출
			mounted(){
					// board/detail_vue.do?no=1
				axios.get('../board/detail_vue.do',{
					params:{
						no:this.no
					}
				}).then(response=>{
					this.detail=response.data
					console.log(response.data)
					// 실행된 결과를 자동을 첨부
				})
			},
			// 이벤트 처리 
			methods:{
				btnClick(){
					this.isOn=!this.isOn
					this.bShow=!this.bShow
				},
				del(){
					// 좌우 공백 제거
					// 비교는 권장 === (데이터형 일치)
					if(this.pwd.trim()==="") {
						this.$refs.pwdRef.focus()
						// 태그 자체를 제어 ==> ref 속성 ==> this.refs
						return
					}
					// 데이터 전송
					axios.get('../board/delete_vue.do',{
						params:{
							no:this.no,
							pwd:this.pwd
						}
					// 응답 
					/*
						response : text / json
											= text/plain
									= text/html
									
									= 요청 처리에 대한 결과값
										Model에서 처리
					*/
					}).then(response=>{
						if(response.data==='yes') {
							window.location.href="../board/list.do"
						}
						else{
							alert("비밀번호가 틀립니다!!")
							this.pwd=''
							this.$refs.pwdRef.focus()
						}
					})
				}
			}
			// components / computed => 계산식 (상품) / watch => 채팅 
			// Vue => CRUD / 페이징 / 댓글
		}).mount(".container")
	</script>
</body>
</html>