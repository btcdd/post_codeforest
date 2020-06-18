<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="${pageContext.servletContext.contextPath }/assets/css/codetree/codetree.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

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

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css?family=Merriweather" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/ejs/ejs.js"></script>

<script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/goldenlayout.min.js"></script>
<link rel="stylesheet" href="${pageContext.servletContext.contextPath }/assets/css/codetree/goldenlayout-base.css" />
<link rel="stylesheet" href="${pageContext.servletContext.contextPath }/assets/css/codetree/goldenlayout-dark-theme.css" />

<script>

var listTemplate = new EJS({
	url: "${pageContext.request.contextPath }/assets/js/ejs/codetree-fileList.ejs"
});

var fileFetchList = function(){
	   var saveNo = "${saveVo.no }";
	   var lang = $("select option:selected").val();
	   $.ajax({
	         url: '${pageContext.request.contextPath }/api/codetree/file-list',
	         async: true,
	         type: 'post',
	         dataType: 'json',
				data: {
					'saveNo' : saveNo,
					'language' : lang
				},
	         success: function(response){
	        	 console.log(response.data);
	        	 var html = listTemplate.render(response);
	        	
	      	   	 $(".file-tree__item").append(html);  
	         },
	         error: function(xhr, status, e) {
	            console.error(status + ":" + e);
	         }
	      });	
};

var codeMirrorIndex = 0;

var currentEditor = null;

