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

 	
///////////////////////////// problem-list //////////////////////////////////
 	var ui = $(".ui"),
 	    sidebar = $(".ui__sidebar");

 	// File Tree
 	$(".folder").on("click", function(e) {
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
 	    tree
 	        .siblings()
 	        .removeClass("file-tree__item--open")
 	        .find(".folder--open")
 	        .removeClass("folder--open");
 	});	
 	
 	
 	
 	
});

	
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
	
	
	$(document).on('contextmenu', function() {
		  return false;
	});
	
	$(document).on('mousedown','.problem-packageList', function() {
		console.log("click!!!");  
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
	  
	    <div id="box_1" class="box">
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
                  <input type='text' id="font-size" value="" />
              </div>
          </div> 

	    <div class="frame horizontal" id="file-codemirror-cover">	    
	      <div id="box_2" class="box" style="display:flex;flex-direction:column">

		    <div class="ui__sidebar">
		        <ul class="file-tree">
		            <li class="file-tree__item file-tree__item--open">
		                <div class="folder folder--open">Project A</div>		
		                <ul class="file-tree__subtree">
		                    <li class="file-tree__item">
		                        <div class="folder">Planfolder</div>
		                    </li>
		                    <li class="file-tree__item">
		                        <div class="folder folder--open">Holiday</div>
		                    </li>
		                    <li class="file-tree__item">
		                        <div class="folder">Shared</div>
		                    </li>
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
         
	      </div>
	    </div>	    
	      <div name="resizerV1"></div>	      
	      <div id="box_4" class="box">
	      	<c:import url="/WEB-INF/views/codetree/terminal2.jsp"></c:import>
	      </div>
	  </div>
	  
	</div>

</div>
</body>
</html>