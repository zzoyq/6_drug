<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOOKPAGE | CONTACT US</title>
<link rel="stylesheet" href="../css/contact.css"/>
</head>
<body>
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->
<%
		String id = (String) session.getAttribute("id");
		if (id == null) {
	%>
	<script type="text/javascript">
		alert('로그인 후 이용가능합니다');
		location.href = "${pageContext.request.contextPath}/member/login.jsp";
	</script>
	<%
		}
	
	%>
<br>
<br>
<br>
<br>
<br>
<br>
<article>
	<h1>CONTACT BOOKPAGE</h1>
		<form action="contactPro.jsp" method="post">
			<table id="contact">
				<tr>
					<td> &nbsp; 아이디&nbsp;<sup>*</sup><br>
					<input type="text" name="name" value="<%=id%>" readonly></td> 
				</tr>
				<tr>
					<td> &nbsp; 제목&nbsp;<sup>*</sup><br>
					<input type="text" name="title" required="required"> </td>
				</tr>
				<tr>
					<td> &nbsp; 메일주소&nbsp;<sup>*</sup><br>
					 <input type="email" name="email" required="required"></td>
				</tr>
				<tr>
					<td> &nbsp; 내용&nbsp;<sup>*</sup></td>
				</tr>
				<tr>
					<td colspan="3" rowspan="3"><textarea rows="10%" cols="80%"  name="contents" required="required"></textarea></td>
				</tr>
				<input type="hidden" name="to" value="poettzu@gmail.com">
				<input type="hidden" name="from" value="wifitou03@gmail.com"/>
			</table>
			<div id="cbtn">
				<input type="submit" value="전송" class="cbtn">
			</div>
		</form>
</article>
<br>
<br>
<br>
<br>
<br>
<br>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</body>
</html>