$(function() {
	fileFetchList();
	
////////////////// code-mirror /////////////////////////////
   var save = false;
   $(".codeTest").submit(function(event) {
      event.preventDefault();
      var lang = $("select option:selected").val();
      
      var code = currentEditor.getValue();

      $.ajax({
         url: '${pageContext.request.contextPath }/compile/' + lang,
         async: true,
         type: 'post',
         dataType: 'json',
         data: {code:code},
         success: function(response){
            if(response.result != "success") {
               console.error(response.message);
               return;
            }
            if(response.data[1] != "") {
               console.log("data[1]\n" + response.data[1]);
               $("#result").val(response.data[1]);
            } else {
               console.log("data[0]\n" + response.data[0]);
               $('#result').val(response.data[0]);
            }
         
         },
         error: function(xhr, status, e) {
            console.error(status + ":" + e);
         }
      });
   });
   
//    var code = $('.CodeMirror')[0];
//    var editor = CodeMirror.fromTextArea(code, {
//    		lineNumbers: true,
//    		mode: 'text/x-java',
//    		theme: 'panda-syntax',
//    		matchBrackets: true
//    });
   
   $('.theme').click(function() {
	   var theme = $(".theme option:selected").val();
	   currentEditor.setOption("theme", theme);
	   
	   // 터미널 색 변경
	   $(".window .terminal").css('background-color', $(".cm-s-" + theme).css("background-color"));
	   if($('.theme option:selected').parent().attr('label') == "white") {
		   $(".window .terminal").css('color', "#000000");
		   $(".window .terminal .prompt").css('color', "#004000");
		   $(".window .terminal .path").css('color', "#1f0d98");
	   }
	   else {
		   $(".window .terminal").css('color', "#FFFFFF");
		   $(".prompt").css('color', "#bde371");
		   $(".path").css('color', "#5ed7ff");
	   }
   });
   
   $('.lang').change(function() {
	  
	   var lang = $(".lang option:selected").val();
	   var face = '';
	   
	   if(lang === 'c') {
		   face = '#include <stdio.h>\n\n' + 
			   'int main() {\n' + 
			   	'\tprintf("Hello CodeForest!\\n");\n\n' + 
			   	'\treturn 0;\n' + 
			   '}';
	   } else if(lang === 'cpp') {
		   face = '#include <iostream>\n\n' + 
			   		'using namespace std;\n\n' + 
			   'int main()\n' + 
			   '{\n' + 
			       '\tcout << "Hello CodeForest!" << endl;\n\n' + 
			       '\treturn 0;\n' + 
			   '}';
	   } else if(lang === 'cs') {
		   face = 'using System;\n\n' + 
			   		'class HelloWorld {\n\n' + 
			     	'\tstatic void Main() {\n' +  
			       '\t\tConsole.WriteLine("Hello CodeForest");\n' + 
			     '\t}\n' + 
			   '}';
	   } else if(lang === 'java') {
		   face = '/*\n' + 
	   		"* 기본 언어 : 'JAVA'\n" + 
		   "* 기본 테마 : 'panda-syntax'\n" + 
		   '*/\n' + 
		  'public class Test{\n' + 
		  		'\tpublic static void main(String[] args) {\n' + 
		      		'\t\tSystem.out.println("Hello CodeForest!");\n' + 
		      '\t}\n' + 
		  '}\n';
	   } else if(lang === 'js') {
		   face = 'var str = "Hello CodeForest";\n\n' + 
		   			'console.log(str);';
	   } else if(lang === 'py') {
		   face = 'print("Hello World")';
	   }
	   
	   currentEditor.setValue(face);
	   
	   
	   
	   ////////////////////////////////////////////////////////////////////
	   ////////////////////////////
	   ///////////////////////////////////해야할곳////
	   
 	   $(".file-tree__subtree").remove();
	   fileFetchList();

	   
	   
	   
   });
   
//  	$('.CodeMirror').addClass('code');

 	
///////////////////////////// problem-list //////////////////////////////////
 	var ui = $(".ui"),
 	    sidebar = $(".ui__sidebar");

 	// File Tree
 	$(document).on("click", ".folder", function(e) {
 		$(".contextmenu").hide();
 	    var t = $(this);
 	    var tree = t.closest(".file-tree__item");

 	    if (t.hasClass("folder--open")) {
 	        t.removeClass("folder--open");
 	        tree.removeClass("file-tree__item--open");
 	    } else {
 	        t.addClass("folder--open");
 	        tree.addClass("file-tree__item--open");
 	    }

 	    // Close all siblings
 	    /*
 	    tree
 	        .siblings()
 	        .removeClass("file-tree__item--open")
 	        .find(".folder--open")
 	        .removeClass("folder--open");
 	    */
 	});	
 	
 // 파일 열고 닫기
 	$(document).on('click','#folder',function() {
 		if ($(this).hasClass("folder--open")) {
 			$("#file"+$(this).data("no")).show();
 	    } else { 	    	
 	    	$("#file"+$(this).data("no")).hide();
 	    }
 	});
 	

 	// 폰트 사이즈 변경
	$(document).on("click", '#font-size', function(){	
		var fontSize = $("#font-size option:selected").val();
		console.log("font-size:"+fontSize);
		$(".CodeMirror").css("font-size", fontSize);
	});
	
 	
 	
 	
 	
////////////////파일 추가////////////////////
 	
 	var savePathNo = null;
 	var subProblemNo = null;
 	var codeNo = null;
 	var prevFileName = null;
 	var str='<div id="file-insert"><li>파일 추가</li></div>';
 	$(".contextmenu").append(str);
 	var str2='<div><li id="userfile-delete">파일 삭제</li><li id="userfile-update">이름변경</li></div>';
 	$(".userfile-menu").append(str2);
 	

	$(document).on('mouseenter','#folder',function() {
		console.log("hi");
		$(document).on('mousedown','#folder',function(e) {
			$(".userfile-menu").hide();
			if(e.which == 3){

				savePathNo = $(this).data("no");
	 			subProblemNo = $(this).data("no2");
	 		    //Get window size:
	 		    var winWidth = $(document).width();
	 		    var winHeight = $(document).height();
	 		    //Get pointer position:
	 		    var posX = e.pageX;
	 		    var posY = e.pageY;
	 		    //Get contextmenu size:
	 		    var menuWidth = $(".contextmenu").width();
	 		    var menuHeight = $(".contextmenu").height();
	 		    //Security margin:
	 		    var secMargin = 10;
	 		    //Prevent page overflow:
	 		    if(posX + menuWidth + secMargin >= winWidth
	 		    && posY + menuHeight + secMargin >= winHeight){
	 		      //Case 1: right-bottom overflow:
	 		      posLeft = posX - menuWidth - secMargin + "px";
	 		      posTop = posY - menuHeight - secMargin + "px";
	 		    }
	 		    else if(posX + menuWidth + secMargin >= winWidth){
	 		      //Case 2: right overflow:
	 		      posLeft = posX - menuWidth - secMargin + "px";
	 		      posTop = posY + secMargin + "px";
	 		    }
	 		    else if(posY + menuHeight + secMargin >= winHeight){
	 		      //Case 3: bottom overflow:
	 		      posLeft = posX + secMargin + "px";
	 		      posTop = posY - menuHeight - secMargin + "px";
	 		    }
	 		    else {
	 		      //Case 4: default values:
	 		      posLeft = posX + secMargin + "px";
	 		      posTop = posY + secMargin + "px";
	 		    };
	 		    //Display contextmenu:
	 		    $(".contextmenu").css({
	 		      "left": posLeft,
	 		      "top": posTop
	 		    }).show();
	 		    //Prevent browser default contextmenu.
	 		    return false;					
				
				
			}
			
		
		});

		
		$(document).on('mousedown','.userFile',function(e){
			

			
			$(".contextmenu").hide();
			
			if(e.which == 3){
				codeNo = $(this).data("no");
				prevFileName = $(this).data("file-name");
	 		    //Get window size:
	 		    var winWidth = $(document).width();
	 		    var winHeight = $(document).height();
	 		    //Get pointer position:
	 		    var posX = e.pageX;
	 		    var posY = e.pageY;
	 		    //Get contextmenu size:
	 		    var menuWidth = $(".userfile-menu").width();
	 		    var menuHeight = $(".userfile-menu").height();
	 		    //Security margin:
	 		    var secMargin = 10;
	 		    //Prevent page overflow:
	 		    if(posX + menuWidth + secMargin >= winWidth
	 		    && posY + menuHeight + secMargin >= winHeight){
	 		      //Case 1: right-bottom overflow:
	 		      posLeft = posX - menuWidth - secMargin + "px";
	 		      posTop = posY - menuHeight - secMargin + "px";
	 		    }
	 		    else if(posX + menuWidth + secMargin >= winWidth){
	 		      //Case 2: right overflow:
	 		      posLeft = posX - menuWidth - secMargin + "px";
	 		      posTop = posY + secMargin + "px";
	 		    }
	 		    else if(posY + menuHeight + secMargin >= winHeight){
	 		      //Case 3: bottom overflow:
	 		      posLeft = posX + secMargin + "px";
	 		      posTop = posY - menuHeight - secMargin + "px";
	 		    }
	 		    else {
	 		      //Case 4: default values:
	 		      posLeft = posX + secMargin + "px";
	 		      posTop = posY + secMargin + "px";
	 		    };
	 		    //Display contextmenu:
	 		    $(".userfile-menu").css({
	 		      "left": posLeft,
	 		      "top": posTop
	 		    }).show();
	 		    //Prevent browser default contextmenu.
	 		    return false;				
			}			
		});
		
		
		
	}).on('mouseleave','.ui__sidebar',function(){
		console.log("bye");
	}).on('contextmenu','.ui__sidebar',function(){
		return false;
	}).on('userfile-menu','.ui__sidebar',function(){
		return false;
	});
	
 	
 	//Hide contextmenu:
 	$(document).click(function(){
 	   $(".contextmenu").hide();
 	});
 
 	//Hide contextmenu:
 	$(document).click(function(){
 	   $(".userfile-menu").hide();
 	});	
 	
 	$(document).on('click','#file-insert',function(){
 		console.log("savePathNo!!!"+savePathNo);
 		console.log("subProblemNo!!!"+subProblemNo);
 		var lang = $(".lang option:selected").val();
 		var fileName = null;
 		$('<div> <input type="text" style="z-index:10000" class="fileName-input"  placeholder='+'.'+lang+' > </div>')
 		    .attr("title","파일 추가")
 			.dialog({
 			modal: true,
			buttons:{
				"추가": function(){
					var filename = $(this).find(".fileName-input").val();
					var filename2 =filename.replace(/(\s*)/g,""); 
					if(filename2.split(".").length >2 || filename2.split(".")[1] !=lang || filename2.split(".")[0] ==""){
						alert("잘못된 형식입니다");
						return;
					}
					fileName = filename2;
					
					$.ajax({
						url: '${pageContext.servletContext.contextPath }/api/codetree/fileInsert',
						async: true,
						type: 'post',
						dataType: 'json',
						data: {
							'savePathNo' : savePathNo,
							'language' : lang,
							'fileName' : fileName,
							'subProblemNo':subProblemNo
						},
						success: function(response) {
										
							if(response.data.result == 'no'){
								alert("이미 파일이 존재합니다.");//메시지 처리 필요
								return;
							}
							$(".file-tree__subtree").remove();

							fileFetchList();
							
						},
						error: function(xhr, status, e) {
							console.error(status + ":" + e);
						}
					});
					$(this).dialog("close");
				},
				"취소":function(){
					$(this).dialog("close");
				}
			},
			close:function(){}
 		}); 		
 	});
 	
 	
 	$(document).on('click','#userfile-delete',function(){
 		console.log("userfile-delete   >>codeNo",codeNo);
 		$(".validateTips").css("color","black").html("<p>정말로 삭제하시겠습니까?</p>");
 		dialogDelete.dialog("open");
 	});
 	
 	
 	var dialogDelete = $("#dialog-delete-form").dialog({
			autoOpen: false,
			width:300,
			height:220,
			modal:true,
			buttons:{
				"삭제":function(){
					$.ajax({
						url: '${pageContext.servletContext.contextPath }/api/codetree/fileDelete/'+codeNo,
						async: true,
						type: 'delete',
						dataType:'json',
						data:'',
						success: function(response) {
							
							if(response.result != "success"){
								console.error(response.message);
								return;
							}
							
							if(response.data != -1){
								 
								$(".userFile[data-no="+response.data+"]").remove();
								
								dialogDelete.dialog('close');
								return;
							}							
							
							$(".validateTips").css("color","red").html("<p>삭제실패</p>");
						},
						error: function(xhr, status, e) {
							console.error(status + ":" + e);
						}							
					});
				},
				"취소":function(){
					$(this).dialog("close");
				}
			},
			close:function(){}
 	}); 	
 	
 	
 	$(document).on("click", "#userfile-update", function() {
 		var lang = $(".lang option:selected").val();
 		var fileName = null;
 		$('<div> <input type="text" style="z-index:10000" class="fileName-update" placeholder='+'.'+lang+'></div>')
		    .attr("title","파일 수정")
		    .dialog({
		    	modal: true,
		    	buttons:{
		    		"수정":function(){
						var filename = $(this).find(".fileName-update").val();
						var filename2 =filename.replace(/(\s*)/g,""); 
						if(filename2.split(".").length >2 || filename2.split(".")[1] !=lang || filename2.split(".")[0] ==""){
							alert("잘못된 형식입니다");
							return;
						}
						fileName = filename2;
						$.ajax({
							url: '${pageContext.servletContext.contextPath }/api/codetree/fileUpdate',
							async: true,
							type: 'post',
							dataType: 'json',
							data: {
								'savePathNo' : savePathNo,
								'codeNo' : codeNo,
								'fileName' : fileName,
								'subProblemNo':subProblemNo,
								'prevFileName':prevFileName
							},
							success: function(response) {
											
 								if(response.data.result == 'no'){
									alert("이미 파일이 존재합니다.");//메시지 처리 필요
									return;
								}
								$(".file-tree__subtree").remove();

								fileFetchList(); 
								
							},
							error: function(xhr, status, e) {
								console.error(status + ":" + e);
							}
						});
						$(this).dialog("close");		    			
		    		},
					"취소":function(){
						$(this).dialog("close");
					}
		    	},
		    	close:function(){}
		    });
			
 	});
 	
 	var tempFile = null;
 	$(document).on("dblclick", ".file", function() {
 		tempFile = $(this);
 		var language = $(this).data("language");
 		var fileName = $(this).data("file-name");
 		var packagePath = $(this).data("package-path");
 		$.ajax({
			url: '${pageContext.servletContext.contextPath }/api/codetree/find-code',
			async: true,
			type: 'post',
			dataType:'json',
			data: {
				'language' : language,
				'fileName' : fileName,
				'packagePath' : packagePath
			},
			success: function(response) {
				currentEditor.setValue(response.data);				
				console.log("code : " + response.data);
			},
			error: function(xhr, status, e) {
				console.error(status + ":" + e);
			}							
		});
 	});
 	
 	var compileResult = null;
 	$(document).on("click","#Run",function(){
 		$(this).addClass( "onclic", 250, validate);
 		console.log("editor.getValue()>>>>>>",currentEditor.getValue());
 		var problemNo = "${saveVo.problemNo }";
 		$("#Run").blur();
 		$.ajax({
			url: '${pageContext.servletContext.contextPath }/api/codetree/run',
			async: true,
			type: 'post',
			dataType:'json',
			data: {
				'language' : tempFile.data("language"),
				'fileName' : tempFile.data("file-name"),
				'packagePath' : tempFile.data("package-path"),
				'subProblemNo':tempFile.data("subproblem-no"),
				'codeValue' : currentEditor.getValue(),
				'problemNo' : problemNo
			},
			success: function(response) {
				
				console.log("ok");
				
				console.log(response.data.result);
				compileResult = response.data.result;
				
				if(response.data.result[1] == "") {
					$(".terminal").append("<p>"+response.data.result[0]+"</p>");
				}
				else {
					$(".terminal").append("<p>"+response.data.result[1]+"</p>");
					
				}
				$(".terminal").append("<span class=\"prompt\">-></span> ");
				$(".terminal").append("<span class=\"path\">~</span> ");
				$('.terminal').scrollTop($('.terminal').prop('scrollHeight'));
			},
			error: function(xhr, status, e) {
				console.error(status + ":" + e);
			}							
		}); 		
 	});
 	 function validate() {
  	    setTimeout(function() {
  	      $( "#Run" ).removeClass( "onclic" );
  	      $( "#Run" ).addClass( "validate", 450, callback );
  	    }, 2250 );
  	  }
  	    function callback() {
  	      setTimeout(function() {
  	        $( "#Run" ).removeClass( "validate" );
  	      }, 1250 );
  	    }
 	 
 	
  	$(document).on("click","#Save",function(){
  		console.log("editor.getValue()>>>>>>",currentEditor.getValue());
  		var problemNo = "${saveVo.problemNo }";
  		
 		$.ajax({
			url: '${pageContext.servletContext.contextPath }/api/codetree/save',
			async: true,
			type: 'post',
			dataType:'json',
			data: {
				'language' : tempFile.data("language"),
				'fileName' : tempFile.data("file-name"),
				'packagePath' : tempFile.data("package-path"),
				'subProblemNo':tempFile.data("subproblem-no"),
				'codeValue' : currentEditor.getValue(),
				'problemNo' : problemNo
			},
			success: function(response) {
				console.log("ok");
			},
			error: function(xhr, status, e) {
				console.error(status + ":" + e);
			}							
		}); 		
 	}); 
   	$(document).on("click","#Submit",function(){
   		var problemNo = "${saveVo.problemNo }";
   		var subProblemNo = tempFile.data("subproblem-no");
   		var result = new Array();
   		<c:forEach items="${subProblemList}" var="info">
   			var json = new Object();
   			json.no = "${info.no}";
   			json.examOutput = "${info.examOutput}";
   			result.push(json);
   		</c:forEach>
   		var selected = null;
   		for(var i=0;i<result.length;i++){
   			if(result[i].no == subProblemNo){
   				selected = result[i];
   			}
   		}
   				
 		$.ajax({
			url: '${pageContext.servletContext.contextPath }/api/codetree/submit',
			async: true,
			type: 'post',
			dataType:'json',
			data: {
				'language' : tempFile.data("language"),
				'fileName' : tempFile.data("file-name"),
				'packagePath' : tempFile.data("package-path"),
				'subProblemNo':tempFile.data("subproblem-no"),
				'codeValue' : currentEditor.getValue(),
				'problemNo' : problemNo,
				'examOutput': selected.examOutput,
				'compileResult':compileResult
			},
			success: function(response) {
				console.log("ok");
	
/* 				var newCompileResult =compileResult[0].replace(/(\s*)/g,"");
	
				if(newCompileResult == selected.examOutput){
					alert("정답입니다");
					return;
				} */
			},
			error: function(xhr, status, e) {
				console.error(status + ":" + e);
			}							
		});		
 	});    	
  	


 	
 	
 	//////////////////////////// golden layout /////////////////////////////	
	var config = {
		content : [ {
			type : "component",
			componentName : "testComponent",
			title : "Test Component"
		} ]
	};
	
	var myLayout = new GoldenLayout(config, document.getElementById('gl-cover'));

	myLayout.registerComponent("testComponent",	function(container) {
		container.getElement().html('<textarea name="code" class="CodeMirror code" id="testComponent"></textarea>');
		

		container.on("open", function() {

			var code = $('.CodeMirror')[0];

			var editor = CodeMirror.fromTextArea(code, {
				lineNumbers : true,
				mode : 'text/x-java',
				theme : 'panda-syntax',
				matchBrackets : true
			});
			currentEditor = editor;
			var glCm = document.getElementsByClassName("lm_root")[0];
			glCm.style = "";
			
			var glCm2 = document.getElementsByClassName("lm_stack")[0];
			glCm2.style = "";
			
			var glCm3 = document.getElementsByClassName("lm_items")[0];
			glCm3.style = "";
			
			var glCm4 = document.getElementsByClassName("lm_item_container")[0];
			glCm4.style = "";
			
			var glCm5 = document.getElementsByClassName("lm_content")[0];
			glCm5.style = "";
		});
	});

	myLayout.registerComponent("newTab", function(container) {
		container.getElement().html('<textarea name="code" class="CodeMirror code" id="newTab"></textarea>');

		container.getElement().attr("id", "cm"+codeMirrorIndex);		
		
	});
	
	$(document).on("click", "#addTab", function() {
		var root = myLayout.root.contentItems[0] || myLayout.root;

		root.addChild({
			type : "component",
			componentName : "newTab",
			title : "New Tab"
		});
		var code = $('#cm'+codeMirrorIndex+' > .CodeMirror')[0];		
		
		var editor = CodeMirror.fromTextArea(code, {
			lineNumbers : true,
			mode : 'text/x-java',
			theme : 'panda-syntax',
			matchBrackets : true
		});	
		currentEditor = editor;
		
		codeMirrorIndex++;

	});
	
	myLayout.init();
 	
 	
 	
 	
 	
 	
////// function 끝부분 	
});

	



	

