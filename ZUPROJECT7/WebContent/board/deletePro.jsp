<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKPAGE | 문의사항삭제 </title>
<link rel="stylesheet" href="../css/read.css"/>
</head>
<body>
<%
//한글 인코딩 방식 UTF-8설정
request.setCharacterEncoding("UTF-8");
	
//입력한 삭제할 글번호, 페이지넘버, 비밀번호 얻기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
String passwd = request.getParameter("passwd");

//글삭제에 성공하면  deleteBoard메소드로 부터 1을 반환 받고, 삭제에 실패하면 0을 반환받는다.
BoardDAO bdao = new BoardDAO();
int check = bdao.deleteBoard(num,passwd);
 
if(check == 1){
%>	
	<script type="text/javascript">
		alert("문의사항이 삭제되었습니다.");
		location.href="question.jsp?pageNum=<%=pageNum%>";
	</script>
<%	
}else{//check == 0  

%>	
	<script type="text/javascript">
		alert("비밀번호를 다시 입력바랍니다.");
		history.back();
	</script>
<%			

}
%>
	




</body>
</html>
