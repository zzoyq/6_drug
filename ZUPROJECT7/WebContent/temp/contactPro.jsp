<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="mail.SMTPAuthenticator"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
  
String id  = request.getParameter("id");
String from = request.getParameter("from");
String to = request.getParameter("to");
String email = request.getParameter("email");
String title = request.getParameter("title");
String contents = request.getParameter("contents");
  
Properties p = new Properties(); // 정보를 담을 객체
  
p.put("mail.smtp.host","smtp.googlemail.com"); 
p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");
 
  
try{
    Authenticator auth = new SMTPAuthenticator();
    Session ses = Session.getInstance(p, auth);
      
    ses.setDebug(true);
    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체  
 
    msg.setSubject(title); //  제목 
 
    StringBuffer buffer = new StringBuffer();
    buffer.append("아이디 : ");
    buffer.append(id+"<br>");    
    buffer.append("이메일 : ");
    buffer.append(email+"<br>");    
    buffer.append("제목 : ");
    buffer.append(title+"<br>");
    buffer.append("내용 : ");
    buffer.append(contents+"<br>");
    Address fromAddr = new InternetAddress(from);
    msg.setFrom(fromAddr);  
 
    Address toAddr = new InternetAddress(to);
    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람 
     
    msg.setContent(buffer.toString(), "text/html;charset=UTF-8"); // 내용
    Transport.send(msg); // 전송   
 
} catch(Exception e){
    e.printStackTrace();
    return;
}
%>

