<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/header.css" rel="stylesheet" type="text/css">

</head>
<body>
<header>
	<div id="logo">
	 <a href="${pageContext.request.contextPath}/main.jsp">
	  <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo" height="120" >
	 </a>
	</div>	

	<div id="top_menu">
		<a href="${pageContext.request.contextPath}/member/login.jsp">로그인</a>&nbsp;&nbsp;&nbsp;
		<a href="${pageContext.request.contextPath}/member/join.jsp"">회원가입</a>&nbsp;&nbsp;&nbsp;
		<a href="${pageContext.request.contextPath}/member/mypage.jsp">마이페이지</a>
	</div>
	
	<!-- 메뉴 -->
	<nav>
	 <ul>		  
	  <li><a href="${pageContext.request.contextPath}/fill/fill.jsp">약복용</a></li>
	  <li><a href="${pageContext.request.contextPath}/search/searchMain.jsp">약검색</a></li>
	  <li><a href="#">약국찾기</a></li>
	  <li><a href="#">커뮤니티</a></li>
	 </ul>
	</nav>
	
</header>	 
</body>
</html>