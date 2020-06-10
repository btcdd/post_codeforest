<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="${pageContext.servletContext.contextPath }/assets/css/training/modify.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.servletContext.contextPath }/assets/css/training/header.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.servletContext.contextPath }/assets/css/sample.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript"
	src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>
<script type="text/javascript"
	src="${pageContext.servletContext.contextPath }/assets/ckeditor/ckeditor.js"></script>

<!-- code mirror -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/codemirror/css/codemirror.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/codemirror/theme/abcdef.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/codemirror/theme/blackboard.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/codemirror/theme/dracula.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/codemirror/theme/duotone-light.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/codemirror/theme/eclipse.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/codemirror/theme/moxer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/codemirror/theme/neat.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/codemirror/theme/panda-syntax.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/codemirror/theme/solarized.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/assets/codemirror/theme/ttcn.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/codemirror/js/codemirror.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/codemirror/mode/clike.js"></script>

<title>Code Forest</title>
<script>
var index = ${listSize };

var array = new Array();
var top = 0;

var str;

var buttonStr;

var fetchStr;
var fetchButtonStr;

var password = '${problemVo.password }';

var problemAdd = function() {

	str = '<div class="prob' + index + '">'
			+ '<h3>문제 '
			+ (index + 1)
			+ '</h3>'
			+ '<div class="sub-title">'
			+ '문제 제목<input type="text" name="subProblemList[' + index + '].title" required/>'
			+ '</div>'
			+ '<div class="prob-content">'
			+ '<div class="prob-content-title">내용</div>'
			+ '<textarea class="content" id="prob-content-text' + index + '" name="subProblemList[' + index + '].contents" required></textarea>'
			+ '</div>'
			+ '<div class="ex-input">'
			+ '<div class="ex-input-title">예제 입력</div>'
			+ '<textarea id="ex-input-text" name="subProblemList[' + index + '].examInput"></textarea>'
			+ '</div>'
			+ '<div class="ex-output">'
			+ '<div class="ex-output-title">예제 출력</div>'
			+ '<textarea id="ex-output-text" name="subProblemList[' + index + '].examOutput" required></textarea>'
			+ '</div>'
			+ '<div class="answer-code' + index + '">'
			+ '<div class="ex-input-title">정답 코드</div>'
			+ '<div>'
			+ '<select name="lang">'
			+ '<option value="none" selected="selected">언어선택</option>'
			+ '<option value="c">C</option>'
			+ '<option value="cpp">C++</option>'
			+ '<option value="cs">C#</option>'
			+ '<option value="java">JAVA</option>'
			+ '<option value="js">JavaScript</option>'
			+ '<option value="py">Python</option>'
			+ '</select>'
			+ '</div>'
			+ '<textarea id="code' + index + '" name="subProblemList[' + index + '].correctCode"></textarea>'
			+ '</div></div>';

	buttonStr = '<li id="' + index + '" class="tablinks">문제 ' + (index + 1) + '<span class="delete"><img src="${pageContext.request.contextPath}/assets/images/training/delete.png"></span></li>';
}

var fetchList = function() {

	if(password !== '') {
		
		var sd = '${problemVo.startTime}';
		var startDate = sd.substring(0, 10);
		startDate = startDate + 'T';
		startDate = startDate + sd.substring(11, 16);
		
		var ed = '${problemVo.endTime}';
		var endDate = ed.substring(0, 10);
		endDate = endDate + 'T';
		endDate = endDate + sd.substring(11, 16);
		
		if('${problemVo.password}' != '') {
			var privateStr = '<div class="private">코딩테스트 <input class="codingtest" type="checkbox" checked></div>';
		} else {
			var privateStr = '<div class="private">코딩테스트 <input class="codingtest" type="checkbox"></div>';
		}
		
		if('${problemVo.privacy}' == 'y') {
			var privacyStr = '<div class="privacy-check"><p>코딩테스트가 끝난 뒤 문제를 공개하시려면 선택하세요</p> 공개여부 <input type="checkbox" name="privacy" checked></div>';
		} else {
			var privacyStr = '<div class="privacy-check"><p>코딩테스트가 끝난 뒤 문제를 공개하시려면 선택하세요</p> 공개여부 <input type="checkbox" name="privacy" ></div>';
		}
		
		var passwordStr = '<div class="password">비밀번호 <input type="password" name="password" value="${problemVo.password}" required></div>';
		var startDateStr = '<div class="start-date">시작일자 <input type="datetime-local" name="startTime" value="' + startDate + '" required></div>';
		var endDateStr = '<div class="end-date">마감일자 <input type="datetime-local" name="endTime" value="' + endDate + '" required></div>';
		
		$(".privateAndPassword").append(privateStr);
		$(".privateAndPassword").append(passwordStr);
		$(".privacy").append(privacyStr);
		$(".date").append(startDateStr);
		$(".date").append(endDateStr);
	}
	
	
	for(var i = 0; i < index; i++) {
		// 정답 코드 텍스트에 코드 미러 적용!
		var code = $('#code' + i)[0];
		var editor = CodeMirror.fromTextArea(code, {
			lineNumbers : true,
			mode : 'text/x-java',
			theme : 'panda-syntax',
			matchBrackets : true
		});
		$(".prob" + i).hide();
	}
	$('.prob0').show();
	$('#0').attr('name', 'selected');
}

