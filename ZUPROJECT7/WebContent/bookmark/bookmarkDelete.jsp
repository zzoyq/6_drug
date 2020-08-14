<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKPAGE | 공유북마크삭제 </title>
<link rel="stylesheet" href="../css/read.css"/>
</head>
<%
	String id = (String)session.getAttribute("id");
	
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>	
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 게시판 -->
	<article>
		<h1>북마크 삭제 </h1>
		<form action="bookmarkDeletePro.jsp?pageNum=<%=pageNum%>" method="post">
			<input type="hidden" name="num" value="<%=num%>">
			<table id="markd">
				<tr>
					<td>비밀번호 </td>
					<td><input type="password" name="passwd"></td>
				</tr>
			</table>
			<br>
			<br>
			<div id="table_search">
				<input type="submit" value="삭제 " class="btn">
				<input type="reset" value="다시입력 " class="btn">
				<input type="button" 
					   value="목록 " 
					   class="btn"
					   onclick="location.href='bookmark.jsp?pageNum=<%=pageNum%>'">
			</div>			
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