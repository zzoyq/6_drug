<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOK PAGE</title>
<link rel="stylesheet" href="css/book.css"/>
<link rel="stylesheet" href="css/index.css"/>
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>


<link rel="stylesheet" href="css/bootstrap.min.css">
	

</head>
<body>

<div id="wrap">
<!-- 헤더시작 -->
	<%@include file="inc/header.jsp"%>

<br>
<br>
<!-- 헤더 끝 -->

<!-- ad 자동 슬라이드 배너시작 -->

<div class="container">
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1" ></li>
			<li data-target="#myCarousel" data-slide-to="2" ></li>
			<li data-target="#myCarousel" data-slide-to="3" ></li>
			<li data-target="#myCarousel" data-slide-to="4" ></li>
			<li data-target="#myCarousel" data-slide-to="5" ></li>
		</ol>
		<div class="carousel-inner">
			<div class="item active">
				<img src="images/main_01.gif">
			</div>
			<div class="item">
				<img src="images/main_02.gif">
			</div>
			<div class="item">
				<img src="images/main_03.gif">
			</div>
			<div class="item">
				<img src="images/main_04.gif">
			</div>
			<div class="item">
				<img src="images/main_05.gif">
			</div>
			<div class="item">
				<img src="images/main_06.gif">
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
</div>



<!-- ad 자동 슬라이드 배너끝 -->
<br>
<br>
<br>
<div class="clear"></div>

<!-- 추천도서 -->
	<table id="rec">
	<tr>
		<td colspan="4"><h2>오늘의, 선택</h2></td>
	</tr>
	<tr>
		<td><a href="#"><img src="images/c1.jpg" width="240" height="330"></a></td>
		<td><a href="#"><img src="images/c2.jpg" width="240" height="330"></a></td>
		<td><a href="#"><img src="images/c3.jpg" width="240" height="330"></a></td>
		<td><a href="#"><img src="images/c4.jpg" width="240" height="330"></a></td>
	</tr>
	<tr>
		<td bgcolor="#f7f7e0" id="inf"><br><a href="#">&nbsp;죽은 자의 집 청소 </a><br><br><br>
			<span class="author">&nbsp;&nbsp;김완 지음<br></span><br></td>
		<td bgcolor="#f7f7e0" id="inf"><br><a href="#">&nbsp;아빠라는 남자 </a><br><br><br>
			<span class="author">&nbsp;&nbsp;마스다 미리 지음<br></span><br></td>
		<td bgcolor="#f7f7e0" id="inf"><br><a href="#">&nbsp;일상을 심플하게</a><br><br><br>
			<span class="author">&nbsp;&nbsp;마스노 순묘 지음<br></span><br></td>
		<td bgcolor="#f7f7e0" id="inf"><br><a href="#">&nbsp;무례한 사람에게 웃으며 대체하는 법</a><br><br><br>
			<span class="author">&nbsp;&nbsp;정문정 지음<br></span><br></td>
	</tr>
	
	</table>
<!-- 추천도서 -->


<br>
<br>
<br>
<!-- 푸터시작 -->
	<%@include file="inc/footer.jsp"%>
<!--  푸터 끝 -->
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="bootstrap.js"></script>
</body>
</html>