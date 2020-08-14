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
<title>BOOKPAGE | 공유북마크 </title>
<link rel="stylesheet" href="../css/read.css"/>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	int num =Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	BookmarkDAO dao = new BookmarkDAO();
	
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
	

<!-- 게시판 -->
		<article>
			<h1>공유 북마크 </h1>
			<table id="bookmark" width="500">
				<tr>
					<td colspan="2" id="title2"><%=bBean.getSubject() %></td>
				</tr>
				<tr>
					<td>작성자&nbsp;&nbsp;<%=bBean.getId() %></td>
					<td>작성일&nbsp;&nbsp;<%=new SimpleDateFormat("yyyy.MM.dd").format(bBean.getDate()) %> </td>
				</tr>
				<tr>
					<td colspan="3" id="content">	
					<%
						if(bBean.getImage()!=null && bBean.getImage()!=""){
					%>				
							<img alt="" src="../image/<%=bBean.getImage()%>" style="width: 750px;height:900px;">
					<%
						}
					%>
					<br><br><%=DBContent %></td> 
				</tr>				
			</table>
			<br>
			<br>
			<br>
			<br>
			
			<%-- 수정/삭제  --%>
			<div id="table_search">
			<%
				String id = (String)session.getAttribute("id");
				
				if(id != null ){
					if(id.equals(bBean.getId())){
			%>			
			
				<input type="button" 
					   value="수정 " 
					   class="btn"				
					   onclick="location.href ='bookmarkUpdate.jsp?num=<%=bBean.getNum()%>&pageNum=<%=pageNum%>'">
						
				<input type="button" 
					   value="삭제 " 
					   class="btn"				
					   onclick="location.href ='bookmarkDelete.jsp?num=<%=bBean.getNum()%>&pageNum=<%=pageNum%>'">
			<%	
					} 	
				}			
			%>
			<input type="button" 
				   value="목록 " 
				   class="btn"				
				   onclick="location.href ='bookmark.jsp?pageNum=<%=pageNum%>'">
			</div>
			<div class="clear"></div>
		
		<%-- 댓글  --%>
			<br><br><br>
			<div id="comment">
			<%
			 if(count!=0){ 
				 List<CommentBean> list = cdao.getComment(num);
			%> 
				<table class="comment">
			<%
			for(int i =0 ; i<list.size() ; i++){
				CommentBean cBean = list.get(i);
					
					if(bBean.getNum()==cBean.getRe_ref()) {
			%>
						<tr>
							<td>
								<%=cBean.getId() %>
							</td> 
							<td>
								&nbsp;&nbsp;<%=cBean.getContent()%>&nbsp;&nbsp;
							</td>
								<td>
								<%=new SimpleDateFormat("yyyy.MM.dd").format(cBean.getDate()) %>
								</td>
							<td>
						<%
							// 게시판 글 작성자/ 댓글 작성자만 삭제 가능
							if (bBean.getId().equals(id)||cBean.getId().equals(id)) {
						%>		
						
							<%-- 	<input type="button" value="댓글 수정 " class="btn2"				
								onclick="location.href ='commentUpdate.jsp?commentNum=<%=cBean.getNum()%>&pageNum=<%=pageNum%>&num=<%=bBean.getNum()%>'">
						 --%>
									<input type="button" value="댓글 삭제" class="btn2"
									 onclick="location.href='commentDelete.jsp?commentNum=<%=cBean.getNum()%>&pageNum=<%=pageNum%>&num=<%=bBean.getNum()%>'">
						<%
							}
						%>
							</td>
						
						</tr>
					
			<%		}
				}
			%>
				</table>
			<% 
				} 
			%>		
			
			
<%

			if (id != null) {
%>
			<form action="comment.jsp" method="post">
				<input type="hidden" name="re_ref" value="<%=bBean.getNum()%>" > 
				<input type="hidden" name="page" value="<%=pageNum%>" > 
				<input type="hidden" name="id" value="<%=session.getAttribute("id")%>">
				
				<br><br>
				<table class="comment">
					<tr>
						<td>댓글</td>
						<td colspan="2">
							<textarea name="content" rows="5%" cols="50%" placeholder="댓글 작성시 타인에게 불쾌감을 줄 수 있는 문구를 사용하시면 삭제 될 수 있습니다. "></textarea>
								<input type="submit" name="commnetsubmit" class="btn2" value="댓글쓰기"> 
						</td>
					</tr>
				</table>
			</form>
			<%
				}
			%>
			
			</div> 
		</article>
		
		

<br>
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