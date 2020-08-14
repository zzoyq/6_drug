<%@page import="member.MemberDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    request.setCharacterEncoding("UTF-8");
    %>

	<jsp:useBean id="memberBean" class="member.MemberBean"/>
	<jsp:setProperty property="*" name="memberBean"/>
<%
	
	MemberDAO memberdao = new MemberDAO();
	

	int check = memberdao.infoUpdate(memberBean); 

	if(check == 1){//회원정보수정성공
%>
		<script>
			alert("회원정보가 수정되었습니다.");
			location.href="${pageContext.request.contextPath}/member/infoUpdateCom.jsp";
		</script>
<%
	}else{//회원정보수정실패
%>
		<script>
			alert("다시 시도해주세요.");
			history.back();
		</script>
<%
	}
%>