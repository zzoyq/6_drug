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
<title>BOOKPAGE | 문의사항수정</title>
<link rel="stylesheet" href="../css/write.css"/>

</head>
<%
// 글 수정을 위한 글상세보기 화면

		String id = (String)session.getAttribute("id");
		
		if(id == null){
			response.sendRedirect("../member/login.jsp");	
		}
		
		request.setCharacterEncoding("UTF-8");
		int num = Integer.parseInt(request.getParameter("num")); //수정할 글번호
		String pageNum = request.getParameter("pageNum"); //수정할 페이지번호 
		
		BoardDAO dao  = new BoardDAO();
		BoardBean boardBean = dao.getBoard(num);
		
		int DBnum = boardBean.getNum();//글번호
		String DBSubject = boardBean.getSubject();//글제목
		String DBContent = ""; //글내용을 저장할 변수
		
		if(boardBean.getContent() != null){//검색한 글내용이 있음떄
			DBContent = boardBean.getContent().replace("\r\n","<br>");
		}
	
%> 
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->


<!-- 게시판 -->
		<article>
			<h1>문의사항 수정</h1>
			<form action="updatePro.jsp?pageNum=<%=pageNum%>" method="post">
				<%--수정할 글번호 전달 --%>
				<input type="hidden" name="num" value="<%=num%>">
				<table id="question">
					<tr>
						<td> &nbsp; 아이디&nbsp;<sup>*</sup><br>
						<input type="text" name="id" value="<%=id%>" readonly></td> 
					</tr>
					<tr>
						<td> &nbsp;비밀번호&nbsp;<sup>*</sup><br>
						<input type="password" name="passwd" required="required"></td>
					</tr>
					<tr>
						<td> &nbsp;제목&nbsp;<sup>*</sup><br>
						<input type="text" name="subject" value="<%=DBSubject %>" required="required"></td>
					</tr>
					<tr>
						<td>&nbsp; 글내용&nbsp;<sup>*</sup><br>
							<textarea name="content" rows="13" cols="40" required="required"><%=DBContent %></textarea>
						</td>
					</tr>
				</table>
				<div id="table_search">
					<input type="submit" value="수정" class="btn">
					<input type="reset" value="다시작성" class="btn">
					<input type="button" value="목록" class="btn" onclick="location.href='question.jsp'">
				</div>
			</form>		
		<div class="clear"></div>
	</article>
<!-- 게시판 -->
<div class="clear"></div>
<br>
<br>
<br>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>