$(function() {
	
	fetchList();
	
	// 추가된 문제에 코드 미러 적용
	var code = $('#code0')[0];
	var editor = CodeMirror.fromTextArea(code, {
		lineNumbers : true,
		mode : 'text/x-java',
		theme : 'panda-syntax',
		matchBrackets : true
	});
	
	$('#addSubProblem').click(function() {
		event.preventDefault();

		console.log('asdf');
		problemAdd();

		$("#" + (index - 1)).after(buttonStr);
		$(".prob" + (index - 1)).after(str);
		$('.prob' + (index - 1)).hide();
		
		$('li[name=selected]').removeAttr('name');
		$('#' + index).attr('name', 'selected');

		// 추가된 문제에 CKEditor 적용
// 		CKEDITOR.replace('prob-content-text' + index);

		// 추가된 문제에 코드 미러 적용
		var code = $('#code' + index)[0];
		var editor = CodeMirror.fromTextArea(code, {
			lineNumbers : true,
			mode : 'text/x-java',
			theme : 'panda-syntax',
			matchBrackets : true
		});

		index++;
	});

	$(document).on("click", ".tablinks", function() {
		event.preventDefault();

		$('.tabcontent').children().hide();

		var ind = $(this).attr('id');
		$('li[name=selected]').removeAttr('name');
		$('#' + ind).attr('name', 'selected');
		
		$('.prob' + (ind)).show();
	});

	// CKEDITOR.replace('contents');

	// 코딩테스트 체크박스를 체크하면, 비밀번호와 시작 일자, 마감 일자를 설정할 수 있는 칸이 나타난다.
	$('.codingtest').click(function() {
		if ($(this).prop("checked")) {
			var passwordStr = '<div class="password">비밀번호 <input type="password" name="password" required></div>';
			var privacyStr = '<div class="privacy-check"><p>코딩테스트가 끝난 뒤 문제를 공개하시려면 선택하세요</p> 공개여부 <input type="checkbox" name="privacy"></div>';
			var startDateStr = '<div class="start-date">시작일자 <input type="datetime-local" name="startTime" required></div>';
			var endDateStr = '<div class="end-date">마감일자 <input type="datetime-local" name="endTime" required></div>';
	
			$(".privateAndPassword").append(passwordStr);
			$(".privacy").append(privacyStr);
			$(".date").append(startDateStr);
			$(".date").append(endDateStr);
		} else {
			$(".privateAndPassword .password").remove();
			$(".privacy-check").remove();
			$(".date .start-date").remove();
			$(".date .end-date").remove();
		}
	});
	
	$(document).on("click", ".delete", function() {
		if(index == 1) {
			alert('최소 1문제는 등록하셔야 합니다.');
			return;
		}
		
		console.log('asdfasdf');
		
		var ind = $(this).parent().attr('id');
		var deleteNo = $(this).parent().attr("value");
		array.push(deleteNo);
		
		$("#" + ind).remove();
		$('.prob' + ind).remove();
		
		for(var i = 0; i < index; i++) {
			if(!($('#' + i).attr('id'))) {
				for(var j = i + 1; j < index; j++) {
					$('#' + j).text('문제 ' + j.toString() + ' ');
					$('#' + j).append('<span class="delete"><img src="${pageContext.request.contextPath}/assets/images/training/delete.png"></span>');
					$('.prob' + j + ' h3').text('문제 ' + j.toString());
					
					// li id 설정
					$('#' + j).attr('id', (j-1).toString());
					// prob class 설정
					$('.prob' + j).attr('class', 'prob' + (j-1).toString());
				}
			}
		}
		
		index--;
	});
	
	var no;
	
	$('#fake-submit').click(function() {
		event.preventDefault();
		
		var str = $('.content').val();
		str = str.replace(/(?:\r\n|\r|\n)/g, '<br />');
		$('.content').val(str);
		
		$('.privateAndPassword').append('<input type="hidden" name="array" value="' + array + '">');
		$("#true-submit").trigger("click");
	});
});
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/include/main-header.jsp" />
	<form method="post" action="${pageContext.servletContext.contextPath }/training/modify/${problemVo.no }">
		<div class="regist">
			<div class="privateAndPassword">
