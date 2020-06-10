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
                    <select value="">
                        <option value='java'>Java</option>
                        <option value='javascript'>JavaScript</option>
                        <option value='python'>Python</option>
                        <option value='cpp'>C++</option>
                        <option value="csharp">C#</option>
                        <option value='c'>C</option>
                    </select>
                </div>
                <div class='theme-selector'>
                    <select value="">
                        <option value='monokai'>monokai</option>
                        <option value='github'>github</option>
                        <option value='tomorrow'>tomorrow</option>
                        <option value='kuroir'>kuroir</option>
                        <option value='twilight'>twilight</option>
                        <option value='solarized_dark'>solarized_dark</option>
                        <option value='solarized_light'>solarized_light</option>
                        <option value='terminal'>terminal</option>
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
                                <div class='problem-packageList']}>
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