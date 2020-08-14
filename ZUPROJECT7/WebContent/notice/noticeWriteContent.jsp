<%@page import="java.io.File"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="file.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<title>BOOKPAGE | 공지사항 </title>
<link rel="stylesheet" href="../css/read.css"/>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	// 클릭한 글번호, 페이지 가져오기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	FileDAO dao = new FileDAO();
	
	//String directory = application.getRealPath("/upload/");
	//String [] files = new File(directory).list();
	
	// 조회수 증가작업
	dao.updateReadCount(num);
	
	// DB에 저장된 글정보 가져와 각각 변수에 저장하기(글목록 표시 목적)
	String DBContent = "";
	FileBean fBean = dao.getBoard(num);
	
	int DBnum = fBean.getNum();
	int DBread = fBean.getReadcount();
	String DBid = fBean.getId();
	SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd"); 
	Timestamp DBdate = fBean.getDate();
	String newDate = f.format(DBdate);
	String DBSubject = fBean.getSubject();
	
	if(fBean.getContent() != null){
		DBContent = fBean.getContent().replace("\r\n", "<br/>");
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
			<h1>공지사항</h1>
			<table id="notice">
				<tr>
					<td id="title2" colspan="2"><%=fBean.getSubject()%></td>
				</tr>
				
				<tr>
					<td>작성자&nbsp;&nbsp;<%=fBean.getId()%></td>
					<td>작성일&nbsp;&nbsp;<% out.print(newDate);%></td>
				</tr>	
				<tr>
					<td id="content" colspan="2"><%=fBean.getContent()%></td>
				</tr>
			
				<tr>
					<td colspan="2">파일&nbsp;&nbsp;&nbsp;&nbsp;<%=fBean.getFile()%>&nbsp;&nbsp;&nbsp;&nbsp;<a href="download.jsp?name=<%=fBean.getFile()%>">파일 다운로드</a></td>
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
					if(id.equals(fBean.getId())){
			%>	

				<input type="button" 
					   value="수정 "
					   class="btn"				
					   onclick="location.href ='noticeUpdate.jsp?num=<%=fBean.getNum()%>&pageNum=<%=pageNum%>'">
									
			
				<input type="button" 
					   value="삭제" 
					   class="btn" 
					   onclick="location.href='noticeDelete.jsp?num=<%=fBean.getNum()%>&pageNum=<%=pageNum%>'">
							
			<%
					}
				}
			%>
			<input type="button" 
				   value="목록" 
				   class="btn" 
				   onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">
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
	
	
	
		 
