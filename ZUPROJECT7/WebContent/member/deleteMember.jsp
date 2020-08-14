<%@page import="member.MemberDAO"%>
<%@page import="board.BoardDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKPAGE | 회원탈퇴 </title>
<link rel="stylesheet" href="../css/read.css"/>
</head>
<%
	String id = (String)session.getAttribute("id");
	
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
%>	
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 게시판 -->
	<article>
		<h1>회원 탈퇴</h1>
		
		<form action="deleteMemberPro.jsp" method="post">
			<table id="markd">
				<tr>
					<td>비밀번호 </td>
					<td><input type="password" name="passwd"></td>
				</tr>
			</table>
		
			<input type="submit" value="회원탈퇴" class="btn" onclick="return confirm('정말로 탈퇴하시겠습니까?')"> 
			<input type="button" value="취소" class="btn" onclick="location='../index.jsp'">
		</form>
		
		<div class="clear"></div>	
	</article>
<br>
<br>
<br>
<!-- 게시판 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>