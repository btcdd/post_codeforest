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
var startTime = "${problemVo.startTime}";
var endTime = "${problemVo.endTime}";
$(function() {
	
	console.log("startTime",startTime);
	console.log("endTime",endTime);
	
	CountDownTimer(endTime);
});
function CountDownTimer(endTime){
	var diff = (Date.parse(new Date(endTime)) - Date.parse(new Date())) / 1000;
	
 	if (diff >= (365.25 * 86400)) { // 365.25 * 24 * 60 * 60
     	years = Math.floor(diff / (365.25 * 86400));
     	diff -= years * 365.25 * 86400;
  	}
   	if (diff >= 86400) { // 24 * 60 * 60
   		days = Math.floor(diff / 86400);
   		diff -= days * 86400;
   	}
   	if (diff >= 3600) { // 60 * 60
     	hours = Math.floor(diff / 3600);
     	diff -= hours * 3600;
   	}
   	if (diff >= 60) {
    	 min = Math.floor(diff / 60);
     	diff -= min * 60;
   	}
   	sec = diff;
   	console.log("years",years);
   	console.log("days",days);
   	console.log("hours",hours);
   	console.log("min",min);
   	console.log("sec",sec);

   	
	
	
	

	
}


</script>
<body>
	<div id="container">
		<div id="content">
			<p>${problemVo}</p>
			<p>${subProblemList}</p>
			<div id="countdown">111</div>
			<div id="newcountdown"></div>
		</div>
	</div>
</body>
</html>