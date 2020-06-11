<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>Code Forest</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../../../assets/css/main.css">
<link href="${pageContext.servletContext.contextPath }/assets/css/user/login.css" rel="stylesheet" type="text/css">
<link href="${pageContext.servletContext.contextPath }/assets/css/include/user-header.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>

<script>
$(function(){
	$('#email').focusout(function() {
		$('.input-email-pattern').hide();
	});
	
	$('#password').focusout(function() {
		$('.input-password-pattern').hide();
	});
	
	$('#email').on("propertychange change keyup paste input", function() {
		var email = $("#email").val();
		if(email != '') {
			$('.input-email-pattern').hide();
		}
	});
	
	$('#password').on("propertychange change keyup paste input", function() {
		var password = $("#password").val();
		if(password != '') {
			$('.input-password-pattern').hide();
		}
	});
	
	$("#login-form").submit(function(e){
		e.preventDefault();
	
		if($("#email").val() ==''){
			console.log("email");
			$('.input-email-pattern').show();
			$("#email").focus();
			return;
		}	
		if($("#password").val() ==''){
			$('.input-password-pattern').show();
			$("#password").focus();
			return;
		}	
		this.submit();
	});	
	
	
});
</script>
</head>
<body>
   <div id="container">
        <c:import url="/WEB-INF/views/include/user-header.jsp" />
        <div id="content">
            <div id="user">
                <form id="login-form" name="" method="post" action="${pageContext.servletContext.contextPath }/user/auth" >
                    <div class="input-email-pattern" style="display:none">
                         	이메일을 입력하세요
                    </div>
                    <div class="email-area">
                        <label for="email"></label>
                        <input id="email" name="email" type="text" value="" placeholder="이메일" >
                    </div>
                    <div class="input-password-pattern" style="display:none">
                         비밀번호를 입력하세요
                    </div>
                    <div class="email-area">
                        <label for="password"></label>
                        <input id="password" name="password" type="password" value="" placeholder="패스워드" >
                    </div>
                    <c:if test="${not empty userVo }">
                        
                    </c:if>
                    <div>
                        <input class="login-button" type="submit" value="로그인">
                    </div>
                    <div>
                        <a href="${pageContext.servletContext.contextPath }/user/join"><input class="join-button" value="회원가입" readonly/></a>
                    </div>
                    <div class="findpassword">
                        <a href="${pageContext.servletContext.contextPath }/user/find">비밀번호찾기</a>
                    </div>
                </form>
            </div>
        </div> 
    </div>
</body>
</html>
