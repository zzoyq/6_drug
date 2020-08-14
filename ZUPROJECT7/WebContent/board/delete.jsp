<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOOKPAGE | 문의사항삭제</title>
<link rel="stylesheet" href="../css/read.css"/>
</head>
<%
	String id = (String)session.getAttribute("id");
	
	//세션영역에 값이 저장되어 있지 않으면  login.jsp로 다시 이동
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	//content.jsp(글상세보기화면)에서 전달한 삭제할 글번호, 삭제할 글이 속해있는 페이지 넘버 얻기
	String num1 = request.getParameter("num");
	int num = Integer.parseInt(num1); //삭제할 글번호 "1" -> 정수 1 로 변환해서 저장
	
	String pageNum = request.getParameter("pageNum");
	
%>

<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->


<!-- 게시판 -->
	<article>
		<h1>문의사항 삭제</h1>
		<form action="deletePro.jsp?pageNum=<%=pageNum%>" method="post">
			<input type="hidden" name="num" value="<%=num%>">
			<table id="questiond">
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
			</table>
			<br>
			<br>
			<div id="table_search">
				<input type="submit" value="삭제" class="btn">
				<input type="reset" value="다시입력" class="btn">
				<input type="button" 
					   value="목록" 
					   class="btn" 
					   onclick="location.href='question.jsp?pageNum=<%=pageNum%>'">			
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





