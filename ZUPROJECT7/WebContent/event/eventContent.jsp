<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="event.EventBean" %>
<%@page import="event.EventDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKPAGE | 이벤트 </title>
<link rel="stylesheet" href="../css/read.css"/>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	int num =Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	EventDAO dao = new EventDAO();
	
	dao.updateReadCount(num);
	
	//DB로부터 하나의 글 정보를 검색해서 얻기
	String DBContent ="";
	EventBean eBean = dao.getBoard(num);
		
	if(eBean.getContent() != null){
		DBContent = eBean.getContent().replace("\r\n", "<br>");
	}
	
	int count = dao.getBoardCount();
%>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->
	

<!-- 게시판 -->
		<article>
			<h1> 이벤트 페이지  </h1>
			<table id="event">
				<tr>
					<td colspan="2" id="title2"><%=eBean.getSubject() %></td>
				</tr>
				<tr>
					<td>작성자&nbsp;&nbsp;<%=eBean.getId() %></td>
					<td>작성일&nbsp;&nbsp;<%=new SimpleDateFormat("yyyy.MM.dd").format(eBean.getDate()) %></td>
				</tr>
				<tr>
					<td colspan="2" id="content">	
					<%
						if(eBean.getImage()!=null && eBean.getImage()!=""){
					%>				
							<img alt="" src="../image/<%=eBean.getImage()%>" style="width: 750px;height:900pxs;">
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
					if(id.equals(eBean.getId())){
			%>			
			
				<input type="button" 
					   value="수정 " 
					   class="btn"				
					   onclick="location.href ='eventUpdate.jsp?num=<%=eBean.getNum()%>&pageNum=<%=pageNum%>'">
						
				<input type="button" 
					   value="삭제 " 
					   class="btn"				
					   onclick="location.href ='eventDelete.jsp?num=<%=eBean.getNum()%>&pageNum=<%=pageNum%>'">
			<%	
					} 	
				}			
			%>
			<input type="button" 
				   value="목록 " 
				   class="btn"				
				   onclick="location.href ='event.jsp?pageNum=<%=pageNum%>'">
			</div>
			<div class="clear"></div>
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