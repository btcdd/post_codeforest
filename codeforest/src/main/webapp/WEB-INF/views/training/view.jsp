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
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script>
document.addEventListener('DOMContentLoaded', function() {
	  var likeButton = document.getElementById('like-button');
	  likeButton.addEventListener('click', function() {
	    window.lb = likeButton;
		likeButton.classList.toggle('selected');
	    recommendCheck();
	  });
}, false);

document.addEventListener('DOMContentLoaded', function() {
	  var saveButton = document.getElementById('save-button');
	  saveButton.addEventListener('click', function() {
	    window.lb = likeButton;
	    saveButton.classList.toggle('selected');
	  });
}, false);


var problemNo = '${problemVo.no}';
var array = new Array();

var linuxSaveCode = function() {
	
	$.ajax({
		url: '${pageContext.request.contextPath }/api/training/linux/savecode',
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
		},
		error: function(xhr, status, e){
			console.error(status + ":" + e);
		}
	});
}

var recommendCheck = function() {
	var likeButton = document.getElementById('like-button');
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
			$('#recommend-num').text(map.recommend);
		},
		error: function(xhr, status, e){
			console.error(status + ":" + e);
		}
	});
};

var originRecommend = function() {
	var likeButton = document.getElementById('like-button');
	$.ajax({
		url: '${pageContext.servletContext.contextPath }/api/training/recommend/origin',
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
			if(map.check > 0) {
				$('#like-button').addClass('selected');
			}
			$('#recommend-num').text(map.recommend);
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
			linuxSaveCode();
		},
		error: function(xhr, status, e){
			console.error(status + ":" + e);
		}
	});
}

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
	originRecommend();
	
	savePandan();
	
	var no;
	
	$(".open1").show();
	
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
	
	$('#save-button').click(function() {
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
	
});
</script>
</head>

<body>
    <c:import url="/WEB-INF/views/include/main-header.jsp" />
    <div class="container">
        <div class="top">
            <p class="no">${problemVo.no }</p>
            <div class="problem-title">${problemVo.title }</div>
            <div class="save-div">
	            <button type="button" id="save-button">
	            <i class="fas fa-save"></i>
				  저장
				</button>
            </div>
            <div class="recommend-div">
            <button type="button" id="like-button">
            	<i class="fas fa-heart"></i>
			  추천<p id="recommend-num">${problemVo.recommend }</p>
			</button>
            </div>
        </div>
        <div class="second-block">
        	<div style="display: inline-block">
	            <a href="${pageContext.servletContext.contextPath }/training/statistics/${problemVo.no }"><button>통계</button></a>
        	</div>
        	<div style="display: inline-block;     ">
	        	<p class="problem-hit">조회수 ${problemVo.hit + 1}</p>
        	</div>
        </div>
        <div class="problem-list">
        	<c:forEach items='${list }' var='vo' step='1' varStatus='status'>
				<div class="problem">
					<div class="pro pro${status.index + 1}" id="${status.index + 1}">
						<div class="top-prob">
							<p class="division">문제 ${status.index + 1} - 고유번호 ${vo.no }</p>
							<input class="sub${status.index }" type="hidden" value="${vo.no }" />
							<p id="click">${vo.title }</p>
							<a href="${pageContext.servletContext.contextPath }/training/answerlist/${status.index + 1}/${vo.no}"><button>맞은 사람</button></a>
						</div>
						
						<div class="open${status.index + 1}" style="display:none">
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
