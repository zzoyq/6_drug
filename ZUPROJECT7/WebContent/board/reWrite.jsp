<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%> 
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOOKPAGE | 문의사항답글 </title>
<link rel="stylesheet" href="../css/write.css"/>

</head>
<%

String id = (String)session.getAttribute("id");

if(id == null){
	response.sendRedirect("../member/login.jsp");	
}

//content.jsp에서 답변쓰기 버튼을 클릭해서 전달 하여 넘어온 데이터 얻기
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num")); //답변글 작성시 부모글번호 전달받기
int re_ref = Integer.parseInt(request.getParameter("re_ref"));
int re_lev = Integer.parseInt(request.getParameter("re_lev"));
int re_seq = Integer.parseInt(request.getParameter("re_seq"));
	
%> 
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->


<!-- 게시판 -->
<article>
	<h1>답글 작성 페이지</h1>
		<form action="reWritePro.jsp" method="post">
			<%--입력한 답글 추가 요청시 부모글 번호를 전달함. --%>
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="re_ref" value="<%=re_ref%>">
			<input type="hidden" name="re_lev" value="<%=re_lev%>" >
			<input type="hidden" name="re_seq" value="<%=re_seq%>">
			<table id="question">
					<tr>
						<td> &nbsp; 작성자&nbsp;<sup>*</sup><br>
						<input type="text" name="id" value="<%=id%>" readonly></td> 
					</tr>
					<tr>
						<td> &nbsp;비밀번호&nbsp;<sup>*</sup><br>
						<input type="password" name="passwd" required="required"></td>
					</tr>
					<tr>
						<td> &nbsp;답글 제목&nbsp;<sup>*</sup><br>
						<input type="text" name="subject" value="[답글]" required="required"> </td>
					</tr>	
					<tr>
						<td>&nbsp; 답글 내용&nbsp;<sup>*</sup><br>
						<textarea name="content" rows="13" cols="40"></textarea> </td>
					</tr>	
			</table>
			<div id="table_search">
				<input type="submit" value="답글작성" class="btn">
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="목록" 
				       class="btn" onclick="location.href='question.jsp'">
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





