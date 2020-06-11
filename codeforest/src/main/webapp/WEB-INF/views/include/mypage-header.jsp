<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="header">
	<div class="head">
		<div class="container-left clearfix">
			<div class="logo">
				<a href="${pageContext.servletContext.contextPath }">Code Forest</a>
            </div>
            <div class="menu-user clearfix">
            	<div class="menu-item">${authUser.nickname }님</div>
                <div class="menu-item"><a href="${pageContext.servletContext.contextPath }/user/logout">로그아웃</a></div>
            </div>
        </div>
    </div>
</div>
<div class="sidemenu">
    <nav>
        <ul>
            <li class="menulist"><a href="${pageContext.servletContext.contextPath }/mypage/mypage">마이페이지</a></li>
            <li class="menulist"><a href="${pageContext.servletContext.contextPath }/mypage/account">계정 관리</a></li>
            <li class="menulist"><a href="${pageContext.servletContext.contextPath }/mypage/problem">문제 관리</a></li>
        </ul>
    </nav>
</div>