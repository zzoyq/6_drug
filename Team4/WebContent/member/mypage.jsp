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
</head>
<body>
<!-- header 시작  -->
<%@include file="../inc/header.jsp" %>
<!-- header 끝 -->

<!-- 본문내용 -->
<article>

	<h1>마이페이지</h1>
	<br>
	<span></span><br><br> </span>

		
		<fieldset> 
			<span><기본정보></span><br><br>
			<label for="name">이름</label><br>
			<input type="text" id="name" name="name" value="">
			<br>
			<label for="id">아이디</label><br>
			<input type="text" id="id" name="id" value="">
			<br>
			<label for="pw">비밀번호</label><br>
			<input type="password" id="pw" name="pw" placeholder="비밀번호 확인">
			<br>
			<label for="birth">생년월일</label><br>
			<input type="text" id="birth" name="birth" value="">
			<br>
			<label for="phone">휴대폰번호</label><br>
			<input type="text" id="phone" name="phone" value="">
			<br>
			<label for="phone">이메일</label><br>
			<input type="text" id="email" name="email"  value="">
			<br><br>
			<span><추가 정보></span><br><br>
			<label for="eat">복용중인 약</label><br>
			<textarea id="eat" name="eat" cols="19" rows="5">내용</textarea> 
			<br>
			<label for="hate">부작용있는 약</label><br>
			<textarea id="hate" name="hate" cols="19" rows="5">내용</textarea> 
			<br>
			<label for="hospital">통원 병원 정보</label><br>
			<textarea id="hospital" name="hospital" cols="19" rows="5">내용</textarea> 
			<br>
		</fieldset><br>

		<div id="buttons">
			<input type="button" value="정보수정" class="" onclick="location.href=''">
			<input type="button" value="회원탈퇴" class="" onclick="location.href=''">
		</div>

	
</article>
<!-- 본문내용 -->
<!-- footer 시작 -->
<%@include file="../inc/footer.jsp" %>
<!-- footer 끝 -->
</body>
</html>