<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	//한글처리
	request.setCharacterEncoding("UTF-8");

	String pageNum = request.getParameter("pageNum");

%>
	<%--액션태그로 작성 --%>
	<jsp:useBean id="bBean" class="board.BoardBean" />
	<jsp:setProperty property="*" name="bBean"/>
		
<%
	//BoardDAO객체 생성
	BoardDAO bdao = new BoardDAO();
	
	//BoardDAO객체의 updateBoard(BoardBean bBean) 메소드 호출시
	//글수정에 성공하면  updateBoard메소드의 리턴값은  1
	int check = bdao.updateBoard(bBean);		
			
	if(check == 1){
%>	
		<script>
			 window.alert("글이 수정되었습니다.");
			 location.href="question.jsp?pageNum=<%=pageNum%>";
		</script>		
<%			
	}else{
%>
		<script>
			window.alert("비밀번호를 다시 입력바랍니다.");
			history.back();
		</script>
<%		
	}
%>	




