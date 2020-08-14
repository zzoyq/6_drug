<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="file.FileBean" %>
<%@page import="file.FileDAO" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOOKPAGE | 공지사항 </title>
<link rel="stylesheet" href="../css/board2.css"/>
</head>
<%
	FileDAO fileDAO = new FileDAO();

	int count = fileDAO.getBoardCount();
	int pageSize = 10;
		
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize;
	
	List<FileBean> list = null;
	
	if(count > 0){
		list = fileDAO.getBoardList(startRow,pageSize);
		/* System.out.println(list.size());    */
	}	
%> 



<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->



<!-- 게시판 -->

<article>
<h1>공지사항</h1>
<table id="notice">
	<tr>
		<th class="tno">No</th>
		<th class="ttitle" width="400">공지</th>
		<th class="twrite">작성자</th>
		<th class="tdate">작성일</th>
		<th class="tread">조회수</th>
	</tr>
<%
//글조회 
if(count > 0){
	for(int i=0; i<list.size(); i++){
		FileBean bean = list.get(i);
%>


	<tr>
		<td><%=bean.getNum()%></td>
		<td id="subject"  onclick="location.href='noticeWriteContent.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'"><%=bean.getSubject()%></td>
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

if(id != null){
%>	


<input type="button" value="글쓰기" class="btn" onclick="location.href='noticeWrite.jsp'"/>

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
				
				//시작  페이지 번호 구하기
				// * 하나의 화면에 보여 줄 페이지 수 + 1
				int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock == 0 ? 1 : 0 )) * pageBlock + 1;
				
				int endPage = startPage + pageBlock - 1;
				
				//끝 페이지 번호가 전체 페이지 수보다 클 때..
				if(endPage > pageCount){
					endPage = pageCount;
				}
				//[이전] 시작페이지번호가 한 화면에 보여줄 페이지 수보다 클 때..
				if(startPage > pageBlock){
			%>
					<a href="notice.jsp?pageNum=<%=startPage - pageBlock %>">Prev</a>		
			<%						
				}
				// [1] [2]...... 페이지번호 나타내기
				for(int i=startPage;i<=endPage;i++){
			%>
					<a href="notice.jsp?pageNum=<%=i%>">[<%=i%>]</a>
			<%		
				}
				//[다음] 끝페이지 번호가 전체페이지 수보다 작을떄..
				if(endPage<pageCount){
					%>
					<a href="notice.jsp?pageNum=<%=startPage+pageBlock%>">Next</a>
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





