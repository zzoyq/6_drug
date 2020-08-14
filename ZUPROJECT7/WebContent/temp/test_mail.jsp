<%@page import="mail.MailSend"%>
<%@ page contentType="text/html; charset=UTF-8" %>

 
 
<%

MailSend ms = new MailSend();
ms.MailSend();
 
out.println("COMPLETE");
%>


