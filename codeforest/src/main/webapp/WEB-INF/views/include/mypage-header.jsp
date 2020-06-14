<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<div class="header">
    <div class="head-navigation">
        <div class="logo">
            <a class="title" href="${pageContext.servletContext.contextPath }">Code Forest</a>
        </div>
        <div class="menu clearfix">
            <div class="menu-item"><a href="${pageContext.servletContext.contextPath }/info">Info</a></div>
            <div class="menu-item"><a href="${pageContext.servletContext.contextPath }/codetree/list">Code Tree</a></div>
            <div class="menu-item"><a href="${pageContext.servletContext.contextPath }/codingtest">Coding Test</a></div>
            <div class="menu-item"><a href="${pageContext.servletContext.contextPath }/training">Coding Training</a></div>
        </div>         
        <div class="menu-user clearfix">
           <c:choose>
            <c:when test="${empty authUser }">
               <div class="menu-item"><a href="${pageContext.servletContext.contextPath }/user/login">Sign In</a></div>
               <div class="menu-item"><a href="${pageContext.servletContext.contextPath }/user/join">Sign Up</a></div>
            </c:when>
            <c:otherwise>
               <div class="menu-item"><a href="${pageContext.servletContext.contextPath }/mypage/mypage">Settings</a></div>
               <div class="menu-item"><a href="${pageContext.request.contextPath }/user/logout">Sign Out</a></div>
            </c:otherwise>
         </c:choose>
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
    </div>
</div>