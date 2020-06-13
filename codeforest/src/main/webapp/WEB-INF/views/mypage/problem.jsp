<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Code Forest</title>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath }/assets/css/mypage/problem.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
  	<script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/table2excel.js"></script>
<script>

var page = '1';

var originList = function() {
	$.ajax({
		url: '${pageContext.request.contextPath }/api/mypage/problem',
		async: false,
		type: 'post',
		dataType: 'json',
		traditional: true,
		data: {
			'page': page,
		},
		success: function(response){
			if(response.result != "success"){
				console.error(response.message);
				return;
			}
			map = response.data;
			
			fetchList();
		},
		error: function(xhr, status, e){
			console.error(status + ":" + e);
		}
	});
}

var fetchList = function() {
    $("#list-contents").remove();
	$("#pager").remove();
	
	var str = "";
	for(var i = 0; i < map.list.length; i++){
		str += '<tr class="list-contents" id="list-contents" data-no="' + map.list[i].no + '">' + 
	    		   '<td><a data-no="' + map.list[i].no + '">' + map.list[i].no + '</a></td>' + 
	               '<td class="problem-title" data-no="' + map.list[i].no + '" style="text-align: left">' + map.list[i].title + '</td>' + 
	               '<td>' + map.list[i].hit + '</td>' + 
	               '<td>' + map.list[i].recommend + '</td>' + 
	               '<td><a href="${pageContext.servletContext.contextPath }/training/modify/' + map.list[i].no + '"><button id="modify-btn">수정하기</button></a></td>' + 
	          	   '<td><input data-no="' + map.list[i].no + '" data-title="' + map.list[i].title + '" type="button" alt="list" class="list" value="내보내기"></td>' + 
	               '<td><input data-no="' + map.list[i].no + '" type="button" alt="delete" class="delete" value="삭제"></td>' + 
    	   		'</tr>' + 
    			'<tr class="sub-problem-contents' + map.list[i].no + '">' + 
    				'<td></td>' + 
        			'<td colspan="5">' + 
            			'<table id="sub-problem-table" class="' + map.list[i].no + '" style="display: none;">' + 
            				'<tbody class="sub-problem-tbody"></tbody>' + 
            			'</table>' + 
        			'</td>' + 
       			'</tr>';
	}
	$("#problem-tbody").append(str);
	
	var str2 = '<div class="pager" id="pager">';
	
	if(page != '1'){
		str2 += '<span class="prev"><i class="fas fa-angle-left"></i></span>';
	}	
	for(var i = map.startPageNum; i < map.endPageNum; i++){
		str2 += '<span class="page" id="' + i + '">';
		if(map.select != i ) {
			str2 += i;
		}
		if(map.select == i){
			str2 += '<b>'+i+'</b>';
		}
		str2 += '</span>';
	}
	if(map.next){
		str2 += '<span class="next"><i class="fas fa-angle-right"></i></span>';
	}	 
	str2 += "</div>";
		
	$(".quiz-table").after(str2);
}

