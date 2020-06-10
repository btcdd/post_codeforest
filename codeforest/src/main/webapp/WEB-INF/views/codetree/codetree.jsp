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

<script>
$(function() {
	
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
});

</script>
</head>
<body>

    <div class="header">
        <div class='logo'}>
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
                <p class='problem-title-head'>타이틀</p>
                <div class='problem'>
                    <li>
                        <div class='sub-problem-title'>
                            <p class='problem-index'>문제 1</p>
                            <p class='subtitle'>서브타이틀</p>
                        </div>
                        <div class='problem-open'>
                            <div class='contents'>
                                <p class='problem-contents-title'>문제 내용</p>
                                <br />
                                <p class='problem-contents'>문제 내용~~</p>
                            </div>
                            <hr class='division' />
                            <div class='examInput'>
                                <p class='problem-examInput-title'>입력 예제</p>
                                <br />
                                <p class='problem-examInput'>1111</p>
                            </div>
                            <hr class='division' />
                            <div class='examOutput'>
                                <p class='problem-examOutput-title'>출력 예제</p>
                                <br />
                                <p class='problem-examOutput'>2</p>
                            </div>
                        </div>
                    </li>
                </div>
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
                    <input type='text' value="" />
                </div>
            </div>
            <div class='code-mirror'>
                <div class='cover'>
                    <div class='file'>
                        <div class='problem-explorer'>PROBLEM EXPLORER</div>
                        
                        <hr />
                        <nav>
                            <ul class='problem-name'>
                                <div class='problem-packageList'>
                                    <li>
                                        <img class="file-img" src="" />문제 1
                                
                                        <div class='problem-file'>
                                            <ul>
                                               <li><img src=""/>파일 이름</li>
                                            </ul>
                                        </div>
                                    </li>
                                </div>
                                
                                <div class='open'>
                                    
                                </div>
                                <button>+</button>
                            </ul>
                        </nav>
                    </div> 
                    
					<div class="codeTest">
				       <form action="" method="post" class="code-form">
	                      <textarea name="code" class="CodeMirror code" id="code">
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
                <div class='result'>
                    <div class='result-header'>
                        <img class='cmd-img' style="width: 13px;"/><p class='cmd-title'>명령 프롬프트</p>
                    </div>
                    <div class='result-body'>
                        <p>CodeForest Windows [Version 10.0.18363.836]</p>
                        <br></br>
                        <p>(c) 2020 CodeForest Corporation. All rights reserved.</p>
                        <br></br>
                        <p>> <span>ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋzzzzzzㅋㅋ</span></p><p>></p><p class='under-bar'>_</p>
                    </div>
                </div>

            </div>
        </div>
    </div>
    
</body>
</html>