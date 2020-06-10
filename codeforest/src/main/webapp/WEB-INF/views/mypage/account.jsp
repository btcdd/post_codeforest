<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Code Forest</title>
<link rel="stylesheet" href="${pageContext.servletContext.contextPath }/assets/css/mypage/account.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
    
var no = '${authUser.no}';
var email = '${authUser.email}';
var currentURL = '${pageContext.request.contextPath }/mypage/account'

var pandan = false;

var privacy;

var changeNickname = function(nickname) {
	$.ajax({
        url: '${pageContext.request.contextPath }/api/mypage/account/nickname',
        async: true,
        type: 'post',
        dataType: 'json',
        data: {
        	"nickname" : nickname,
        	"no" : no
        },
        success: function(response){
           if(response.result != "success") {
              console.error(response.message);
              return;
           }
        },
        error: function(xhr, status, e) {
           console.error(status + ":" + e);
        }
     });
}

var changePassword = function(password) {
	$.ajax({
        url: '${pageContext.request.contextPath }/api/mypage/account/password',
        async: true,
        type: 'post',
        dataType: 'json',
        data: {
        	"password" : password,
        	"no" : no
        },
        success: function(response){
           if(response.result != "success") {
              console.error(response.message);
              return;
           }
        },
        error: function(xhr, status, e) {
           console.error(status + ":" + e);
        }
     });
}

var deleteUser = function(password) {
	  $.ajax({
        url: '${pageContext.request.contextPath }/api/mypage/account/delete',
        async: true,
        type: 'post',
        dataType: 'json',
        data: {
        	"password" : password,
        	"email" : email,
        	"no" : no
        },
        success: function(response){
           if(response.data == 0) {
        	   pandan =  false;            	   
           } else {
        	   pandan = true;
        	   $("#delete-user").dialog("close");
        	   window.location = "${pageContext.request.contextPath }";
           }
           if(response.result != "success") {
        	   pandan = false;
               console.error(response.message);
           }
           return pandan;
        },
        error: function(xhr, status, e) {
           console.error(status + ":" + e);
        }
      });   
	  return pandan;
}

var passwordIncorrect = true;

var privacyChange = function() {
	$.ajax({
        url: '${pageContext.request.contextPath }/api/mypage/account/privacy',
        async: true,
        type: 'post',
        dataType: 'json',
        data: {
        	"privacy" : privacy	
        },
        success: function(response){
           
        },
        error: function(xhr, status, e) {
           console.error(status + ":" + e);
        }
   });
}

$(function() {
	
    $("#change-nickname").dialog({
        autoOpen: false,
        resizable: false,
        height: "auto",
        width: 400,
        modal: true,
        buttons: {
            "완료": function() {
            	changeNickname($('#nickname').val());
            	$(this).dialog("close");
            	window.location = "${pageContext.request.contextPath }/mypage/account";
            },
            Cancel: function() {
                $(this).dialog("close");
            }
        }
    });
    $(document).on("click","#nickname-btn", function(event) {
    	event.preventDefault();
    	
    	$("#change-nickname").dialog("open");
    });

    $("#delete-user").dialog({
        autoOpen: false,
        resizable: false,
        height: "auto",
        width: 400,
        modal: true,
        buttons: {
            "회원 탈퇴": function() {
            	if(deleteUser($('#delete').val())) {
            		$('#delete').val('');
            		$(this).dialog("close");
            		
            	} else {
            		if(passwordIncorrect) {
            			$(this).append("<pre id=passwordIncorrect>비밀번호가 맞지 않습니다.</pre>");
            			passwordIncorrect = false;
            		}
            	}
            },
            "취소": function() {
            	passwordIncorrect = true;
            	$('#delete').val('');
            	$('#passwordIncorrect').remove();
                $(this).dialog("close");
            }
        }
    });
    $("#delete-btn").on("click", function(event) {
    	event.preventDefault();
    	
        $("#delete-user").dialog("open");
    });

    $("#change-password").dialog({
        autoOpen: false,
        resizable: false,
        height: "auto",
        width: 400,
        modal: true,
        buttons: {
            "변경": function() {
            	changePassword($('#password').val());
                $(this).dialog("close");
            },
            "취소": function() {
                $(this).dialog("close");
            }
        }
    });
    $("#password-btn").on("click", function(event) {
    	event.preventDefault();
    	
        $("#change-password").dialog("open");
    });
    
    $("#privacy").dialog({
        autoOpen: false,
        resizable: false,
        height: "auto",
        width: 400,
        modal: true,
        buttons: {
            "확인": function() {
            	privacyChange();
            	$(this).dialog("close");
            },
            "취소": function() {
                $(this).dialog("close");
            }
        }
	});
    
    $('.privacy').click(function() {
    	privacy = $(this).val();
    	
    	$("#privacy").dialog("open");
    })
});
</script>
</head>

