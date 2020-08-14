<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    //한글처리
   request.setCharacterEncoding("utf-8");
    
   String name = request.getParameter("name");
   String id = request.getParameter("id");
   String passwd = request.getParameter("passwd");
   Integer age = Integer.parseInt(request.getParameter("age"));
   String gender = request.getParameter("gender");
   String phone = request.getParameter("phone");
   String email = request.getParameter("email");
   String postcode = request.getParameter("postcode");
   String address = request.getParameter("address");
   String address2 = request.getParameter("address2");
   
   //memberbean객체에 저장
   MemberBean memberBean = new MemberBean(); 
   memberBean.setName(name);
   memberBean.setId(id);
   memberBean.setPasswd(passwd);
   memberBean.setAge(age);
   memberBean.setGender(gender);
   memberBean.setPhone(phone);
   memberBean.setEmail(email);
   memberBean.setPostcode(postcode);
   memberBean.setAddress(address);
   memberBean.setAddress2(address2);
   
   //DB연동
   MemberDAO memberDAO = new MemberDAO();
   memberDAO.insertMember(memberBean);
   
   %>
   
   <script type="text/javascript">
		alert("회원가입에 성공하였습니다. 로그인페이지로 이동합니다.");
		location.href="login.jsp";
	</script>
   