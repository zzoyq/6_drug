<%@page import="file.FileDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
	
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
String passwd = request.getParameter("passwd");

//삭제할 글번호,입력한 비밀번호를 BoardDAO객체의 deleteBoard메소드 호출시 인수로 전달하여 삭제작업함
FileDAO fdao = new FileDAO();
int check = fdao.deleteBoard(num,passwd);
 
if(check == 1){
%>	
	<script type="text/javascript">
		alert("공지사항이 삭제되었습니다.");
		location.href="notice.jsp?pageNum=<%=pageNum%>";
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
