<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 상품 리스트 페이지 전용 스타일 --%>
<style>
.category-menu a {
	display: block;
	padding: 8px 0;
	color: #888;
	text-decoration: none;
	font-size: 15px;
}

.category-menu a:hover {
	color: #000;
}

.category-menu a.active {
	color: #000;
	font-weight: 700;
}

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
<script>
$(function() {
    let currentCno = 1;
    let currentPage = 1;

    function getProductList(cno, sortVal, pageNum) {
        currentPage = pageNum;
        
        $.ajax({
            type: 'GET',
            url: '../goods/goods_main_ajax.do',
            data: { category_no: cno, sort: sortVal, page: pageNum },
            success: function(res) {
                $('#product-card').html(res);
            },
            error: function() {
                alert("데이터를 불러오는 중 오류가 발생했습니다.");
            }
        });
    }

    // 1. 카테고리 버튼 클릭 이벤트 핸들러
    $(document).on('click', '.category-btn', function() {
        $('.category-btn').removeClass('btn-primary').addClass('btn-light');
        $(this).removeClass('btn-light').addClass('btn-primary');
        
        currentCno = $(this).attr('data-cno');
        let sortVal = $('#sort-select').val();
        getProductList(currentCno, sortVal, 1); // 카테고리 바뀌면 무조건 1페이지로
    });

    // 2. 정렬 셀렉트박스 변경 이벤트 핸들러
    $(document).on('change', '#sort-select', function() {
        let sortVal = $(this).val();
        getProductList(currentCno, sortVal, 1); // 정렬 바뀌면 무조건 1페이지로
    });

    // 3. 하단 페이지네이션 번호 클릭 이벤트 핸들러
    $(document).on('click', '.page-link-btn', function(e) {
        e.preventDefault();
        let targetPage = $(this).attr('data-page');
        let sortVal = $('#sort-select').val();
        
        getProductList(currentCno, sortVal, targetPage); // 보던 조건 유지한 채 페이지만 이동
    });
});
</script>
</head>
<body>
<div class="container mt-5">
    <h2>상품 쇼핑몰</h2>
    <hr>
    
   
    <div class="category-menu mb-4">
    	<!-- <button type="button" class="btn btn-primary category=btn" data-cno="0">All</button> -->
        <button type="button" class="btn btn-primary category-btn" data-cno="1">스포츠화</button>
        <button type="button" class="btn btn-light category-btn" data-cno="2">구두/로퍼</button>
        <button type="button" class="btn btn-light category-btn" data-cno="3">샌들/슬리퍼</button>
    </div> 
    <div class="d-flex justify-content-end mb-3">
        <select class="form-select" id="sort-select" style="width: 150px;">
            <option value="default">최신등록순</option>
            <option value="price_asc">낮은가격순</option>
            <option value="price_desc">높은가격순</option>
            <option value="hit_desc">조회수순</option>
        </select>
    </div>

    <div id="product-card">
        
        <div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-4">
            <c:forEach var="vo" items="${list}">
                <div class="col">
                    <div class="card h-100 product-card shadow-sm">
                        <a href="../goods/detail.do?goods_no=${vo.goods_no}">
                            <div class="img-box" style="height: 200px; overflow: hidden; background: #f8f9fa;">
                                <img src="${vo.poster_url}" class="card-img-top w-100 h-100" style="object-fit: cover;">
                            </div>
                        </a>
                        <div class="card-body d-flex flex-column justify-content-between">
                            <div>
                                <span class="badge bg-secondary mb-2">${vo.brand_name}</span>
                                <h5 class="card-title text-truncate" style="font-size: 0.95rem; font-weight: 600;" title="${vo.goods_name}">
                                    ${vo.goods_name}
                                </h5>
                            </div>
                            <div class="mt-2">
                                <p class="card-text text-danger fw-bold mb-2" style="font-size: 1.1rem;">${vo.goods_price}원</p>
                                <div class="d-flex justify-content-between text-muted" style="font-size: 0.8rem;">
                                    <span>${vo.like_count}</span>
                                    <span>${vo.hit}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
		<!-- 페이지네이션  -->
        <div class="row text-center" style="margin-top: 40px">
            <div class="d-flex justify-content-center">
                <ul class="pagination">
                    <c:set var="startPage" value="1" />
                    <c:set var="endPage" value="${totalpage > 10 ? 10 : totalpage}" />
                    
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <li class="page-item ${i == 1 ? 'active' : ''}">
                            <a class="page-link page-link-btn" href="#" data-page="${i}">${i}</a>
                        </li>
                    </c:forEach>
                    
                    <c:if test="${totalpage > 10}">
                        <li class="page-item">
                            <a class="page-link page-link-btn" href="#" data-page="11">&raquo;</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
        
    </div>
</div>
	<%--   <!-- 상단 정렬 드롭다운 -->
	<div class="d-flex justify-content-end border-bottom pb-3 mb-4">
		<select class="form-select" style="width: 140px;">
			<!-- *버튼 클릭시 해당 순서대로 나열 기능 구현 -->
			<option>낮은가격순</option> 
			<option>높은가격순</option>
			<option>조회순</option>
		</select>
	</div>

	<!-- 상품 그리드 (4열 x 3행 = 12개) -->
	<div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-4">

		<!-- 카드 1 -->
		<c:forEach var="vo" items="${list }">
		<div class="col">
			<div class="product-card">
				<a href="../goods/detail.do">
					<div class="thumb-box">
						<img src="${vo.poster_url }" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
						<use xlink:href="#heart"></use>
					</svg>
				</button>
				<div class="product-brand">${vo.brand_name }</div>
				<div class="product-name">${vo.goods_name }</div>
				<div class="product-price">${vo.goods_price }</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
					<use xlink:href="#heart"></use>
					</svg>
					${vo.like_count}<!-- 좋아요 들어갈 자리 -->
					<svg width="12" height="12" viewBox="0 0 12 12">
					<use xlink:href="#star-solid"></use>
					</svg>
					${vo.hit}<!-- 조회수 들어갈 자리 -->
				</div>
			</div>
		</div>
		</c:forEach>
		</div>

	<!-- ================= 페이지네이션 ================= -->
	<div class="row text-center" style="margin-top: 40px">
		<div class="d-flex justify-content-center">
			<ul class="pagination">
				<c:if test="${startPage > 1 }">
					<li><a href="list.do?page=${startPage - 1}">&laquo;</a></li>
				</c:if>
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<li ${i==curPage ? "class='active'" : ""}><a
						href="list.do?page=${i}">${i}</a></li>
				</c:forEach>
				<c:if test="${endPage < totalPage }">
					<li><a href="list.do?page=${endPage + 1}">&raquo;</a></li>
				</c:if>
			</ul>
		</div>
	</div> 
 --%>
</body>
</html>