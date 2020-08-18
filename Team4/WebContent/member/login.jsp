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
	
	
<!-- login 시작  -->
<article>

	<h2>로그인</h2><br>
		<form action="#" id="join" method="post">

			<div class = "login_form">
				<input type="text" id="id" name="id" placeholder="아이디를 입력해 주세요"><br><br>
				<input type="password" id="pw" name="pw" placeholder="비밀번호를 입력해 주세요"><br><br>
			</div>
			
			<span>* 아이디 /비밀번호는 영문 대소문자를 구분합니다. </span><br><br>

			<div id="buttons">
				<input type="submit" value="로그인" class="submit">
				<input type="reset" value="다시입력" class="reset">
			</div>
		</form>
		<br><br>
			<div class="help">
				<a href=#>아이디 찾기</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
				<a href=#>비밀번호 찾기</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
				<a href=#>회원가입</a>
			</div>
</article>

	
<!-- footer 시작 -->
<%@include file="../inc/footer.jsp" %>
<!-- footer 끝 -->
</body>
</html>