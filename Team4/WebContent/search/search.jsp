<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>YAKBBAL</title>
<link href="../css/main.css" rel="stylesheet" type="text/css">
<link href="../css/header.css" rel="stylesheet" type="text/css">
<link href="../css/footer.css" rel="stylesheet" type="text/css">
<link href="../css/search.css" rel="stylesheet" type="text/css">

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$('ul.tabs li').click(function(){
			var tab_id = $(this).attr('data-tab');
	
			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
	
			$(this).addClass('current');
			$("#"+tab_id).addClass('current');
		})
	})

</script>
</head>
<body>
<!-- header 시작  -->
<%@include file="../inc/header.jsp" %>
<!-- header 끝 -->
<!-- 본문내용 -->
<article>
<h3 align="center">약이름 : 0000000 <br><button>즐겨찾기</button></h3>

<br><br>
 
 <div class="container">

	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">기본</li>
		<li class="tab-link" data-tab="tab-2">효능</li>
		<li class="tab-link" data-tab="tab-3">용법</li>
		<li class="tab-link" data-tab="tab-4">주의</li>
	</ul>

	<div id="tab-1" class="tab-content current">
	여기 안에다 기본 내용 넣어주세요 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	</div>

	<div id="tab-2" class="tab-content">
	효능적어주세요---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	</div>
	<div id="tab-3" class="tab-content">
	용법은요오?
	</div>
	<div id="tab-4" class="tab-content">
	주의할 점은요?
	</div>
	
</div>
</article>
<!-- 본문내용 -->
<!-- footer 시작 -->
<%@include file="../inc/footer.jsp" %>
<!-- footer 끝 -->
</body>
</html>