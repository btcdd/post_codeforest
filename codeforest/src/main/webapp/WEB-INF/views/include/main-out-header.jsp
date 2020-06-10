<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="header">
	<div class="head">
<!-- 		<div class="logo"> -->
<!-- 			<a href="">Code Forest</a> -->
<!-- 		</div> -->
		<div class="container-left clearfix">
			<div class="menu-user clearfix">
				<c:choose>
					<c:when test="${empty authUser }">
						<div class="menu-item"><a href="${pageContext.servletContext.contextPath }/user/login">로그인</a></div>
						<div class="menu-item"><a href="${pageContext.servletContext.contextPath }/user/join">회원가입</a></div>
					</c:when>
					<c:otherwise>
						<div class="menu-item"><a href="${pageContext.servletContext.contextPath }/mypage/mypage">마이페이지</a></div>
						<div class="menu-item"><a href="${pageContext.request.contextPath }/user/logout">로그아웃</a></div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>