<!-- 				<div class="private"> -->
<!-- 					코딩테스트 <input class="codingtest" type="checkbox"> -->
<!-- 				</div> -->
				<!-- <div class="password">비밀번호 <input type="password"></div> -->
			</div>
			<div class="privacy">
				<!-- 코딩테스트가 끝난 뒤 문제를 공개하시려면 선택하세요<div class="privacy">공개여부 <input type="checkbox" name="privacy" required></div> -->
			</div>
			<div class="date">
				<!-- <div class="start-date">시작일자 <input type="datetime-local"></div> -->
				<!-- <div class="end-date">마감일자 <input type="datetime-local"></div> -->
			</div>

			<div class="divisionAndLanguage">
				<div class="division">
					분류 <select name="kindNo">
							<option value="5" selected="selected">기타</option>
							<option value="1">기업</option>
							<option value="2">개인</option>
							<option value="3">학원</option>
							<option value="4">학교</option>
					</select>
				</div>
			</div>
			<br />
			<div class="title">
				문제집 제목<input id="title-text" type="text" name="title" value="${problemVo.title }" required />
				<a id="btn-cancel"
					href="${pageContext.servletContext.contextPath }/training">취소</a> 
				<input id="fake-submit" type="submit" value="등록">
				<input id="true-submit" type="submit" value="등록" style="display:none">
			</div>
			<br />
			<div class="write-container">
				<div class="tab">
					<ul>
						<c:forEach items="${list }" var="item" varStatus="status" begin="0">
							<li id="${status.index }" class="tablinks" value="${item.no }">문제 ${status.index + 1} <span class="delete"><img src="${pageContext.request.contextPath}/assets/images/training/delete.png"></span></li>
						</c:forEach>
						<li id="addSubProblem">+</li>
					</ul>
					
				</div>

				<div id="problem" class="tabcontent">
					<c:forEach items="${list }" var="item" varStatus="status" begin="0">
						<c:set var="index" value="${status.index }" />
						<div class="prob${index }">
							<h3>문제 ${index + 1 }</h3>
							<input type="hidden" name="subProblemList[${index }].no" value="${item.no }" />
							<div class="sub-title">
								문제 제목<input type="text" name="subProblemList[${index }].title" value="${item.title }"required />
							</div>
							<div class="prob-content">
								<div class="prob-content-title">내용</div>
								<textarea class="content" id="prob-content-text${index }"
									name="subProblemList[${index }].contents" required>${fn:replace(item.contents, "<br />", newLine)}</textarea>
							</div>
							<br />
	
							<div class="ex-input">
								<div class="ex-input-title">예제 입력</div>
								<textarea id="ex-input-text" name="subProblemList[${index }].examInput">${item.examInput }</textarea>
							</div>
	
							<div class="ex-output">
								<div class="ex-output-title">예제 출력</div>
								<textarea id="ex-output-text" name="subProblemList[${index }].examOutput" required>${item.examOutput }</textarea>
							</div>
	
	
							<div class="answer-code${index }">
								<div class="ex-input-title">정답 코드</div>
								<div>
									<select name="lang">
										<option value="none" selected="selected">언어선택</option>
										<option value="c">C</option>
										<option value="cpp">C++</option>
										<option value="cs">C#</option>
										<option value="java">JAVA</option>
										<option value="js">JavaScript</option>
										<option value="py">Python</option>
									</select>
								</div>
								<textarea id="code${index }" name="subProblemList[${index }].correctCode">${item.correctCode }</textarea>
							</div>
						</div> <!--  prob0 -->
					</c:forEach>
				</div>
			</div>
		</div>
	</form>
</body>
</html>