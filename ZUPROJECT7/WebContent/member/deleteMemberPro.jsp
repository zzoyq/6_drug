<%@page import="member.MemberDAO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = (String)session.getAttribute("id");
	String passwd = request.getParameter("passwd");
	MemberDAO dao = new MemberDAO();
	
	int check = dao.deleteMember(id,passwd); 
	if(check==1){
		session.invalidate(); //모든 세션정보 삭제
%>	
	<script type="text/javascript">
		alert("회원탈퇴가 되었습니다.");
		location.href="../index.jsp";
	</script>
<% 		
	}else{
%>
	<script type="text/javascript">
		alert("비밀번호를 다시 입력바랍니다.");
		history.back();
	</script>
<%		
	}
%>
