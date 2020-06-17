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
	var index = 1;
	var indexCopy = 1;

/////////////////////////////////////////////////
$(function() {
	console.log("start");
	var config = {
		content : [ {
			type : "component",
			componentName : "testComponent",
			title : "Test Component"
		} ]
	};
	
	console.log("config 생성");
	
	var myLayout = new GoldenLayout(config);
	
	console.log("mylayout ", myLayout);

	$(document).on("click", "#addTab", function() {
		console.log("버튼을 클릭함");
		console.log("myLayout.root.contentItems",myLayout.root.contentItems);
		console.log("myLayout.root.contentItems[0]",myLayout.root.contentItems[0]);
		var root = myLayout.root.contentItems[0] || myLayout.root;
		console.log("root : " + root);
		root.addChild({
			type : "component",
			componentName : "newTab",
			title : "New Tab"
		});
		
		console.log("자식 추가");
	});

	myLayout.registerComponent("testComponent",	function(container) {
		container.getElement().html('<textarea name="code" class="CodeMirror code" id="testComponent"></textarea>');
		console.log("textarea 추가");
		container.on("open", function() {
			console.log("open!!!");
			var code = $('.CodeMirror')[0];
			console.log("기존 탭 코드미러 : " + code);
			console.log("기존 탭 [0] : " + $('.CodeMirror')[0]);
			console.log("기존 탭 [1] : " + $('.CodeMirror')[1]);
			var editor = CodeMirror.fromTextArea(code, {
				lineNumbers : true,
				mode : 'text/x-java',
				theme : 'duotone-light',
				matchBrackets : true
			});
			
			console.log("코드미러 입히기");

			//not-null
 			console.log("initial", $("#testComponent"));
		});
	});

	myLayout.registerComponent("newTab", function(container) {
		container.getElement().html('<textarea name="code" class="CodeMirror code" id="newTab"></textarea>');
		console.log("뉴탭 부모: " + container.getElement().parent());
		container.getElement().attr("id", "zzz"+i);
		console.log(container.getElement());
		console.log("새로운 탭 추가!");
		console.log("새로운 탭 open");
		
		if(i != 0) {
			var code = $('#zzz'+(i-1)+' > .CodeMirror')[0];
		
			console.log("새로운 탭 코드미러 : " + code);
			
			var editor = CodeMirror.fromTextArea(code, {
				lineNumbers : true,
				mode : 'text/x-java',
				theme : 'panda-syntax',
				matchBrackets : true
			});
		
		}
		i++;
			console.log("새로운 탭 코드미러 입히기");
		container.on("open", function() {
		
			
				//null
				console.log("newTab : ", $("#newTab"));
			});
		});
	
	myLayout.init();
	console.log("레이아웃 이닛!");
	console.log("");
});
	
</script>
<button id="addTab">Add Tab</button>


