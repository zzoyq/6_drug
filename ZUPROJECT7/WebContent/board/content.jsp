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
<title>BOOKPAGE | 문의사항</title>
<link rel="stylesheet" href="../css/read.css"/>
</head>
<%
	/*글 상세보기 페이지*/	
	
	// num  pageNum 가져오기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	//전달받은 글num을 이용하여 글을 검색 하기 위해 BoardDAO객체를 생성하고 
	BoardDAO dao = new BoardDAO();
	
	//검색하는 하나의 글정보의 조회수를 1증가 시킨다.
	dao.updateReadCount(num);
	 
	//하나의 글정보를 검색 하여 얻는다.
	BoardBean bBean = dao.getBoard(num); 
	int DBnum = bBean.getNum(); //조회한 글번호 
	String DBid = bBean.getId(); //조회한 작성자 
	int DBReadcount = bBean.getReadcount();//조회한 조회수
	
	//날짜형식을 조작할수 있는 SimpleDataFormat객체의 format()메소드 사용
	SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
	Timestamp DBDate =  bBean.getDate();//조회한 작성일
	String newDate = f.format(DBDate);
	
	String DBContent = "";
	
	if(bBean.getContent() != null){//조회한 글내용이 존재하면
	
		//조회한 글내용을 변수에 저장. 단! 작성한 글내용중 엔터키로 줄바꿈 한것들을 똑같이 처리하여 반환			
		DBContent = bBean.getContent().replace("\r\n","<br>");
	}
	
	
	String DBSubject = bBean.getSubject();//조회한 글제목

	//답변글에 사용되는 조회한 값들 얻기
	int DBRe_ref = bBean.getRe_ref(); //조회한 주글의 그룹번호
	int DBRe_lev = bBean.getRe_lev(); //조회한 주글의 들여쓰기 정도값
	int DBRe_seq = bBean.getRe_seq(); //주글들 내의  조회한 주글의 순서값
	
	
%> 
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->


<!-- 게시판 -->
		<article>
			<h1>문의사항</h1>
			<table id="question">
				<tr>
					<td id="title2" colspan="2"><%=DBSubject%></td>
				</tr>
				<tr>
					<td>작성자&nbsp;&nbsp;<%=bBean.getId()%></td>
					<td>작성일&nbsp;&nbsp;<% out.print(newDate);%></td>
				</tr>	
				<tr>
					<td id="content" colspan="2"><%=DBContent%></td>
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
					   value="수정" 
					   class="btn" 
					   onclick="location.href='update.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>'">
					   
				<input type="button" 
					   value="삭제" 
					   class="btn" 
					   onclick="location.href='delete.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>'">
					   
					   
				
			<%
					}
				}
			%>
			
				<input type="button" 
					   value="답글" 
					   class="btn" 
					   onclick="location.href='reWrite.jsp?num=<%=DBnum%>&re_ref=<%=DBRe_ref%>&re_lev=<%=DBRe_lev%>&re_seq=<%=DBRe_seq%>'">
				<input type="button" 
					   value="목록" 
					   class="btn" 
					   onclick="location.href='question.jsp?pageNum=<%=pageNum%>'">
				</div>
			<div class="clear"></div>
		</article>
<br>
<br>
<br>
<br>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>	