$(function() {
	
	originList();
	
	var dialogDelete = $("#dialog-delete").dialog({
		autoOpen: false,
		resizable: false,
		height: "auto",
		width: 400,
		modal: true,
		buttons: {
			"삭제": function() {
				var no = $("#hidden-no").val();
				$.ajax({
					url: '${pageContext.servletContext.contextPath }/api/mypage/problem/delete/' + no,
					async: true,
					type: 'delete',
					dataType: 'json',
					data: '',
					success: function(response) {
						dialogDelete.dialog('close');
						// 삭제 추가해야하는 곳
						$(".list-contents[data-no=" + no + "]").remove();
						$(".sub-problem-contents" + no).remove();
					},
					error: function(xhr, status, e) {
						console.error(status + ":" + e);
					}
				});
			},
			"취소": function() {
				$(this).dialog('close');
			}
		},
		close: function() {
			$("#hidden-no").val('');
			$("#dialog-delete-form p.validateTips.error").hide();
		}
	});
	
	$(document).on('click', '.delete', function(event) {
		event.preventDefault();
		
		var no = $(this).data('no');
		$('#hidden-no').val(no);
		dialogDelete.dialog('open');
	});
	
	// ------------------------------------- 문제 푼 사람 리스트 출력 --------------------------------------
	var dialogList = $(".problem-list").dialog({
		autoOpen: false,
		resizable: false,
		height: "auto",
		width: 1200,
		modal: true,
		buttons: {
			"다운로드": function() {		
				var title = $("#hidden-title").val();
				$(".problem-list-table").table2excel({
					exclude: ".discard",
					filename: title.concat(".xls")
				})
			},
			"취소": function() {
				$(this).dialog('close');
			}
		},
		close: function() {
			$(".problem-list-table tr th").removeClass();
			$(".problem-list-table tr th").show();
			$(".box-component").each(function(){
			       $(this).prop('checked',true);
			});
			$(".problem-list-table > #tbody > tr").remove();
			$("#hidden-no").val('');
		}
	});
	
	$(document).on('click', '.list', function(event) {
		event.preventDefault();
		
		var no = $(this).data('no');		
		var title = $(this).data('title');
		$('#hidden-title').val(title);
		
		$.ajax({
			url: '${pageContext.servletContext.contextPath }/api/mypage/problem/list/' + no,
			async: true,
			type: 'post',
			dataType: 'json',
			data: '',
			success: function(response) {
				var table = "";
				for(var i in response.data) {
					table += "<tbody id='tbody'>" +
							"<tr><td id='name'>" + response.data[i].name + "</td>" +
							"<td id='email'>" + response.data[i].email + "</td>" + 
							"<td id='nickname'>" + response.data[i].nickname + "</td>" +
							"<td id='try-count'>" + response.data[i].tryCount + "</td>" + 
							"<td id='lang'>" + response.data[i].lang + "</td>" +
							"<td id='solve-time'>" + response.data[i].solveTime + "</td></tr></tbody>";
				}
				$(".problem-list-table").append(table);
				dialogList.dialog('open');
			},
			error: function(xhr, status, e) {
				console.error(status + ":" + e);
			}
		});
	});
	
	
	$(document).ready(function(){
	    $(".check-box input").on('click', function(){
	    	var value = $(this).val();
	        if($(this).prop("checked")){
	        	$(".problem-list-table > #tbody > tr > td#".concat(value)).show();
	        	$(".problem-list-table > #tbody > tr > td#".concat(value)).removeClass();
				$(".problem-list-table tr th#".concat(value)).show();
				$(".problem-list-table tr th#".concat(value)).removeClass();
	        }else{
	        	$(".problem-list-table > #tbody > tr > td#".concat(value)).hide();
	        	$(".problem-list-table > #tbody > tr > td#".concat(value)).addClass('discard');
				$(".problem-list-table tr th#".concat(value)).hide();
				$(".problem-list-table tr th#".concat(value)).addClass('discard');
	        }
	    });
	});
	
	// ------------------------------------------- 서브 문제 출력 -------------------------------------------------------
	$(".problem-title").on('click', function() { 
    	var no = $(this).data('no');
    	
    	if($("." + no).css('display') == 'none') {
    		$("." + no + " > .sub-problem-tbody > tr").remove();
    	}
    	
        $.ajax({
			url: '${pageContext.servletContext.contextPath }/api/mypage/sub-problem/' + no,
			async: true,
			type: 'post',
			dataType: 'json',
			data: '',
			success: function(response) {
				if(response.data.length == 0) {
					return;
				}
				var tr = "";				
				for(var i in response.data) {
					tr += '<tr id="sub-problem' + response.data[i].no + '"><td class="sub-problem-padding1">' + response.data[i].no +'</td>' + 
						'<td class="sub-problem-padding2">' + response.data[i].title + '</td>' + 
						'<td><input data-no="' + response.data[i].no + '" type="button" alt="delete" class="sp-delete" value="삭제"></td></tr>'

				}			
				$("." + no + " .sub-problem-tbody").append(tr);
				$("." + no).toggle();
			},
			error: function(xhr, status, e) {
				console.error(status + ":" + e);
			}
		});    
	});
	
	// ----------------------------------------------- 서브 문제 삭제 ----------------------------------------
	var dialogSpDelete = $("#dialog-delete-sp").dialog({
		autoOpen: false,
		resizable: false,
		height: "auto",
		width: 400,
		modal: true,
		buttons: {
			"삭제": function() {
				var no = $("#hidden-sp-no").val();
				var tableClass = $("#hidden-table-class").val();
				$.ajax({
					url: '${pageContext.servletContext.contextPath }/api/mypage/sub-problem/delete/' + no,
					async: true,
					type: 'delete',
					dataType: 'json',
					data: '',
					success: function(response) {		
						dialogSpDelete.dialog('close');						
						$('#sub-problem'+no).remove();
					},
					error: function(xhr, status, e) {
						console.error(status + ":" + e);
					}
				});
			},
			"취소": function() {
				$(this).dialog('close');
			}
		},
		close: function() {			
			$("#hidden-sp-no").val('');
			$("#hidden-table-class").val('');
		}
	});
	
	$(document).on('click', '.sp-delete', function(event) {
		event.preventDefault();
		
		var spNo = $(this).data('no');
		var tableClass = $("#sub-problem-table").attr('class');
		console.log("spno=" + spNo);
		$('#hidden-sp-no').val(spNo);
		$('#hidden-table-class').val(tableClass);
		dialogSpDelete.dialog('open');
	});
});
</script>
    