/////////////////////////////////////////////////////////////////////////////////////////////////	
	
	
	if (typeof Resizer === 'undefined') {

	var Resizer = function(resizerNode, type, options) {
		resizerNode.classList.add('resizer');
		resizerNode.setAttribute('data-resizer-type', type);
		this.hidebar = (typeof options === 'undefined' ? null : options.hidebar);
		this.callbackMove = (typeof options === 'undefined' ? null : options.callbackMove);
		this.callbackStop = (typeof options === 'undefined' ? null : options.callbackStop);
		this.processing = false;
		this.container = {
			node: resizerNode.parentNode,
			playingSize: null,
			playingRatio: null
		};
		this.beforeBox = {
			node: resizerNode.previousElementSibling,
			ratio: null,
			size: null
		};
		this.resizer = {
			node: resizerNode,
			type: type
		};
		this.afterBox = {
			node: resizerNode.nextElementSibling,
			ratio: null,
			size: null
		};
		this.mousePosition = null;
		this.beforeBox.node.style.flexGrow = 1;
		this.afterBox.node.style.flexGrow = 1;
		this.beforeBox.node.style.flexShrink = 1;
		this.afterBox.node.style.flexShrink = 1;
		this.beforeBox.node.style.flexBasis = 0;
		this.afterBox.node.style.flexBasis = 0;
		// ajout des events
		this.resizer.node.addEventListener('mousedown', this.startProcess.bind(this), false);
	};

	Resizer.prototype = {
		startProcess: function(event) {
			// cas processus déjà actif
			if (this.processing) {
				return false;
			}
			// MAJ flag
			this.processing = true;
			// cacher la barre
			if (this.hidebar) {
				this.resizer.node.style.display = 'none';
			}
			// réinitialiser les variables
			this.beforeBox.ratio = parseFloat(this.beforeBox.node.style.flexGrow);
			this.afterBox.ratio = parseFloat(this.afterBox.node.style.flexGrow);
			this.mousePosition = (this.resizer.type === 'H' ? event.clientX : event.clientY);
			this.beforeBox.size = (this.resizer.type === 'H' ? this.beforeBox.node.offsetWidth : this.beforeBox.node.offsetHeight);
			this.afterBox.size = (this.resizer.type === 'H' ? this.afterBox.node.offsetWidth : this.afterBox.node.offsetHeight);
			this.container.playingSize = this.beforeBox.size + this.afterBox.size;
			this.container.playingRatio = this.beforeBox.ratio + this.afterBox.ratio;
			// lancer le processus
			this.stopProcessFunctionBinded = this.stopProcess.bind(this);
			document.addEventListener('mouseup', this.stopProcessFunctionBinded, false);
			this.processFunctionBinded = this.process.bind(this);
			document.addEventListener('mousemove', this.processFunctionBinded, false);
		},
		process: function(event) {
			if (!this.processing) {
				return false;
			}
			// calcul du mouvement de la souris
			var mousePositionNew = (this.resizer.type === 'H' ? event.clientX : event.clientY);
			var delta = mousePositionNew - this.mousePosition;
			// calcul des nouveaux ratios
			var ratio1, ratio2;
			ratio1 = (this.beforeBox.size + delta) * this.container.playingRatio / this.container.playingSize;
			if (ratio1 <= 0) {
				ratio1 = 0;
				ratio2 = this.container.playingRatio;
			} else if (ratio1 >= this.container.playingRatio) {
				ratio1 = this.container.playingRatio;
				ratio2 = 0;
			} else {
				ratio2 = (this.afterBox.size - delta) * this.container.playingRatio / this.container.playingSize;
			}
			// mise à jour du css
			this.beforeBox.node.style.flexGrow = ratio1;
			this.afterBox.node.style.flexGrow = ratio2;
			this.beforeBox.node.style.flexShrink = ratio2;
			this.afterBox.node.style.flexShrink = ratio1;
			// lancer la fonction de callback
			if (typeof this.callbackMove === 'function') {
				this.callbackMove();
			}
		},
		stopProcess: function(event) {
			// stopper le processus
    	document.removeEventListener('mousemove', this.processFunctionBinded, false);
			this.processFunctionBinded = null;
			document.removeEventListener('mouseup', this.stopProcessFunctionBinded, false);
			this.stopProcessFunctionBinded = null;
			// afficher la barre
			if (this.hidebar) {
				this.resizer.node.style.display = '';
			}
			// lancer la fonction de callback
			if (typeof this.callbackStop === 'function') {
				this.callbackStop();
			}
			// réinitialiser le flag
			this.processing = false;
		},
	};
} else {
	console.error('"Resizer" class already exists !');
}

