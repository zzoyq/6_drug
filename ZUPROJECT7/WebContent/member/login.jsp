<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKPAGE | 로그인 </title>
<link rel="stylesheet" href="../css/member.css"/>
</head>
<body>
<!-- 메인페이지로 가는 로고와 링크 -->
	<div class="loginp">
		<div id="logo">
			<img alt="BOOKPAGE" src="../images/mainlogo.png" width="160" height="100" onclick="location.href='../index.jsp'">
		</div>
<!-- 본문시작 -->
	
	<%-- loginPro.jsp서버페이지로 로그인 요청--%>
			<form action="loginPro.jsp" id="login" method="post"> 
				<div class="loginbox">
					<input type="text" name="id" placeholder="아이디" required autofocus/></br>	
				</div>
				<div class="loginbox">
					<input type="password" name="passwd" placeholder="비밀번호" required/></br>
				</div>
					<button type="submit" class="submit" id="submit" >로그인</button><br>
				<div class="joinbox" id="joinbox">
					<button type="button" class="loginjoin" id="loginjoin" onclick="location.href='join.jsp'">회원가입</button>
				</div>
			</form>
				
<!-- 본문끝 -->
	</div>

</body>
</html>