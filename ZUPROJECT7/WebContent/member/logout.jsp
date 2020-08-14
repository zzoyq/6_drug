<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" href="../css/header.css"/>   

    <%
    	//session내장객체 메모리에 저장되어 있는 값들을 모두 제거 
    	session.invalidate();
   	

    %>
    <script>
    	alert("로그아웃");
    	location.href = "../index.jsp";
    </script>