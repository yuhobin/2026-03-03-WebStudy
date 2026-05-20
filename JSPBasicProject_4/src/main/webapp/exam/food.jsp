<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
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
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/vue@3"></script>
</head>
<body>
  <div class="container">
   <div class="row">
     <input type=text size=20 class="input-sm" v-model="address">
     <button class="btn-sm btn-success" @click="find()">검색</button>
   </div>
   <div class="row" style="margin-top: 10px">
     <div class="col-md-3" v-for="vo in list">
	    <div class="thumbnail">
	      <a href="#">
	        <img :src="vo.poster" style="width:240px;height: 150px">
	        <div class="caption">
	          <p>{{vo.name}}</p>
	        </div>
	      </a>
	    </div>
	  </div>
   </div>
   <div class="row text-center" style="margin-top: 10px">
     <button class="btn-sm btn-primary">이전</button>
     <button class="btn btn-sm btn-primary">다음</button>
   </div>
  </div>
  <script>
   let findApp=Vue.createApp({
	   data(){
		  return {
			   list:[],
			   curpage:1,
			   totalpage:0,
			   address:'마포'
		  }
	   },
	   mounted(){
		  this.dataRecv()
	   },
	   methods:{
		    dataRecv(){
			   axios.get('find.jsp',{
				   params:{
					   page:this.curpage,
					   address:this.address
				   }
			   }).then(response=>{
				   console.log(response.data)
				   this.list=response.data.list
				   this.curpage=response.data.curpage
				   this.totalpage=response.data.totalpage
			   })
		    },
			find(){
				   
				   this.curpage=1
				   this.dataRecv();
			   }
	   
	  }
   }).mount('.container')
  </script>
</body>
</html>