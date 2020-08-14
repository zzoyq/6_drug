<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBwlNqAEil52XRPHmSVb4Luk18qQG9GqcM&sensor=false&language=en"></script> 
<script> 
  function initialize() { 
var myLatlng = new google.maps.LatLng(35.158609, 129.062071); // 좌표값
  var mapOptions = { 
        zoom: 14, // 지도 확대레벨 조정
        center: myLatlng, 
        mapTypeId: google.maps.MapTypeId.ROADMAP 
  } 
  var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions); 
  var marker = new google.maps.Marker({ 
position: myLatlng, 
map: map, 
title: "BOOKPAGE | 북페이지" 
}); 
  } 
window.onload = initialize;

</script>
<title>BOOKPAGE | CONTACT US</title>
<link rel="stylesheet" href="../css/contact.css"/>
</head>

<body>
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->
<%
		String id = (String) session.getAttribute("id");
		if (id == null) {
	%>
	<script type="text/javascript">
		alert('로그인 후 이용가능합니다');
		location.href = "${pageContext.request.contextPath}/member/login.jsp";
	</script>
	<%
		}
	
	%>

<br>
<br>
<br>
<br>
<br>
<br>
<article>
	<h1 style="margin-left: 70px;">CONTACT BOOKPAGE</h1>
	<div id="con">
		<div id="send" class="con" style="display: inline-block; margin-left: 100px;" >
		<form action="contactPro.jsp" method="post">
			<input type="hidden" name="from" value="wifitou03@gmail.com" readonly />
			<input type="hidden" name="to" value="poettzu@gmail.com" readonly />
			<table id="contact">
				<tr>
					<td> &nbsp; 아이디&nbsp;<sup>*</sup><br>
					<input type="text" name="id" value="<%=id%>" readonly></td> 
				</tr>
				<tr>
					<td> &nbsp; 제목&nbsp;<sup>*</sup><br>
					<input type="text" name="subject" required="required"> </td>
				</tr>
				<tr>
					<td> &nbsp; 메일주소&nbsp;<sup>*</sup><br>
					 <input type="email" name="email" required="required"></td>
				</tr>
				<tr>
					<td> &nbsp; 내용&nbsp;<sup>*</sup></td>
				</tr>
				<tr>
					<td>
					<textarea rows="10%" cols="80%"  name="content" id="content" class="content" required="required"></textarea></td>
				</tr>
				
			</table>
					<input type="submit" value="전송" class="btn" id="btn">
		</form>
		</div>
		<div id="map" class="con" style="display: inline-table;">
			<div id="map_canvas" style="width: 400px; height: 450px; margin:0px;"></div>
			<p>BOOK PAGE</p>
			<p>찾아오시는 길</p>
			<p>부산광역시 부산진구 동천로 109 삼한골든게이트빌딩7층 6Class</p>
			<p>전화</p>
			<p>000-000-0000</p>
		</div>
	</div>
</article>
<br>
<br>
<br>
<br>
<br>
<br>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</body>
</html>



