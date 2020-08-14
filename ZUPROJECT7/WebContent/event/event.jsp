<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="event.EventBean" %>
<%@page import="event.EventDAO" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOOKPAGE | 이벤트 </title>
<link rel="stylesheet" href="../css/board2.css"/>
</head>
<%
	EventDAO eventDAO = new EventDAO();

	int count = eventDAO.getBoardCount();
	int pageSize = 10;
		
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize;
	
	List<EventBean> list = null;
	
	if(count > 0){
		list = eventDAO.getBoardList(startRow,pageSize);
		/* System.out.println(list.size());   */ 
	}	
%> 



<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->



<!-- 게시판 -->

<article>
<h1> 이벤트 페이지 </h1>
<table id="event">
  <tr>
	<th class="tno">No</th>
    <th class="ttitle" width="400">이벤트 </th>
    <th class="twrite">작성자 </th>
    <th class="tdate">작성일 </th>
    <th class="tread">조회수 </th>
  </tr>
<%
//글조회 
if(count > 0){
	for(int i=0; i<list.size(); i++){
		EventBean bean = list.get(i);
%>


	<tr>
		<td><%=bean.getNum()%></td>
		<td id="subject" onclick="location.href='eventContent.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'"><%=bean.getSubject()%></td>
		<td><%=bean.getId()%></td> 
		<td><%=new SimpleDateFormat("yyyy.MM.dd").format(bean.getDate())%></td>
		<td><%=bean.getReadcount()%></td>
	</tr>
	
<%		
	}
}else{//게시판에 글이 저장되어 있지 않다면
	
%>
	<tr>
		<td colspan="5">게시판에 글이 존재하지 않습니다.</td>
	</tr>
	
<%	
}
%>

</table>

<br>
<br>
<br>



<div id="table_search">
	<input type="text" name="search" class="input_box">
	<input type="button" value="검색" class="btn">
<%

String id = (String)session.getAttribute("id");

//session영역에 값이 저장되어 있으면  글쓰기 버튼 보이게 설정
if(id != null){
%>	


<input type="button" value="글쓰기" class="btn" onclick="location.href='eventWrite.jsp'"/>

</div>
<%}%>
<br>
<br>



<div class="clear"></div>
<div id="page_control">
<%
			if(count > 0){
				int pageCount = count/pageSize + (count%pageSize ==0 ? 0 : 1);
				
				//한 화면에 표시될 페이지수 설정
				int pageBlock = 5;
				
				int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock == 0 ? 1 : 0 )) * pageBlock + 1;
				
				int endPage = startPage + pageBlock - 1;
				
				if(endPage > pageCount){
					endPage = pageCount;
				}
				if(startPage > pageBlock){
			%>
					<a href="event.jsp?pageNum=<%=startPage - pageBlock %>">Prev</a>		
			<%						
				}
				for(int i=startPage;i<=endPage;i++){
			%>
					<a href="event.jsp?pageNum=<%=i%>">[<%=i%>]</a>
			<%		
				}
				if(endPage<pageCount){
					%>
					<a href="event.jsp?pageNum=<%=startPage+pageBlock%>">Next</a>
					<%
				}				
			}		
%>		
</div>
</article>

<!-- 게시판 -->
<div class="clear"></div>
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





