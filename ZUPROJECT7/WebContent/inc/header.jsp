<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="../css/header.css"/>    

<div id="wrap_header">
<header>
<div id="menu">
<%
		
			String id = (String)session.getAttribute("id");
			
			if(id == null){
				//로그인이 되지 않는 화면 나타내기
		%>		
				<div id="login">
					<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/login.jsp'">로그인</button>&nbsp;
					<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/join.jsp'">회원가입</button>
				</div>
		<%
			}else{
		%>		
				<div id="login">
					<%=id%>님 로그인
					<a href="${pageContext.request.contextPath}/member/logout.jsp">logout</a>&nbsp;&nbsp;|&nbsp;&nbsp;
					<a href="${pageContext.request.contextPath}/member/myinfo.jsp">회원정보</a>
				</div>
				
		<%		
			}
		%>
		
		
	<div id="header_wrap">
		
		<div id="logo">
			<img alt="BOOKPAGE" src="${pageContext.request.contextPath}/images/mainlogo.gif" width="300" height="100" onclick="location.href='${pageContext.request.contextPath}/index.jsp'">
		</div>
		<!-- 검색 -->
		<div class="box">
			<div class="container-1">
				<span class="icon"><img src="${pageContext.request.contextPath}/images/search.png"></span>
				<input type="search" id="serach" placeholder="BOOKPAGE 검색" />
			</div>
		</div>
		<nav id="top_menu">
			<ul>
				<li><a href="${pageContext.request.contextPath}/index.jsp">북페이지 홈</a></li>
				<li><a href="${pageContext.request.contextPath}/notice/notice.jsp">공지사항</a></li>
				<li><a href="${pageContext.request.contextPath}/event/event.jsp">이벤트</a></li>
			</ul>
		</nav>
		<br>
		<nav id="sub_menu">
			<ul>
				<li><a href="${pageContext.request.contextPath}/new/newbook.jsp">&nbsp;&nbsp;신간</a></li>
				<li><a href="${pageContext.request.contextPath}/best/bestbook.jsp">베스트셀러</a></li>
				<li><a href="${pageContext.request.contextPath}/ebook/ebook.jsp">전자책</a></li>
				<li><a href="${pageContext.request.contextPath}/board/audio.jsp">오디오북</a></li>	
				<li><a href="${pageContext.request.contextPath}/bookmark/bookmark.jsp">공유 북마크</a></li>
			</ul>
		</nav>
		
		</div>
		</div>
		<hr>
		
		
		
	
</header>
</div>
