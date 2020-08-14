<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKPAGE | 다운로드 </title>
</head>
<body>
	<%
		//한글처리
		request.setCharacterEncoding("UTF-8");

		// String path  = request.getParameter("path");
		String name = request.getParameter("name");

		String realPath = getServletContext().getRealPath("/upload");
		response.setContentType("Application/x-msdownload");
		response.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(name, "UTF-8") + "\";");

		File f = new File(realPath + "\\" + name);

		FileInputStream ins = new FileInputStream(f);
		OutputStream outs = response.getOutputStream();

		byte[] buffer = new byte[1024 * 8];

		while (true) {
			int count = ins.read(buffer);
			if (count == -1) {
				break;
			}
			outs.write(buffer, 0, count);
			outs.close(); //close를 꼭 해준다 !! 
		}
		
		
	%>



</body>
</html>





