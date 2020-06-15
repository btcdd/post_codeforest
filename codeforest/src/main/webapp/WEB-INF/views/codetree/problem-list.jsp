<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.servletContext.contextPath }/assets/css/codetree/problem-list.css">
<script>
$(function() {
	  var items = $(".accordion__items");

	  items.on("click",function(){
	    if($(this).hasClass("active")) {
	      $(this).removeClass("active");
	      $(this).next().removeClass("open");
	    } else {
	      $(this).siblings().removeClass("active");
	      $(this).next().siblings().removeClass("open");
	      $(this).toggleClass("active");
	      $(this).next().toggleClass("open");
	    }
	  });
	});
</script>


<div class="accordion">
  <h1 class="accordion__title">PROBLEM LIST</h1>
  <h2 class="accordion__items">SUB PROBLEM 01</h2>
  <div class="accordion__content">
    <h3 class="accordion__content__caption">문제 내용</h3>
    <p class="accordion__content__txt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas, repellat vel et neque at asperiores recusandae necessitatibus voluptatum magnam. Odio est, repellendus quas molestias laborum itaque perspiciatis perferendis consequuntur quidem. Non ullam velit eaque accusantium nam, voluptates earum ab, placeat quaerat commodi delectus vel, magni maxime itaque dicta consequatur quisquam maiores nisi.</p>
    <h3 class="accordion__content__caption">예제 입력</h3>
    <p class="accordion__content__txt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas, repellat vel et neque at asperiores recusandae necessitatibus voluptatum magnam. Odio est, repellendus quas molestias laborum itaque perspiciatis perferendis consequuntur quidem. Non ullam velit eaque accusantium nam, voluptates earum ab, placeat quaerat commodi delectus vel, magni maxime itaque dicta consequatur quisquam maiores nisi.</p>
    <h3 class="accordion__content__caption">예제 출력</h3>
    <p class="accordion__content__txt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas, repellat vel et neque at asperiores recusandae necessitatibus voluptatum magnam. Odio est, repellendus quas molestias laborum itaque perspiciatis perferendis consequuntur quidem. Non ullam velit eaque accusantium nam, voluptates earum ab, placeat quaerat commodi delectus vel, magni maxime itaque dicta consequatur quisquam maiores nisi.</p>
  </div>
  
  <h2 class="accordion__items">SUB PROBLEM 01</h2>
  <div class="accordion__content">
    <h3 class="accordion__content__caption">문제 내용</h3>
    <p class="accordion__content__txt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas, repellat vel et neque at asperiores recusandae necessitatibus voluptatum magnam. Odio est, repellendus quas molestias laborum itaque perspiciatis perferendis consequuntur quidem. Non ullam velit eaque accusantium nam, voluptates earum ab, placeat quaerat commodi delectus vel, magni maxime itaque dicta consequatur quisquam maiores nisi.</p>
    <h3 class="accordion__content__caption">예제 입력</h3>
    <p class="accordion__content__txt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas, repellat vel et neque at asperiores recusandae necessitatibus voluptatum magnam. Odio est, repellendus quas molestias laborum itaque perspiciatis perferendis consequuntur quidem. Non ullam velit eaque accusantium nam, voluptates earum ab, placeat quaerat commodi delectus vel, magni maxime itaque dicta consequatur quisquam maiores nisi.</p>
    <h3 class="accordion__content__caption">예제 출력</h3>
    <p class="accordion__content__txt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas, repellat vel et neque at asperiores recusandae necessitatibus voluptatum magnam. Odio est, repellendus quas molestias laborum itaque perspiciatis perferendis consequuntur quidem. Non ullam velit eaque accusantium nam, voluptates earum ab, placeat quaerat commodi delectus vel, magni maxime itaque dicta consequatur quisquam maiores nisi.</p>
  </div>

</div>
