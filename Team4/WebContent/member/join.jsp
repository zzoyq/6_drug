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
<body>
<!-- header 시작  -->
<%@include file="../inc/header.jsp" %>
<!-- header 끝 -->

<!-- 본문내용 -->
<article>

	<h1>회원가입</h1>
	<br>
	<span></span><br><br> </span>
	
	<form onsubmit="return #()" action="#" method="post" id="join">
		<fieldset> 
			<span><필수 입력사항<sup>*</sup>></span><br><br>
			<label for="name">이름<sup>*</sup></label><br>
			<input type="text" id="name" name="name" placeholder="이름을 입력해 주세요">
			<br>
			<label for="id">아이디<sup>*</sup></label><br>
			<input type="text" id="id" name="id" placeholder="아이디를 입력해 주세요">
			<br>
			<label for="pw">비밀번호<sup>*</sup><span class="help"><br>영문/숫자/특수문자 혼합 (8자 이상 20자 이내)</span></label> <br>
			<input type="password" id="pw" name="pw" placeholder="비밀번호를 입력해 주세요">
			<br>
			<label for="pwCheck">비밀번호확인<sup>*</sup></label><br>
			<input type="password" id="pwCheck" name="pwCheck" placeholder="비밀번호를 다시 입력해 주세요">
			<br>
			<label for="birth">생년월일<sup>*</sup><span class="help"></span></label><br>
			<input type="text" id="birth" name="birth" placeholder="8자리 (19900101)">
			<br>
			<label for="phone">휴대폰번호<sup>*</sup><span class="help"></span></label><br>
			<input type="text" id="phone" name="phone" placeholder="' - ' 생략 (01012341234)">
			<br>
			<label for="phone">이메일<sup>*</sup></label><br>
			<input type="text" id="email" name="email" placeholder="이메일을 입력해 주세요">
			<br><br>
			<span><추가 입력사항></span><br><br>
			<label for="eat">복용중인 약</label><br>
			<input type="text" id="eat" name="eat" placeholder="복용중인 약 이름을 입력해 주세요">
			<br>
			<label for="hate">부작용있는 약</label><br>
			<input type="text" id="hate" name="hate" placeholder="부작용 있는 약이름을 입력해 주세요">
			<br>
			<label for="hospital">통원 병원 정보</label><br>
			<input type="text" id="hospital" name="hospital" placeholder="병원이름을 입력해 주세요">
			<br>
		</fieldset><br>

		<div id="buttons">
			<input type="submit" value="회원가입" class="submit">
			<input type="reset" value="다시입력" class="reset">
		</div>
	</form>
</article>
<!-- 본문내용 -->

<!-- footer 시작 -->
<%@include file="../inc/footer.jsp" %>
<!-- footer 끝 -->
</body>
</html>