window.onload = function() {
    new Resizer(document.querySelector('[name=resizerH1]'), 'H');
    new Resizer(document.querySelector('[name=resizerH2]'), 'H');
    new Resizer(document.querySelector('[name=resizerV1]'), 'V');
    
   	var el = document.getElementById("box_1");
   	el.style = "flex: 0.30788 1.12466 0px;";
   	
   	var el2 = document.getElementById("box_2");
   	el2.style = "flex: 0.157611 0.91488 auto;";
   	
   	var el4 = document.getElementById("box_4");
   	el4.style = "flex: 0.461282 1.08793 0px;";
  };
  


</script>
</head>
<body>



<div class="header">
    <div class='logo'>
        Code Tree
    </div>
    <div class='menu'>
        <div class='dropdown'>
            <button class='dropbtn'>FILE</button>
            <div class='dropdown-content'>
                <a href="#">File</a>
            </div>
        </div>
        <div class='dropdown'>
            <button class='dropbtn'>EDIT</button>
            <div class='dropdown-content'>
                <a href="#">File</a>
            </div>
        </div>
        <div class='dropdown'>
            <button class='dropbtn'>RUN</button>
            <div class='dropdown-content'>
                <a href="#">File</a>
            </div>
        </div>
        <div class='dropdown'>
            <button class='dropbtn'>HELP</button>
            <div class='dropdown-content'>
                <a href="#">File</a>
            </div>
        </div>                                   
    </div>
