<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

     
<%
	request.setCharacterEncoding("UTF-8");

	//2. reWrite.jsp에서 입력한 답글 내용들을 request내장객체 영역에서 얻어오기
	int num = Integer.parseInt(request.getParameter("num")); //답변글 작성시 부모글번호 전달받기
	int re_ref = Integer.parseInt(request.getParameter("re_ref"));
	int re_lev = Integer.parseInt(request.getParameter("re_lev"));
	int re_seq = Integer.parseInt(request.getParameter("re_seq"));
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
		
	//3.BoardBean객체를 생성하여 각변수에  입력한 답글 내용들을 각각 저장
	BoardBean bBean  = new BoardBean();
	bBean.setNum(num);
	bBean.setRe_ref(re_ref);
	bBean.setRe_lev(re_lev);
	bBean.setRe_seq(re_seq);
	bBean.setId(id);
	bBean.setPasswd(passwd);
	bBean.setSubject(subject);
	bBean.setContent(content);
	//4.추가로 답글을 작성한 사람의 IP주소, 답글을 작성한 날짜정보를 BoardBean객체의 각변수에 저장
	bBean.setIp(request.getRemoteAddr());
	bBean.setDate(new Timestamp(System.currentTimeMillis()));
	
	
	//5.입력한 답글내용을 DB에서 전송하여 INSERT추가
	BoardDAO bdao = new BoardDAO();
	bdao.reInsertBoard(bBean); 
	
    response.sendRedirect("question.jsp");
%>



