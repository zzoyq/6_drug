<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKPAGE | 회원정보수정</title>
<link rel="stylesheet" href="../css/info.css"/>
<script type="text/javascript">
	//회원정보수정 체크
function infoUpdateCheck(){
		
		
		if(document.infoUpdate.passwd.value == ""){
			alert("비밀번호를 입력하세요");
			infoUpdate.passwd.focus();
			return false;
		}
		
		
		
		if(document.infoUpdate.phone.value == ""){
			alert("전화번호를 입력하세요");
			infoUpdate.phone.focus();
			return false;
		}
		
		if(document.infoUpdate.email.value == ""){
			alert("이메일을 입력하세요");
			infoUpdate.email.focus();
			return false;
		}
		
		if(document.infoUpdate.address.value == ""){
			alert("주소를 입력하세요");
			infoUpdate.address.focus();
			return false;
		}
		
		if(document.infoUpdate.address2.value == ""){
			alert("상세주소를 입력하세요");
			infoUpdate.address2.focus();
			return false;
		}
	}//회원정보수정 체크 

</script>

</head>

<%
	String id = (String)session.getAttribute("id");
	
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
<h1>회원 정보 수정</h1><br>
<table id="myinfo">
	<form action="infoUpdatePro.jsp" name="infoUpdate" method="post">
		<tr>
			<td id="info">이름&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;<input type="text" value=<%=mBean.getName() %> id="name" name="name" readonly="readonly"></td>
		</tr>
		<tr>
			<td id="info">아이디&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;<input type="text" value=<%=mBean.getId() %> id="id" name="id" readonly="readonly"></td>
		</tr>
		<tr>
			<td id="info">비밀번호&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;<input type="text" value=<%=mBean.getPasswd() %> id="passwd" name="passwd" size="20" required="required"></td>
		</tr>
		<tr>
			<td id="info">출생년도&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;<input type="text" value=<%=mBean.getAge() %> id="age" name="age" readonly="readonly"></td>
		</tr>
		<tr>
			<td id="info">전화번호&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;<input type="text" value=<%=mBean.getPhone() %> id="phone" name="phone" size="20" required="required"></td>
		</tr>
		<tr>
			<td id="info">이메일&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;<input type="text" value=<%=mBean.getEmail() %> id="email" name="email" size="20" required="required"></td>
		</tr>	
		<tr>
			<td id="info">주소&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;<input type="text" value=<%=mBean.getAddress() %> id="address" name="address" size="20" required="required"><br>
			&nbsp;&nbsp;<input type="text" value=<%=mBean.getAddress2() %> id="address2" name="address2" size="20" required="required">
			</td>
		</tr>
</table>
	 <input type="submit" value="회원정보수정" class="btn">
	 <input type="button" class="btn" value="회원탈퇴" onclick="location.href='${pageContext.request.contextPath}/member/deleteMember.jsp'">
	 <input type="button" class="btn" value="메인 페이지" onclick="location.href='${pageContext.request.contextPath}/index.jsp'">
	
	</form>

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