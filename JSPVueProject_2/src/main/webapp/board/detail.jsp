<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
						<td width="30%" class="text-center">{{detail.no}}</td>
						<th width="20%" class="danger text-center">작성일</th>
						<td width="30%" class="text-center">{{detail.dbday}}</td>
					</tr>
					<tr>
						<th width="20%" class="danger text-center">이름</th>
						<td width="30%" class="text-center">{{detail.name}}</td>
						<th width="20%" class="danger text-center">조회수</th>
						<td width="30%" class="text-center">{{detail.hit}}</td>
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
							<a href="#" class="btn btn-xs btn-warning">수정</a>
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
			mounted(){
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
			methods:{
				btnClick(){
					this.isOn=!this.isOn
					this.bShow=!this.bShow
				},
				del(){
					if(this.pwd.trim()==="") {
						this.$refs.pwdRef.focus()
						return
					}
					// 데이터 전송
					axios.get('../board/delete_vue.do',{
						params:{
							no:this.no,
							pwd:this.pwd
						}
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
		}).mount(".container")
	</script>
</body>
</html>