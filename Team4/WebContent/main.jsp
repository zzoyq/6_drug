<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>YAKBBAL</title>
<link href="css/main.css" rel="stylesheet" type="text/css">
</head>

<body>
		<div id="pill">
		 <a href="${pageContext.request.contextPath}/pill/pill.jsp">
		  <img src="${pageContext.request.contextPath}/images/pill.jpg" width="300">
		 </a>
		 <p><br>약복용</p>
		</div>	
	
		<div id="search">
		 <a href="${pageContext.request.contextPath}/search/searchMain.jsp">
		  <img src="${pageContext.request.contextPath}/images/search.jpg" width="300">
		 </a>
		  <p><br>검색</p>
		</div>	
	
		<div id="medicine">
		 <a href="${pageContext.request.contextPath}/index.jsp">
		  <img src="${pageContext.request.contextPath}/images/medicine.jpg" width="300">
		 </a>
		  <p><br>약국찾기</p>
		</div>	
		<br><br>
	<div class="clear"></div>
	
</body>
</html>