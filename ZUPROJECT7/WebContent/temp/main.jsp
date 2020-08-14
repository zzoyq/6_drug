<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>



<div class="form-group" style="width: 38%; margin: 10px auto;">  
      <button type="button" class="btn btn-primary btn-lg btn-block" onclick="send_mail()">보내기</button>
  </div>  


<script type="text/javascript">
function send_mail(){
    window.open("./test_mail.jsp", "", "width=370, height=360, resizable=no, scrollbars=no, status=no");
}
</script>


</body>
</html>