</div>

<div class="container">

	<div class="frame horizontal">
	  
	    <div id="box_1" class="box" style="flex: 1 1 1">
	    	<c:import url="/WEB-INF/views/codetree/problem-list.jsp"></c:import>
	    </div>
	    
	  <div name="resizerH1"></div>
	  
	  <div class="frame vertical" id="code-mirror">

		  <div class='navigator'>
              <div class='language-selector'>
                <select class="lang" name="lang">
                    <option value="c">C</option>
                    <option value="cpp">C++</option>
                    <option value="cs">C#</option>
                    <option value="java" selected="selected">JAVA</option>
                    <option value="js">JavaScript</option>
                    <option value="py">Python</option>
                </select>
              </div>
              <div class='theme-selector'>
                <select class="theme" name="theme">
                	<optgroup label="black">
                    <option value="abcdef">abcdef</option>
                    <option value="blackboard">blackboard</option>
                    <option value="dracula">dracula</option>
                    <option value="moxer">moxer</option>
                    <option value="panda-syntax" selected="selected">panda-syntax</option>
                  </optgroup>
                  <optgroup label="white">
                    <option value="duotone-light">duotone-light</option>
                    <option value="eclipse">eclipse</option>
                    <option value="neat">neat</option>
                    <option value="ttcn">ttcn</option>
                    <option value="solarized">solarized</option>
                  </optgroup>
                </select>
              </div>
              <div class='font-size'>
                  <select class="size" id="font-size" name="size">
                    <option value="10px">10px</option>
                    <option value="12px">12px</option>
                    <option value="15px">15px</option>
                    <option value="16px" selected="selected">16px</option>
                    <option value="17px">17px</option>
                    <option value="18px">18px</option>
                    <option value="19px">19px</option>
                    <option value="20px">20px</option>
                    <option value="25px">25px</option>
                    <option value="30px">30px</option>
                    <option value="35px">35px</option>
                </select>
              </div>
              <div>
              	<button id="Save">Save</button>
              	<button id="Run" class="Run"></button>
              	<button id="Submit">제출</button>
              </div>
          </div> 

	    <div class="frame horizontal" id="file-codemirror-cover">	    
	      <div id="box_2" class="box" style="display:flex;flex-direction:column">

		    <div class="ui__sidebar">
		        <ul class="file-tree">
		            <li class="file-tree__item file-tree__item--open">
		                <div class="folder folder--open">${saveVo.title }</div>		
		                <ul class="file-tree__subtree">
