<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.Date"%>
<%@page import="mark.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>댓글</title>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("re_ref");
	String pageNum = request.getParameter("page");

%>
	<jsp:useBean id="cBean" class="mark.CommentBean" />
	<jsp:setProperty property="*" name="cBean" />
<%

	//content에서 내가 날짜를 보낼 것이 아니기 때문에
	//받아오는 곳에서 현재시간을 송출하기로 한다.
    cBean.setDate(new Timestamp(System.currentTimeMillis()));
	
	CommentDAO cdao = new CommentDAO();
	cdao.insertComment(cBean);
	
%>
	<script type="text/javascript">
		alert("댓글이 작성되었습니다.");
		location.href="bookmarkContent2.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
	</script>


</body>
</html>