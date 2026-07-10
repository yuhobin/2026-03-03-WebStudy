<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-4">

    <c:forEach var="vo" items="${list}">
        <div class="col">
            <div class="card h-100 product-card shadow-sm">
                
                <a href="../goods/detail.do?goods_no=${vo.goods_no}">
                    <div class="img-box" style="height: 200px; overflow: hidden; background: #f8f9fa;">
                        <img src="${vo.poster_url}" class="card-img-top w-100 h-100" style="object-fit: cover;" alt="${vo.goods_name}">
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
                        <p class="card-text text-danger fw-bold mb-2" style="font-size: 1.1rem;">
                            ${vo.goods_price}원
                        </p>
                        
                        <div class="d-flex justify-content-between text-muted" style="font-size: 0.8rem;">
                            <span class="like-count-num">${vo.like_count}</span>
                            <span> ${vo.hit}</span>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </c:forEach>

</div>

<div class="d-flex justify-content-center mt-5">
    <nav aria-label="Page navigation">
        <ul class="pagination">
            
            <c:set var="startPage" value="${java.lang.Math.floor((curPage-1)/10)*10 + 1}" />
            <c:set var="endPage" value="${startPage + 9}" />
            
            <c:if test="${endPage > totalPage}">
                <c:set var="endPage" value="${totalPage}" />
            </c:if>

            <c:if test="${startPage > 1}">
                <li class="page-item">
                    <a class="page-link page-link-btn" href="#" data-page="${startPage - 1}" aria-label="Previous">
                        <span aria-hidden="true">&laquo; 이전</span>
                    </a>
                </li>
            </c:if>

            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <li class="page-item ${curPage == i ? 'active' : ''}">
                    <a class="page-link page-link-btn" href="#" data-page="${i}">${i}</a>
                </li>
            </c:forEach>

            <c:if test="${endPage < totalPage}">
                <li class="page-item">
                    <a class="page-link page-link-btn" href="#" data-page="${endPage + 1}" aria-label="Next">
                        <span aria-hidden="true">다음 &raquo;</span>
                    </a>
                </li>
            </c:if>
            
        </ul>
    </nav>
</div>
</body>
</html>