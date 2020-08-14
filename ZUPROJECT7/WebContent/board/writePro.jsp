<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//한글처리 
	request.setCharacterEncoding("UTF-8");
%>    
    
<%--
	1.write.jsp에서 입력한 새글정보(현재 jsp로 요청한 값)를 request영역에서 얻기
	2.request영역에서 얻은 요청한 값들을  BoardBean객체를 생성해서 각변수에 저장 
 --%>
 <jsp:useBean id="bBean" class="board.BoardBean" />
 <jsp:setProperty property="*" name="bBean"/>
 
<%
	//DB에 입력한 새글정보중.. 글작성날짜및 시간을 추가로 BoardBean에 저장
	bBean.setDate(new Timestamp( System.currentTimeMillis()));
	//DB에 새글정보를 입력하는 클라이언트의 IP주소를  추가로 BoardBean에 저장 
	bBean.setIp(request.getRemoteAddr());	

	//System.currentTimeMillis(); <--- 현재 시스템 시간을 반환 
	//request.getRemoteAddr();<--- 요청한 클라이언트의 IP주소 반환
	
//3. 입력한 새글 정보를 t_board테이블에 INSERT하기 위해  BoardDAO객체를 생성한후 메소드를 호출함.
	BoardDAO bdao = new BoardDAO();
	 
	bdao.insertBoard(bBean);
	
//4. 위의 insertBoard메소드 내부에서 DB와 연결하여 insert작업을 한후  성공하면
	//response.sendRedirect("question.jsp");
%> 
		<script type="text/javascript">
			alert("문의사항이 성공적으로 작성되었습니다. ");
			location.href = "question.jsp";			
		</script>	

 
 
 
 
 
 
 
 
 