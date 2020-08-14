<%@page import="java.util.List"%>
<%@page import="mark.CommentDAO"%>
<%@page import="mark.CommentBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="mark.BookmarkBean" %>
<%@page import="mark.BookmarkDAO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="css/front.css" rel="stylesheet" type="text/css">
</head>
<%
	request.setCharacterEncoding("UTF-8");

	//글목록 중 하나를 클릭했을 때.. 요청받아 넘어온 num,pageNum 얻기
	int num =Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	BookmarkDAO dao = new BookmarkDAO();
	
	//조회수를 1 증가시키는 메소드 호출
	dao.updateReadCount(num);
	
	//DB로부터 하나의 글 정보를 검색해서 얻기
	String DBContent ="";
	BookmarkBean bBean = dao.getBoard(num);
		
	if(bBean.getContent() != null){
		DBContent = bBean.getContent().replace("\r\n", "<br>");
	}
	
	CommentDAO cdao = new CommentDAO();
	//CommentBean cBean = new CommentBean();
	int count = dao.getBoardCount();
%>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->
	
		<article>
			<h1>공유 북마크 </h1>
			<table id="bookmark">
				<tr>
					<td>글번호 </td>
					<td><%=bBean.getNum()%></td>
					<td>Read Count</td>
					<td><%=bBean.getReadcount() %></td>
				</tr>
				<tr>
					<td>작성자 </td>
					<td><%=bBean.getId() %></td>
					<td>작성일 </td>
					<td><%=new SimpleDateFormat("yyyy.MM.dd").format(bBean.getDate()) %></td>
				</tr>
				<tr>
					<td>제목 </td>
					<td colspan="3"><%=bBean.getSubject() %></td>
				</tr>
				<tr>
					<td>내용 </td> 
					<td colspan="3" >	
					<%
						if(bBean.getImage()!=null && bBean.getImage()!=""){
					%>				
							<img alt="" src="../image/<%=bBean.getImage()%>" style="width: 360px;height:270pxs;">
					<%
						}
					%>
					<br><br><%=DBContent %></td> <br><br><br><br>
				</tr>				
			</table>
			
			
			<%-- 수정/삭제  --%>
			<div id="table_search">
			<%
				String id = (String)session.getAttribute("id");
				
				if(id != null ){
					if(id.equals(bBean.getId())){
			%>			
						<input type="button" value="수정 " class="btn"				
						onclick="location.href ='bookmarkUpdate.jsp?num=<%=bBean.getNum()%>&pageNum=<%=pageNum%>'">
						
						<input type="button" value="삭제 " class="btn"				
						onclick="location.href ='bookmarkDelete.jsp?num=<%=bBean.getNum()%>&pageNum=<%=pageNum%>'">
			<%	
					} 	
				}			
			%>
			<input type="button" value="목록 " class="btn"				
			onclick="location.href ='bookmark.jsp?pageNum=<%=pageNum%>'">
			</div>
			<div id="page_control"></div>			
		
		
		<%-- 댓글  --%>
		
			<div id="comment">
			<form action="comment.jsp" method="post">
				<input type="hidden" name="num" value="<%=bBean.getNum()%>" > 
				<input type="hidden" name="page" value="<%=pageNum%>" > 
				<input type="hidden" name="id" value="<%=session.getAttribute("id")%>">
			<table id = "comment">
				<tr>
					<td>번호</td>
					<td>아이디</td>
					<td>내용</td>
					<td>작성일</td>
				</tr>
<%		if(session.getAttribute("id")!=null)
{ 
%>
				<tr>
					<td>
						<textarea rows="2" cols="40" name="contents"></textarea>
					</td>
					<td colspan="2"><input type="submit" value="댓글쓰기"></td>
				</tr>
<%}
				List<CommentBean> list = cdao.getComment(num);
				for(int i =0 ; i<list.size() ; i++){
				CommentBean cbean = list.get(i);
			%>
			<tr>
				<td><%=cbean.getNum() %></td>
				<td><%=cbean.getId() %></td>
				<td><%=cbean.getContent() %></td> 
				<td><%=cbean.getDate() %></td>
			<%		
}
			%>
			</table>
			
			</form>		
			</div> 
		</article>
		
		
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>