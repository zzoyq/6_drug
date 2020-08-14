<%@page import="file.FileBean" %>
<%@page import="file.FileDAO" %> 

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKPAGE | 공지사항수정</title>
<link rel="stylesheet" href="../css/write.css"/>
</head>
<%
			String id = (String)session.getAttribute("id");	
		
			if(id==null){
				response.sendRedirect("../member/login.jsp");
			}		
			
			int num = Integer.parseInt(request.getParameter("num"));
			String pageNum = request.getParameter("pageNum");
						
			FileDAO dao = new FileDAO();
			//DB로부터 하나의 글정보를 검색해서 가져오기
			FileBean fBean = dao.getBoard(num);
			String DBSubject= fBean.getSubject(); //글제목
			String DBContent =""; //검색한 글 내용을 저장할 용도의 변수
			
			// 검색한 글의 내용이 있다면 내용들 엔터키 처리
			if(fBean.getContent() != null){
				DBContent = fBean.getContent().replace("<br>", "\r\n");
			}
			
		%>

<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->
		

<!-- 게시판 -->
		<article>
			<h1>공지사항 수정 </h1>
			<form action=noticeUpdatePro.jsp?pageNum=<%=pageNum %> method="post" name="fr" enctype="multipart/form-data">
				<input type="hidden" name="num" value="<%=num%>">
				<table id="notice">
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
					<tr>
						<td>파일&nbsp; &nbsp; 
						<input type="file" name="file" ></td>
					</tr>
					<br>
				<div id="table_search">
					<input type="submit" value="수정 " class="btn">
					<input type="reset" value="다시작성 " class="btn"
						onclick="reset1()">
					<input type="button" value="목록 " class="btn"
						onclick="location.href = 'notice.jsp?pageNum=<%=pageNum%>'">
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