<body>
    <c:import url="/WEB-INF/views/include/mypage-header.jsp" />
    <div class="container">
        <div class="nickname">
            <div class="line">
                <h4>닉네임 변경</h4>
            </div>
            <button id="nickname-btn">변경</button>
        </div>
        <div class="password">
            <div class="line">
                <h4>비밀번호 변경</h4>
            </div>
            <button id="password-btn">비밀번호 변경</button>
        </div>
        <div class="disclosure">
            <div class="line">
                <h4>계정 공개 여부</h4>
            </div>
            <h4>계정 비공개를 설정하시겠습니까?</h4>
            계정 공개를 설정하시면 문제를 푼 기록, 팔로우와 관련된 모든 기록을 다른 사람이 열람 할 수 있습니다.
			<div class="privacy-div">
	            <input type="radio" name="chk_info" value="open" checked="checked">공개
	            <input type="radio" name="chk_info" value="private">비공개
			</div>
        </div>
        <div class="delete">
            <div class="line">
                <h4>계정 삭제</h4>
            </div>
            <h4>회원 탈퇴를 하시겠습니까?</h4>
            <p>
                회원 탈퇴를 하시면 문제를 푼 기록이 다 사라집니다.
            </p>
            <button id="delete-btn">회원 탈퇴</button>
        </div>
    </div>
    
    <div id="change-nickname" title="닉네임 변경" style="display:none" >
	        변경하실 닉네임을 입력해주세요.
	        <form>
	            <fieldset>
	                <label for="name">닉네임 입력 : </label>
	                <input type="text" name="nickname" id="nickname" value="${authUser.nickname }" class="text ui-widget-content ui-corner-all">
	
	                <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
	            </fieldset>
	        </form>
	    </div>
	
	    <div id="change-password" title="비밀번호 변경" style="display:none" >
	        <pre>
	            변경하시려는 비밀번호를 입력해주세요.
	        </pre>
	        <form>
	            <fieldset>
	                <label for="name">변경 비밀번호 : </label>
	                <input type="text" name="password" id="password" value="" class="text ui-widget-content ui-corner-all">
	                <label for="name">비밀번호 확인: </label>
	                <input type="text" name="passwordSecond" id="passwordSecond" value="" class="text ui-widget-content ui-corner-all">
	
	                <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
	            </fieldset>
	        </form>
	    </div>
	
	    <div id="delete-user" title="회원 탈퇴" style="display:none" >
	        <pre>
	            회원 탈퇴를 하시겠습니까?
	            회원 탈퇴를 하시면 문제를 푼 기록이 다 사라집니다.
	            아래 비밀번호를 입력하세요.
	        </pre>
	        <form>
	            <fieldset>
	                <label for="name">비밀번호 입력 : </label>
	                <input type="text" name="delete" id="delete" value="" class="text ui-widget-content ui-corner-all">
	
	                <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
	            </fieldset>
	        </form>
	    </div>
	    
	    <div id="privacy" title="공개 비공개 설정" style="display:none" >
	        <pre>
	            공개 범위를 변경하시겠어요?
	        </pre>
	    </div>

</body>

</html>