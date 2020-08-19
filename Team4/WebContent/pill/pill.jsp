<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>YAKBBAL</title>
<link href="../css/main.css" rel="stylesheet" type="text/css">
<link href="../css/header.css" rel="stylesheet" type="text/css">
<link href="../css/footer.css" rel="stylesheet" type="text/css">
<link href="../css/pill.css" rel="stylesheet" type="text/css">

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(function(){
		  $("a[name='trigger']").click(function() {
		    var i = $("a[name='trigger']").index(this);
		    if(!$(this).is(':hidden')) $("tr[name='article']").eq(i).show('fast');
		    $("tr[name='article']").hide();
		  });
		});
</script>

</head>
<body>
<!-- header 시작  -->
<%@include file="../inc/header.jsp" %>
<!-- header 끝 -->
<!-- 본문내용 -->
<article>
	<table id="list" width="900" border="1" align="center" style="text-align: center"> 
	  <tr>
	  	<td>Num</td>
	  	<td colspan="2">약이름</td>
	  </tr>
	  <tr>
	    <td>1</td>
	    <td><a href="#1" name="trigger">약1</a></td>
	    <td><button>복용</button></td>
	  </tr>
	  <tr name="article" class="hide">
	    <td colspan="3">그래프</td>
	  </tr>
	  <tr>
	    <td>2</td>
	    <td><a href="#2" name="trigger">약2</a></td>
	    <td><button>복용</button></td>
	  </tr>
	  <tr name="article" class="hide">
	    <td colspan="3">그래프</td>
	  </tr>
	  <tr>
	    <td>3</td>
	    <td><a href="#3" name="trigger">약3</a></td>
	    <td><button>복용</button></td>
	  </tr>
	  <tr name="article" class="hide">
	    <td colspan="3">그래프</td>
	  </tr>
	</table>
</article>
<!-- 본문내용 -->
<!-- footer 시작 -->
<%@include file="../inc/footer.jsp" %>
<!-- footer 끝 -->
</body>
</html>