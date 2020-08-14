<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="file.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}

	FileBean fBean = new FileBean();
	
	String filePath = request.getRealPath("/upload");
	int size = 10*1024*1024;
	
	String filename ="";
	String originalfilename = "";
	try{
		MultipartRequest multi = new MultipartRequest(
			request,
			filePath,
			size,
			"UTF-8",
			new DefaultFileRenamePolicy()
			);
	
	Enumeration files = multi.getFileNames();
	
	String file = (String)files.nextElement();
	filename = multi.getFilesystemName(file);
	originalfilename = multi.getOriginalFileName(file);
	
	fBean.setId(multi.getParameter("id"));
	fBean.setPasswd(multi.getParameter("passwd"));
	fBean.setSubject(multi.getParameter("subject"));
	fBean.setFile(filename);
	fBean.setContent(multi.getParameter("content"));
	
	
	} catch(Exception e){
		System.out.println("MultipartRequest에서 오류발생: "+e);
	}
	
	
	fBean.setDate(new Timestamp(System.currentTimeMillis()));
	fBean.setIp(request.getRemoteAddr());
	
	FileDAO fdao = new FileDAO();
	int check = fdao.insertBoard(fBean);  
	
	if(check == 1){	
%>	
		<script type="text/javascript">
			alert("공지사항이 성공적으로 작성되었습니다. ");
			location.href = "notice.jsp";			
		</script>	
<%
	}else{
%>			
	<script type="text/javascript">
		alert("오류가 발생했습니다. 다시 시도해주세요. ");
		history.back();
	</script>  	
<%
	}
%>

 
 
 
 