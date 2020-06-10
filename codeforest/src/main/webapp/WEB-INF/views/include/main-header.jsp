<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script>
$(function() {
	
/* 	$("#code-tree").on('click',function(){
	      $.ajax({
	          url:'${pageContext.request.contextPath }/api/codetree',
	          async:false,
	          type:'get',
	          dataType:'json',
	          data : '',
	          success:function(response){
	             console.log(response.data);
	             console.log(response.data.authUser.email);
	              var url = "http://localhost:9999/codetree?userEmail="+response.data.authUser.email;
	              window.open(url,'_blank');
	              

	              
	          },
	          error: function(xhr, status, e) {
	             console.error(status + ":" + e);
	          }
	       });
	}); */
});

</script>


<div class="header">
    <div class="head-navigation">
        <div class="logo">
            <a href="${pageContext.servletContext.contextPath }/main-in">Code Forest</a>
        </div>
        <div class="menu clearfix">
            <div class="menu-item"><a href="${pageContext.servletContext.contextPath }/info">Info</a></div>
            <div id="code-tree" class="menu-item"><a>Code Tree</a></div>
            <div class="menu-item"><a href="${pageContext.servletContext.contextPath }/codingtest">Coding Test</a></div>
            <div class="menu-item"><a href="${pageContext.servletContext.contextPath }/training">Coding Training</a></div>
        </div>			
        <div class="menu-user clearfix">
            <div class="menu-item"><a href="${pageContext.servletContext.contextPath }/mypage/mypage">마이페이지</a></div>
            <div class="menu-item"><a href="${pageContext.request.contextPath }/user/logout">로그아웃</a></div>
        </div>
    </div>
</div>