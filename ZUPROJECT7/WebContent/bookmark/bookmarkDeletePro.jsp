<%@page import="mark.BookmarkDAO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String passwd = request.getParameter("passwd");
	
	BookmarkDAO bdao = new BookmarkDAO(); 
	int check = bdao.deleteBoard(num,passwd);
	
	if(check==1){
%>
		<script type="text/javascript">
			alert("북마크가 삭제되었습니다. ");
			location.href="bookmark.jsp?pageNum=<%=pageNum%>";
		</script>		
<%
	}else{
%>
		<script>
			alert("비밀번호를 다시 입력바랍니다.");
			history.back();
		</script>
<%		
	}
%>