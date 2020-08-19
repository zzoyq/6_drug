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

<style>
div {display:inline-block;}
</style>

</head>
<body>
<!-- header 시작  -->
<%@include file="../inc/header.jsp" %>
<!-- header 끝 -->
<!-- 본문내용 -->
<article>

	<div class="search">
	     <input type="text" placeholder="약 이름을 입력해주세요">
	</div>
	<div class="button">
	     <button type="button" onclick="location.href='search.jsp'">검색</button>
	</div>

</article>
<!-- 본문내용 -->
<!-- footer 시작 -->
<%@include file="../inc/footer.jsp" %>
<!-- footer 끝 -->
</body>
</html>