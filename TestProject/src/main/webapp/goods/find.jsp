<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 상품 리스트 페이지 전용 스타일 --%>
<style>
.product-card {
	position: relative;
}

.product-card .like-btn {
	position: absolute;
	right: 12px;
	bottom: 12px;
	background: #fff;
	border-radius: 50%;
	width: 34px;
	height: 34px;
	display: flex;
	align-items: center;
	justify-content: center;
	box-shadow: 0 1px 4px rgba(0, 0, 0, .15);
	cursor: pointer;
	border: none;
}

.product-card .thumb-box {
	background: #f5f5f5;
	border-radius: 8px;
	overflow: hidden;
	aspect-ratio: 1/1;
	display: flex;
	align-items: center;
	justify-content: center;
}

.product-card .thumb-box img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.product-brand {
	font-size: 13px;
	color: #888;
	margin-top: 10px;
}

.product-name {
	font-size: 14px;
	color: #222;
	margin: 2px 0;
}

.product-price {
	font-size: 16px;
	font-weight: 700;
}

.product-meta {
	font-size: 12px;
	color: #999;
}

/* 페이지네이션 */
.pagination {
	display: inline-flex;
	list-style: none;
	gap: 6px;
	padding: 0;
	margin: 0 auto;
}

.pagination li a {
	display: block;
	padding: 8px 14px;
	color: #333;
	text-decoration: none;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.pagination li.active a {
	background: #000;
	color: #fff;
	border-color: #000;
}
</style>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

</head>
<body>
<div id="product-list-box">
	
	<div class="row">
       <div class="col-12">
        <select class="input-sm" v-model="column">
        	<option value="category_name">카테고리</option>
        	<option value="goods_name">상품명</option>
        </select>
        <input type="text" size="20" class="input-sm" v-model="fd" @keydown.enter="find()" ref="findRef">
        <button type="button" class="btn-sm btn-primary" @click="find()">검색</button>
       </div>
    </div>
    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-4">
        <div class="col">
            <div class="product-card">
                <a :href="'../goods/detail.do?goods_no='vo.goods_no">
                    <div class="thumb-box">
                        <img :src="vo.poster_url" alt="">
                    </div>
                </a>
                <button type="button" class="like-btn">
                    <svg width="18" height="18" viewBox="0 0 24 24">
                        <use xlink:href="#heart"></use>
                    </svg>
                </button>
                <div class="product-brand">{{vo.brand_name}}</div>
                <div class="product-name">{{vo.goods_name}}</div>
                <div class="product-price">{{vo.goods_price}}</div>
                <div class="product-meta">
                    <svg width="12" height="12" viewBox="0 0 24 24">
                    <use xlink:href="#heart"></use>
                    </svg>
                    {{vo.like_count}}
                    <svg width="12" height="12" viewBox="0 0 12 12">
                    <use xlink:href="#star-solid"></use>
                    </svg>
                    {{vo.hit}}
                </div>
            </div>
        </div>
       
    </div>

    <div class="row text-center" style="margin-top: 40px">
        <div class="d-flex justify-content-center">
           <ul class="pagination">
             <li class="page-item" v-if="startPage>1">
                <a class="page-link" @click="pageChange(startPage-1)"><i class="fa fa-angle-double-left" aria-hidden="true"></i>이전</a>
             </li>
			 <li  
               v-for="i in range(startPage,endPage)" 
                :class="i==curpage?'active':'' + page-item"  
             ><a class="page-link" @click="pageChange(i)">{{i }}</a></li>
             <li class="page-item" v-if="endPage<totalpage">
               <a class="page-link" @click="pageChange(endPage+1)">다음 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
             </li>
                              
          </ul>
        </div>
    </div>
</div>
<script>
let findApp=Vue.createApp({
	data(){
		return {
			column:'카테고리',
			fd:'스포츠',
			curpage:1,
			totalpage:0,
			startPage:0,
			endPage:0,
			list:[]
		}
	},
	// 서버 연결
	mounted(){
		this.dataRecv()
	},
	methods:{
		async dataRecv(){
			await axios.get('../goods/find_vue.do',{
				params:{
					page:this.curpage,
					column:this.column,
					fd:this.fd
				}
			}).then(response=>{
				this.list=response.data.list
				this.curpage=response.data.curpage
				this.totalpage=response.data.totalpage
				this.startPage=response.data.startPage
				this.endPage=response.data.endPage
				this.fd=response.data.fd
				this.column=response.data.column
				console.log(response)
			})
		},
		find(){
			if(this.fd.trim()==="") {
				this.$refs.findRef.focus()
				// $().focus()랑 같음
				return
			}
			this.curpage=1
			this.dataRecv()
		},
		range(start,end) {
			let arr=[]
			let len=end-start
			for(let i=0; i<=len; i++) {
				arr[i]=start
				start++
			}
			return arr
		},
		pageChange(page){
			this.curpage=page
			this.dataRecv()
		}
	}
}).mount("#findApp")
</script>

</body>
</html>