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

<script>


$(function() {

	
////////////////// code-mirror /////////////////////////////
   var save = false;
   $(".codeTest").submit(function(event) {
      event.preventDefault();
      var lang = $("select option:selected").val();
      var code = editor.getValue();

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
   
   var code = $('.CodeMirror')[0];
   var editor = CodeMirror.fromTextArea(code, {
   		lineNumbers: true,
   		mode: 'text/x-java',
   		theme: 'panda-syntax',
   		matchBrackets: true
   });
   
   $('.theme').click(function() {
	   var theme = $(".theme option:selected").val();
	   editor.setOption("theme", theme);
	   
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
	   
	   editor.setValue(face);
   });
   
 	$('.CodeMirror').addClass('code');
 	
 ////////////////////////////////////////////////////////////////
 
 	$(document).on('click', '.sub-problem-title', function(event) {
		event.preventDefault();
		var no = $(this).data("no");
		$("#subproblem-" + no).toggle();
	});
 
 
 
 	$('#font-size').on("propertychange change keyup paste", function(){		
 		var fontSize = $(this).val() + "px";
 		console.log("font-size:"+fontSize);
 		$(".CodeMirror").css("font-size", fontSize+"");
	});
 	
var packagePath = null;
var subProblemNo = null;
var str='<div id="fileInsert"><li>파일 추가</li></div>';
$(".contextmenu").append(str);
	
	$(document).on('mouseenter','.file',function(){
		console.log("hi");
		$(document).on('click','.problem-packageList',function(e){
 			console.log("click!!",$(this).data("no"));
 			packagePath = $(this).data("no");
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
		});
	}).on('mouseleave','.file',function(){
		console.log("bye");
	}).on('contextmenu','.file',function(){
		return false;
	});
	
 	
 	//Hide contextmenu:
 	$(document).click(function(){
 	   $(".contextmenu").hide();
 	});
 	
 	
 	$(document).on('click','#fileInsert',function(){
 		console.log("packagePath!!!"+packagePath);
 		console.log("subProblemNo!!!"+subProblemNo);
 		var lang = $(".lang option:selected").val();
 		var fileName = null;
 		$('<div> <input type="text" style="z-index:10000" class="fileName-input"  placeholder='+'.'+lang+' }> </div>')
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
							'savePathNo' : packagePath,
							'language' : lang,
							'fileName' : fileName,
							'subProblemNo':subProblemNo
						},
						success: function(response) {
										
							if(response.data.result == 'no'){
								console.log("이미 파일이 존재합니다.");
								return;
							}
							$(".file"+response.data.savePathNo).append("<li>"+response.data.fileName+"</li>")
							
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
 


 		
	
 	});
 	
 	
 	
 	
 	
 	
 	
});


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
        <div class='problem-list'>
            <div class='problem-title'>
                <p class='problem-title-head'>${saveVo.title }</p>
                <c:forEach items='${subProblemList }' var='subproblemvo' varStatus='status'>
	                <div class='problem'>                    
		                <div class='sub-problem-title' data-no='${subproblemvo.no }'>
		                    <p class='problem-index'>문제 ${status.index + 1}</p>
		                    <p class='subtitle'>${subproblemvo.title }</p>
		                </div>
		                <div class='problem-open' style='display:none;' id='subproblem-${subproblemvo.no }'>
		                    <div class='contents'>
		                        <p class='problem-contents-title'>문제 내용</p>
		                        <br />
		                        <p class='problem-contents'>${subproblemvo.contents }</p>
		                    </div>
		                    <hr class='division' />
		                    <div class='examInput'>
		                        <p class='problem-examInput-title'>입력 예제</p>
		                        <br />
		                        <p class='problem-examInput'>${subproblemvo.examInput }</p>
		                    </div>
		                    <hr class='division' />
		                    <div class='examOutput'>
		                        <p class='problem-examOutput-title'>출력 예제</p>
		                        <br />
		                        <p class='problem-examOutput'>${subproblemvo.examOutput }</p>
		                    </div>
	                  </div>                 
	                </div>
                </c:forEach>
            </div>
        </div>

        <div class='code-window'>
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
                    <input type='text' id="font-size" value="" />
                </div>
            </div>
            <div class='code-mirror'>
                <div class='cover'>
                    <div class='file'>
                        <div class='problem-explorer'>PROBLEM EXPLORER</div>
                        <hr />
                        <nav>
                            <ul class='problem-name'>
    					<c:forEach items='${savePathList }' var='vo' varStatus='status'>
								<li id="problem-packageList" class="problem-packageList" data-no="${vo.no}" data-no2="${vo.subProblemNo}"><img src="${pageContext.servletContext.contextPath }/assets/images/package.png"/>${saveVo.title}/${status.index+1}</li>
									<ol class="file${vo.no}">
<%-- 										<c:forEach items='${savePathList }' var='vo' varStatus='status'>
										</c:forEach> --%>
									</ol>								
								<ul class="contextmenu">
								</ul>
						</c:forEach>							

<!-- 							<form id="fileName-form">
								<input type="hidden" id="fileName" name="fileName" value=""  />
							</form> -->
	
	
	                                
<!--                                     <li>
	                                    <div class='problem-packageList'>
	                                        <img class="file-img" src="" />문제 1	                                
	                                        <div class='problem-file'>
	                                            <ul>
	                                               <li><img src=""/>파일 이름</li>
	                                            </ul>
	                                        </div>
	                                    </div>
                                    </li>
                                
                                
                                <div class='open'>
                                    
                                </div>
                                <button>+</button> -->
                            </ul>
                        </nav>
                    </div> 
                    
					<div class="codeTest">
				       <form action="" method="post" class="code-form">
	                      <textarea name="code" class="CodeMirror code">
/*
* 기본 언어 : 'JAVA'
* 기본 테마 : 'panda-syntax'
*/
public class Test{
	public static void main(String[] args) {
		System.out.println("Hello CodeForest!");
	}
}
							</textarea>
				         </form>
           			</div>

                       
                </div>
                

					
                <div class="terminal-cover">
                	<c:import url="/WEB-INF/views/codetree/terminal2.jsp"></c:import>
                </div>
            </div>
            
            
			<div id="dialog-message" title="" style="display:none">
  				<p></p>
			</div>	            
            
        </div>
    </div>
    
</body>
</html>