<%-- 			                <c:forEach items='${savePathList }' var='vo' varStatus='status'>
			                    <li class="file-tree__item">
			                        <div id="folder" class="folder folder--open" data-no="${vo.no}" data-no2="${vo.subProblemNo}" >${saveVo.title}/${status.index+1}</div>
									<ul class="file-tree__subtree" id="file${vo.no}">
										<c:forEach items='${codeList}' var='codevo' varStatus='status'>
											<c:if test="${vo.no == codeList[status.index].savePathNo && codeList[status.index].language == 'java' }">
												<li class='userFile' data-no="${codeList[status.index].no}">
													<div class="file">${codevo.fileName}</div>
												</li>
											</c:if>	
										</c:forEach>
									</ul>
								</li>			                        
			                </c:forEach> --%>
		                </ul>
		                <!-- /.file-subtree -->
		            </li>
		            
		        </ul>
		        <!-- /.file-tree -->
		    </div>
		    <!-- /.sidebar -->

	      </div>
	      	      
	      <div name="resizerH2"></div>	
	            
	      <div id="box_3" class="box">
	      
<!-- 	      		<textarea name="code" class="CodeMirror code"> -->
<!-- /* -->
<!-- * 기본 언어 : 'JAVA' -->
<!-- * 기본 테마 : 'panda-syntax' -->
<!-- */ -->
<!-- public class Test{ -->
<!-- 	public static void main(String[] args) { -->
<!-- 		System.out.println("Hello CodeForest!"); -->
<!-- 	} -->
<!-- } -->
<!-- 				</textarea>			 -->
         	<div class="gl-cover" id="gl-cover">
         	
         	</div>
         
	      </div>
	      
	    </div>	    
	      <div name="resizerV1"></div>	      
	      <div id="box_4" class="box">
	      	<c:import url="/WEB-INF/views/codetree/terminal2.jsp"></c:import>
	      </div>
	  </div>
	  
	</div>
	
			<div id="dialog-delete-form" class="delete-form" title="메세지 삭제" style="display:none">
				<p class="validateTips"></p>  
			</div>
			<div>
				<ul class="contextmenu">
				</ul>
				<ul class="userfile-menu">
				</ul> 
			</div>
</div>
</body>
</html>