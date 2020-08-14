<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">
	
	function result(){
		//현재 작은창의 <input>에 입력한 아이디를 얻어
		// =대입연산자를 기준으로 해서 뒤쪽의 값을 앞으로 저장
		//앞 : join.jsp(부모창)의 아이디 입력<input>태그의 value값으로 설정해서 출력함.
		opener.document.fr.id.value = document.getElementById("finallyId").value;
		
		//join.jsp(부모창)의 아이디 입력<input>태그에 더이상 입력하지 못하도록
		//막아버리기
		opener.document.fr.id.disabled="disabled";
		
		//join.jsp(부모창)의 아이디중복체크 버튼인 <input>태그에 더이상 입력하지 못하도록
		//막아버리기		
		opener.document.getElementById("btn").disabled="disabled";
		
		//자식창(join_IDcheck.jsp) 닫기
		window.close();
	}
	
</script>
 
    
    
<%
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("userid");
		
		MemberDAO mdao = new MemberDAO();

		//입력한 아이디를 전달함.
		int check = mdao.idCheck(id);
		
		// check == 1 -> "사용 중인 아이디입니다." <-- 아이디 있음. 중복
		//					check == 0 -> "사용 가능한 아이디입니다."  <-- 입력한 아이디가 DB에 존재하지 않음. 중복아님.
		if(check == 1){
			out.println("사용중인 아이디입니다.");
		}else{
			out.println("사용가능한 아이디입니다.");
%>
			<%--사용가능한 ID이면 사용함 버튼을 눌러서 부모창(join.jsp)에 사용가능한 ID출력해주기 --%>
			<button type="button" onclick="result();">사용함</button>
			
<%
		}
		
%>
	
	<form action="join_IDcheck.jsp">
	
	
	<%-- join.jsp(부모창)에서 입력한 아이디를 request영역에서 얻어 아래의 input에 출력 --%>
	아이디 : <input type="text" name="userid" value="<%=id%>" id="finallyId"/>
			  <input type="submit" value="중복확인"/>
			  
			  
			  
	</form>