<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKPAGE | 회원정보</title>
<link rel="stylesheet" href="../css/info.css"/>
</head>
<%
	String id = (String)session.getAttribute("id");
	
	//세션영역에 값이 저장되어 있지 않으면  login.jsp로 다시 이동
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	MemberDAO dao = new MemberDAO();
	MemberBean mBean = dao.getData(id);
	
%>

<body>

<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->
<br>
<br>
<br>
<br>

<article>
<h1>회원정보</h1>
<table id="myinfo">
	<tr>
		<td id="info">이름&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;<%=mBean.getName() %></td>
	</tr>
	<tr>
		<td id="info">아이디&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;<%=mBean.getId() %></td>
	</tr>
	<tr>
		<td id="info">비밀번호&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;<%=mBean.getPasswd() %></td>
	</tr>
	<tr>
		<td id="info">나이&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;<%=mBean.getAge() %>년생</td>
	</tr>
	<tr>
		<td id="info">전화번호&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;<%=mBean.getPhone() %></td>
	</tr>
	<tr>
		<td id="info">이메일&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;<%=mBean.getEmail() %></td>
	</tr>
	<tr>
		<td id="info">주소&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;<%=mBean.getAddress() %><br>
			&nbsp;&nbsp;<%=mBean.getAddress2() %>
		</td>
	</tr>
	
</table>


	<input type="button" class="btn" value="정보수정" onclick="location.href='${pageContext.request.contextPath}/member/infoUpdate.jsp'">&nbsp;&nbsp;
	<input type="button" class="btn" value="메인 페이지" onclick="location.href='${pageContext.request.contextPath}/index.jsp'">
</article>

<br>
<br>
<br>
<br>
<br>
<br>


<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>

</body>
</html>