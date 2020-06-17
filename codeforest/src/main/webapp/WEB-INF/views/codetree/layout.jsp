<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- code mirror -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/css/codemirror.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/abcdef.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/blackboard.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/dracula.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/duotone-light.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/eclipse.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/moxer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/neat.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/panda-syntax.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/solarized.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/ttcn.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/codemirror/js/codemirror.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/codemirror/mode/clike.js"></script>



<script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>		
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  


<script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/goldenlayout.min.js"></script>
<link rel="stylesheet" href="${pageContext.servletContext.contextPath }/assets/css/codetree/goldenlayout-base.css" />
<link rel="stylesheet" href="${pageContext.servletContext.contextPath }/assets/css/codetree/goldenlayout-dark-theme.css" />


<script>
//////////////////code-mirror /////////////////////////////





var i = 0;

/////////////////////////////////////////////////
$(function() {
	var config = {
		content : [ {
			type : "component",
			componentName : "testComponent",
			title : "Test Component"
		} ]
	};
	
	var myLayout = new GoldenLayout(config);

	myLayout.registerComponent("testComponent",	function(container) {
		container.getElement().html('<textarea name="code" class="CodeMirror code" id="testComponent"></textarea>');

		container.on("open", function() {

			var code = $('.CodeMirror')[0];

			var editor = CodeMirror.fromTextArea(code, {
				lineNumbers : true,
				mode : 'text/x-java',
				theme : 'duotone-light',
				matchBrackets : true
			});
		});
	});

	myLayout.registerComponent("newTab", function(container) {
		container.getElement().html('<textarea name="code" class="CodeMirror code" id="newTab"></textarea>');

		container.getElement().attr("id", "cm"+i);		

	});
	
	$(document).on("click", "#addTab", function() {
		var root = myLayout.root.contentItems[0] || myLayout.root;

		root.addChild({
			type : "component",
			componentName : "newTab",
			title : "New Tab"
		});
		var code = $('#cm'+i+' > .CodeMirror')[0];		
		
		var editor = CodeMirror.fromTextArea(code, {
			lineNumbers : true,
			mode : 'text/x-java',
			theme : 'panda-syntax',
			matchBrackets : true
		});	

		i++;

	});
	
	myLayout.init();

});
	
</script>
<button id="addTab">Add Tab</button>


