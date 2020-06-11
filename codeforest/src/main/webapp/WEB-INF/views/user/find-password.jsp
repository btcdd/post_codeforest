<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Code Forest</title>
<link href="" rel="stylesheet" type="text/css">
<link href="${pageContext.servletContext.contextPath }/assets/css/user/find-password.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>
<script>
var loadingWithMask = function LoadingWithMask(){
		
	var widthWindow = window.innerWidth;
	var heightWindow = window.innerHeight;
		
	var mask = "<div id='mask' style='width: 100%;height: 100%;top: 0px;left: 0px;position: fixed;display: none; opacity: 0.9; background-color: #fff; z-index: 99;text-align: center;'></div>";
	var loadingImg = '';
		
	loadingImg += "<div id='loadingImg'>";
	loadingImg += "<img src='${pageContext.request.contextPath}/assets/images/user/spin.svg' style='position: absolute; top: 43%; left: 45%;z-index: 100;'/>";
	loadingImg += "</div>";
					
	$('body').append(mask).append(loadingImg);
		
	$('#mask').css({
		'width':widthWindow,
		'height':heightWindow,
		'opacity':'0.3'
	});
			
	$('#mask').show();
	$('#loadingImg').show();
}
	
var closeLoadingWithMask = function CloseLoadingWithMask(){
	$('#mask, #loadingImg').hide();
	$('#mask, #loadingImg').empty();
}

$(function(){
	var tempKey = null;
	
	$('#btn-auth').on('click',function(){
		
		var email = $('#email').val();	
		if(email == ''){
			alert('이메일을 입력하세요.');
			$("#email").focus();
			return;
		}
		
		loadingWithMask();
		
		$.ajax({
			url:'${pageContext.request.contextPath}/api/user/emailAuth',
			async:true,
			type:'post',
			dataType:'json',
			data:'email='+ email,
			success:function(response){	
				alert('인증번호가 발송되었습니다.');
				console.log(response.data);//인증키
				tempKey = response.data;
				closeLoadingWithMask();	
			},
			error: function(xhr, status, e) {
				console.error(status + ":" + e);
			}
		});
	});
	
	$('#btn-auth-check').on('click',function(){
		if( ($('#auth-check').val() == tempKey) && ($('#auth-check').val() != "") ){			
			console.log("인증번호 맞았음");
			$('#find-form').submit();
		} else{
			alert('인증번호 다시 확인해주세요.');
		}
	});	
	
});
</script>
</head>
<body>
    <div id="container">
    	<div class="logo">
			<a href="${pageContext.servletContext.contextPath }">Code Forest</a>
		</div> <!-- logo -->
        <div id="content">
            <div id="user">
                <form id="find-form" method="post" action="${pageContext.servletContext.contextPath }/user/reset">
                	<div class="find-password">비밀번호 찾기</div>
                    <div class="email">
                        <label for="email"></label>
                        <input id="email" name="email" type="email" placeholder="가입하신 이메일을 입력해주세요."/>
                    </div>
                    <div id="auth" >
                    	<label for="auth-check"></label>
                    	<input id="auth-check" type="text" name="Auth" placeholder="인증번호 입력">
                        <input id="btn-auth" type="button" value="인증번호 전송" />
                    </div>
                    <input id="btn-auth-check" type="button" value="계속">
                </form>
            </div>
        </div>
    </div>
</body>
</html>

