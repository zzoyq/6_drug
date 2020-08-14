<%@page import="mark.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>댓글 삭제</title>
</head>
<body>
<%
	int commentNum = Integer.parseInt(request.getParameter("commentNum"));
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	CommentDAO cDao = new CommentDAO();
	
	int check = cDao.deleteComment(commentNum);
	if(check==1){
%>	
	<script type="text/javascript">
		alert("댓글이 삭제되었습니다.");
		location.href="bookmarkContent2.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
	</script>
<% 		
	}else{
%>
	<script type="text/javascript">
		alert("댓글이 삭제되지 않았습니다.");
		history.back();
	</script>
<%		
	}
%>

</body>
</html>