<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String filename = request.getParameter("filename");
	String origfilename = request.getParameter("origfilename");
	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>파일다운로드 </title>
</head>
<body>

올린 사람 : <%=id %>
제목  : <%=subject %>
비밀번호 : <%=passwd %>
파일명  : <a href="download.jsp?file_name=<%=filename %>"><%=origfilename %></a><br>

</body>
</html>