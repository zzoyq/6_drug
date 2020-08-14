<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKPAGE | 북마크작성</title>
<link rel="stylesheet" href="../css/write.css"/>
</head>
<%
	String id = (String)session.getAttribute("id");
	
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	pageContext.setAttribute("br", "<br>");
	
%>

<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->
	
			
<!-- 게시판 -->
<article>
	<h1>공유 북마크 페이지 </h1>
	<form action="bookmarkWritePro.jsp" method="post" enctype="multipart/form-data">
		<table id="bookmark">
			<tr>
				<td> &nbsp;아이디&nbsp;<sup>*</sup><br>
				<input type="text" name="id" value="<%=id%>" readonly></td> 
			</tr>
			<tr>
				<td> &nbsp;비밀번호&nbsp;<sup>*</sup><br>
				<input type="password" name="passwd" required="required"></td>				</tr>
			<tr>
				<td> &nbsp;제목&nbsp;<sup>*</sup><br>
				<input type="text" name="subject" required="required"> </td>
			</tr>	
			<tr>
				<td>&nbsp; 글내용&nbsp;<sup>*</sup><br>
				<textarea name="content" rows="13" cols="40"></textarea> </td>
			</tr>	
		</table>
			<tr>
				<td>이미지 첨부&nbsp; &nbsp;
				<input type="file" name="image"></td>
			</tr>		
			<br>
		<div id="table_search">
			<input type="submit" value="글쓰기 " class="btn">
			<input type="reset" value="다시작성 " class="btn">
			<input type="button" value="목록 " class="btn"
						   onclick="location.href = 'bookmark.jsp'">
		</div>			
	</form>
	<br>
	<div class="clear"></div>		
</article>
<!-- 게시판 -->
<div class="clear"></div>
<br>
<br>
<br>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>