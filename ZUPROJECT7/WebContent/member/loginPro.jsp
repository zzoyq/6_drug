<%@page import="member.MemberDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");	
	MemberDAO memberdao = new MemberDAO();
	

	int check = memberdao.userCheck(id, passwd);

	if(check == 1){
		session.setAttribute("id", id);
	
		response.sendRedirect("../index.jsp");
		
	}else if(check == 0){
%>

	<script type="text/javascript">
		alert("비밀번호가 일치하지 않습니다.");
		history.back();
	</script>

<%
	}else{ 
%>		
	<script type="text/javascript">
		alert("아이디가 존재하지 않습니다.");
		history.back();
	</script>
		
		
<%		
	}
%>