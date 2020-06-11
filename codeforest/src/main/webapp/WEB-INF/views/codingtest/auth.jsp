<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Coding Test Auth</title>
	<link href="${pageContext.servletContext.contextPath }/assets/css/include/header.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="${pageContext.servletContext.contextPath }/assets/css/include/footer.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/ejs/ejs.js"></script>
	<script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>
</head>
<script>
$(function(){
	$("#auth-form").submit(function(e){
		e.preventDefault();
	
		if($("#name").val() ==''){
			alert('이름이 비었습니다');
			$("#name").focus();
			return;
		}	
		if($("#birth").val() ==''){
			alert('생일이 비었습니다');
			$("#birth").focus();
			return;
		}
		if($("#tempKey").val() ==''){
			alert('인증번호가 비었습니다');
			$("#tempKey").focus();
			return;
		}		
		this.submit();
	});	
});
</script>
<body>
	<div id="container">
		<div id="content">
			<div id="user">
				<form id="auth-form" method="POST" action="${pageContext.servletContext.contextPath }/codingtest/codemirror/${problemNo }">
					이름:<input type="text" id="name" name="name" value=""/>
					생일:<input type="date" id="birth" name="birth" value=""/>
					인증번호:<input type="text" id="tempKey" name="tempKey" value=""/>
					<input type="submit" value="테스트 시작"/>
				</form>
			</div>
		</div>
	</div>
</body>
</html>