<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<title>Insert title here</title>
</head>
<body>



<div id="map_canvas" style="width: 400px; height: 400px; margin:0px;"></div>

</body>
</html>