</head>

<body>
    <c:import url="/WEB-INF/views/include/mypage-header.jsp" />
    <div class="container">
        <div class="quizlist">
            <div class="line">
                <h4>작성한 퀴즈</h4>
            </div>
            <br>
            <table class="quiz-table">
            	<thead>
	                <tr>
	                    <th width="9%">번호</th>
	                    <th width="47%">제목</th>
	                    <th width="10%">조회수</th>
	                    <th width="10%">추천수</th>
	                    <th width="10%">수정</th>
	                    <th width="10%">목록</th>
	                    <th width="10%">삭제</th>
	                </tr>
                </thead>
                <tbody id="problem-tbody">
                </tbody>
                
            </table>
				
			<!-- pager 추가 -->      
            
            <br>
        </div>

    </div>
    
    <div id="dialog-delete" title="문제 모음 삭제" style="display: none">
    	<p>
    		<span class="ui-icon ui-icon-alert" style="float: left; margin: 12px 12px 20px 0;">	
    		</span>
    		해당 문제 모음을 삭제하시겠습니까?
    	</p>
    	<form>
    		<input type="hidden" id="hidden-no" value="">
    		<input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    	</form>
    </div>
    
    <div id="dialog-delete-sp" title="서브 문제 삭제" style="display: none">
    	<p>
    		<span class="ui-icon ui-icon-alert" style="float: left; margin: 12px 12px 20px 0;">	
    		</span>
    		해당 서브 문제를 삭제하시겠습니까?
    	</p>
    	<form>
    		<input type="hidden" id="hidden-sp-no" value="">
    		<input type="hidden" id="hidden-table-class" value="">
    		<input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    	</form>
    </div>
    
    <div class="problem-list" title="문제 푼 사람 리스트" style="display: none">
    	<input type="hidden" id="hidden-title" value="">
    	<div class="check-box">
	    	<label><input class="box-component" type="checkbox" name="problem-list-table" value="name" checked>이름</label>
	    	<label><input class="box-component" type="checkbox" name="problem-list-table" value="email" checked>이메일</label>
	    	<label><input class="box-component" type="checkbox" name="problem-list-table" value="nickname" checked>닉네임</label>
	    	<label><input class="box-component" type="checkbox" name="problem-list-table" value="try-count" checked>시도횟수</label>
	    	<label><input class="box-component" type="checkbox" name="problem-list-table" value="lang" checked>언어</label>
	    	<label><input class="box-component" type="checkbox" name="problem-list-table" value="solve-time" checked>해결시간</label>
    	</div>
    	<table class="problem-list-table">
    		<tr>
            	<th id="name">이름</th>
                <th id="email">이메일</th>
                <th id="nickname">닉네임</th>
                <th id="try-count">시도횟수</th>
                <th id="lang">언어</th>
                <th id="solve-time">해결시간</th>
            </tr>           
    	</table>

    </div>
    
</body>

</html>