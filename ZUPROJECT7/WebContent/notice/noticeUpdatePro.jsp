<%@page import="java.sql.Timestamp"%>
<%@page import="file.*"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>BOOKPAGE | 공지사항 수정 </title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	String num = request.getParameter("num");
	
	FileBean fBean = new FileBean();
	
	String id = (String) session.getAttribute("id");
	
	if (id == null){
		response.sendRedirect("login.jsp");
	}
	
	// 현재 실행 중인 웹 프로젝트에 대한 정보를 지니고 있는 객체 얻기
	ServletContext ctx = getServletContext();
	
	// 현재 실행 중인 웹 프로젝트에 대한 정보 객체의 getRealPath()메소드를 이용하여
	// 가상경로를 실제 경로로 바꿔주기
	String filePath = ctx.getRealPath("/upload");
	
	int size = 10*1024*1024;
	
	MultipartRequest multi = new MultipartRequest(request,
											filePath,
											size,
											"UTF-8",
											new DefaultFileRenamePolicy()
											);
	
	
	fBean.setNum(Integer.parseInt(multi.getParameter("num")));
	fBean.setId(multi.getParameter("id"));
	fBean.setPasswd(multi.getParameter("passwd"));
	fBean.setSubject(multi.getParameter("subject"));
	fBean.setFile(multi.getFilesystemName("file"));
	fBean.setContent(multi.getParameter("content"));

	// DB객체 생성
	FileDAO fdao = new FileDAO();
	int check = fdao.updateBoard(fBean);
	
	if(check==1){
%>	
	<script type="text/javascript">
		alert("공지사항이 수정되었습니다. ");
		location.href="notice.jsp?pageNum=<%=pageNum%>";
	</script>
<% 		
	}else{
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