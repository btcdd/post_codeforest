<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Code Forest</title>
<link href="${pageContext.servletContext.contextPath }/assets/css/training/view.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath }/assets/css/include/footer.css">
<link href="${pageContext.servletContext.contextPath }/assets/css/include/header.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>
<%-- <link rel="stylesheet" href="${pageContext.servletContext.contextPath }/assets/ckeditor/contents.css"> --%>
<script>
var problemNo = '${problemVo.no}';
var array = new Array();

var saveProblem = function() {
	
	$.ajax({
		url: '${pageContext.request.contextPath }/api/training/save/problem',
		async: false,
		type: 'post',
		dataType: 'json',
		traditional: true,
		data: {
			'problemNo': problemNo,
			'subProblemNoArray': array
		},
		success: function(response){
			if(response.result != "success"){
				console.error(response.message);
				return;
			}
			$('#save').text('저장 해제');
		},
		error: function(xhr, status, e){
			console.error(status + ":" + e);
		}
	});
}

var recommendCheck = function() {
	$.ajax({
		url: '${pageContext.servletContext.contextPath }/api/training/recommend',
		async: false,
		type: 'post',
		dataType: 'json',
		traditional: true,
		data: {
			'problemNo': problemNo,
		},
		success: function(response){
			if(response.result != "success"){
				console.error(response.message);
				return;
			}
			map = response.data;
			
			$('#recommend').text('추천 ' + map.recommend);
		},
		error: function(xhr, status, e){
			console.error(status + ":" + e);
		}
	});
};

var savePandan = function() {
	$.ajax({
		url: '${pageContext.servletContext.contextPath }/api/training/savepandan',
		async: false,
		type: 'post',
		dataType: 'json',
		traditional: true,
		data: {
			'problemNo': problemNo,
		},
		success: function(response){
			if(response.result != "success"){
				console.error(response.message);
				return;
			}
			if(response.data == null) {
				$('#save').text('저장');
			} else {
				$('#save').text('저장 해제');
			}
		},
		error: function(xhr, status, e){
			console.error(status + ":" + e);
		}
	});
};

var deleteProblem = function() {
	$.ajax({
		url: '${pageContext.servletContext.contextPath }/api/training/delete',
		async: false,
		type: 'post',
		dataType: 'json',
		traditional: true,
		data: {
			'problemNo': problemNo,
		},
		success: function(response){
			if(response.result != "success"){
				console.error(response.message);
				return;
			}
			if(response.data == null) {
				$('#save').text('저장');
			} else {
				$('#save').text('저장 해제');
			}
		},
		error: function(xhr, status, e){
			console.error(status + ":" + e);
		}
	});
};

$(function() {
	
	savePandan();
	
	var no;
	
	$(".problem").click(function() {
		no = $(this).children().attr("id");
		
		$(".open" + no).toggle("slow");
	});
  
	$(document).on("click","#code-tree", function() {
      $.ajax({
         url:'${pageContext.request.contextPath }/api/codetraining/mylist/'+problemNo,
         async:false,
         type:'get',
         dataType:'json',
         data : '',
         success:function(response){
             var url = "http://localhost:9999/codingtraining?userEmail=" + response.data.authUser.email+ "&problemNo=" + response.data.problemVo.no;
             
             window.open(url,'_blank');
         },
         error: function(xhr, status, e) {
            console.error(status + ":" + e);
         }
      });
   });
	
	
	$('#save').click(function() {
		if($(this).text() == '저장') {
			saveProblem();
		} else {
			deleteProblem();
		}
	});
	
	for(var i = 0; i < ${listSize }; i++) {
		var subProblemNo = $('.sub' + i).attr("value");
		array.push(subProblemNo);
	}
	
	$('#recommend').click(function() {
		recommendCheck();
	});
});
</script>
</head>

<body>
    <c:import url="/WEB-INF/views/include/main-header.jsp" />
    <div class="container">
        <div class="top">
            <p class="division">${problemVo.no }</p>
            <p>${problemVo.title }</p>
			<p>조회수</p><p>${problemVo.hit + 1}</p>
            <button id="save"></button>
            <button id="code-tree">코드 트리로 가져오기</button>
            <a href="${pageContext.servletContext.contextPath }/training/statistics/${problemVo.no }"><button>통계</button></a>
            <button id="recommend">추천 ${problemVo.recommend }</button>
        </div>
        
        <div class="problem-list">
        	<c:forEach items='${list }' var='vo' step='1' varStatus='status'>
				<div class="problem">
					<div class="pro pro${status.index + 1}" id="${status.index + 1}">
						<p class="division">문제 ${status.index + 1} - 고유번호 ${vo.no }</p>
						<input class="sub${status.index }" type="hidden" value="${vo.no }" />
						<p id="click">${vo.title }</p>
						<a href="${pageContext.servletContext.contextPath }/training/answerlist/${status.index + 1}/${vo.no}"><button>맞은 사람</button></a>
						
						<div class="open${status.index + 1}">
							<div class="explain">
								<p>${vo.contents }</p>
							</div>
							<div class="example">
								<div class="input">
									<fieldset>
										<legend class="example-division">예제 입력</legend>
										<div class="input-content">${vo.examInput }</div>
									</fieldset>
								</div>
								<div class="result">
									<fieldset>
										<legend class="example-division">예제 출력</legend>
										<div class="result-content">${vo.examOutput }</div>
									</fieldset>
								</div>
							</div>
						</div>
						
					</div>
				</div>
			</c:forEach>
        </div>
        <c:if test="${problemVo.userNo eq authUser.no }">
        	<a href="${pageContext.servletContext.contextPath }/training/modify/${problemVo.no }">수정하기</a>
        </c:if>
    </div>
    <c:import url="/WEB-INF/views/include/footer.jsp" />
</body>

</html>