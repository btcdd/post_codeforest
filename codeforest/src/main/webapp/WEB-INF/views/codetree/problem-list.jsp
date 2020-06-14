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
  <h1 class="accordion__title">ACCORDION</h1>
  <h2 class="accordion__items">Title 01</h2>
  <div class="accordion__content">
    <h3 class="accordion__content__caption">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</h3>
    <p class="accordion__content__txt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas, repellat vel et neque at asperiores recusandae necessitatibus voluptatum magnam. Odio est, repellendus quas molestias laborum itaque perspiciatis perferendis consequuntur quidem. Non ullam velit eaque accusantium nam, voluptates earum ab, placeat quaerat commodi delectus vel, magni maxime itaque dicta consequatur quisquam maiores nisi.</p>
  </div>
  <h2 class="accordion__items">Title 02</h2>
  <div class="accordion__content">
    <h3 class="accordion__content__caption">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</h3>
    <p class="accordion__content__txt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas, repellat vel et neque at asperiores recusandae necessitatibus voluptatum magnam. Odio est, repellendus quas molestias laborum itaque perspiciatis perferendis consequuntur quidem. Non ullam velit eaque accusantium nam, voluptates earum ab, placeat quaerat commodi delectus vel, magni maxime itaque dicta consequatur quisquam maiores nisi.</p>
  </div>
  <h2 class="accordion__items">Title 03</h2>
  <div class="accordion__content">
    <h3 class="accordion__content__caption">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</h3>
    <p class="accordion__content__txt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. In autem sapiente maxime dignissimos voluptatum maiores, id quae temporibus cumque amet omnis, quidem distinctio, consequatur nostrum explicabo corrupti sit. Corrupti, qui?  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloribus perspiciatis, nemo soluta voluptas quisquam, fugiat. Assumenda similique nam, totam voluptate, sed perferendis vero ea a cumque magnam quas. Illum, facere.</p>
  </div>
  <h2 class="accordion__items">Title 04</h2>
  <div class="accordion__content">
    <h3 class="accordion__content__caption">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</h3>
    <p class="accordion__content__txt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reprehenderit nam obcaecati deleniti suscipit libero mollitia ullam eaque debitis velit ipsam molestias atque maiores placeat perspiciatis quo earum fugit incidunt, quaerat.  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Suscipit repudiandae cumque placeat nemo asperiores vitae et saepe veritatis! Ea neque quas assumenda laudantium dolorem suscipit repellendus obcaecati, rem odit nihil.</p>
  </div>
  <h2 class="accordion__items">Title 05</h2>
  <div class="accordion__content">
    <h3 class="accordion__content__caption">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</h3>
    <p class="accordion__content__txt">
       Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vitae dolorum veritatis voluptatibus provident a nihil doloribus nisi quas, exercitationem dicta rem incidunt repudiandae dolorem quam. Fuga omnis, ea quaerat. Odit. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Possimus nesciunt ad quod quo, debitis deleniti cumque. Autem unde, aperiam nisi odit nihil quos nostrum eaque? Necessitatibus saepe neque delectus delenit.</p>
  </div>
</div>
