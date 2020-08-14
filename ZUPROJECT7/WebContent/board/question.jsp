<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOOKPAGE | 문의사항 </title>
<link rel="stylesheet" href="../css/board2.css"/>
</head>
<%
	BoardDAO boardDAO = new BoardDAO();

	//DB에 저장되어 있는 전체 글의 개수를 조회
	int count = boardDAO.getBoardCount();
	int pageSize = 10;
		
	//아래의쪽의 클릭한 페이지번호 얻기
	String pageNum = request.getParameter("pageNum");
	
	//아래쪽에 클릭한 페이지번호가 존재하지 않으면(현재 선택한 페이지번호가 없으면)
	//1페이지 가 화면에 보여야 하기 떄문에..
	//pageNum을 1로 저장
	if(pageNum == null){
		pageNum = "1";
	}
	
	//현재 보여질(선택한)페이지번호  "1"을  -> 기본정수 1로 변경
	int currentPage = Integer.parseInt(pageNum);
	
	//각페이지 마다 첫번째로 보여질 시작 글번호 구하기
	//(현재 보여질 페이지번호  - 1) * 한페이지당 보여줄 글개수 10
	int startRow = (currentPage - 1) * pageSize;
	
	//board테이블에 존재하는 모든 글을 조회하여 저장할 용도의 ArrayList배열객체를 담을 변수 선언
	List<BoardBean> list = null;
	
	//만약 board테이블에 글이 있다면
	if(count > 0){
		//board테이블에 존재하는 글을 검색해서 가져옴
		//				getBoardList(시작글번호,한페이지당보여줄글수)
		list = boardDAO.getBoardList(startRow,pageSize);
		System.out.println(list.size());   
	}	
%> 



<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/header.jsp"/>
<!-- 헤더들어가는 곳 -->


<!-- 게시판 -->

<article>
<h1>문의사항</h1>
<table id="question">
<tr><th class="tno">No</th>
    <th class="ttitle" width="400">문의사항 </th>
    <th class="twrite">작성자 </th>
    <th class="tdate">작성일 </th>
    <th class="tread">조회수 </th></tr>
<%
//만약 게시판 글개수가 조회 된다면(게시판에 글이 저장 되어 있다면)
if(count > 0){
	//ArryList에 저장되어 있는 검색한 글정보들(BoardBean객체들)의 갯수 만큼 반복하는데..
	for(int i=0; i<list.size(); i++){
		//ArrayList의 각인덱스 위치에 저장 되어 있는 BoardBean객체를 ArrayList배열로부터 얻어 출력
		BoardBean bean = list.get(i);
%>


	<tr>
		<td><%=bean.getNum()%></td>
		<td id="subject" onclick="location.href='content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'">
		<%
			int wid = 0; //답변글에 대한 들여쓰기 값 저장
			
			//답변글이라면? 
			if(bean.getRe_lev() > 0){
				//들여쓰기 값 처리
				wid = bean.getRe_lev() * 10;	
		%>	
		<img src="../images/center/level.gif" width="<%=wid%>" height="15">
		<img src="../images/center/re.gif">
		<%} %>
		
		<%=bean.getSubject()%>
		</td>
		<td><%=bean.getId()%></td>
		<td><%=new SimpleDateFormat("yyyy.MM.dd").format(bean.getDate())%></td>
		<td><%=bean.getReadcount()%></td>
	</tr>
<%		
	}
}else{
%>
	<tr>
		<td colspan="5">게시판에 글이 존재하지 않습니다.</td>
	</tr>
<%	
}
%>
</table>
<br>
<br>
<br>



<div id="table_search">
	<input type="text" name="search" class="input_box">
	<input type="button" value="검색" class="btn">
<%

String id = (String)session.getAttribute("id");

//session영역에 값이 저장되어 있으면  글쓰기 버튼 보이게 설정
if(id != null){
%>	
<input type="button" value="글쓰기" class="btn" onclick="location.href='write.jsp'"/>

</div>
<%}%>
<br>
<br>


<div class="clear"></div>
<div id="page_control">
<%
			if(count > 0){
				int pageCount = count/pageSize + (count%pageSize ==0 ? 0 : 1);
				
				//한 화면에 표시될 페이지수 설정
				int pageBlock = 5;
				
				//시작  페이지 번호 구하기
				// 1~10 => 1    11~20 => 11    21~30 = >21
				//((아래쪽에 클릭한 페이지 번호/한 화면에 보여줄 페이지 수) -
				//(아래쪽에 클릭한 페이지 번호를 한 화면에 보여줄 페이지수로 나눈 나머지 값))
				// * 하나의 화면에 보여 줄 페이지 수 + 1
				int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock == 0 ? 1 : 0 )) * pageBlock + 1;
				
				int endPage = startPage + pageBlock - 1;
				
				//끝 페이지 번호가 전체 페이지 수보다 클 때..
				if(endPage > pageCount){
					endPage = pageCount;
				}
				//[이전] 시작페이지번호가 한 화면에 보여줄 페이지 수보다 클 때..
				if(startPage > pageBlock){
			%>
					<a href="question.jsp?pageNum=<%=startPage - pageBlock %>">Prev</a>		
			<%						
				}
				// [1] [2]...... 페이지번호 나타내기
				for(int i=startPage;i<=endPage;i++){
			%>
					<a href="question.jsp?pageNum=<%=i%>">[<%=i%>]</a>
			<%		
				}
				//[다음] 끝페이지 번호가 전체페이지 수보다 작을떄..
				if(endPage<pageCount){
					%>
					<a href="question.jsp?pageNum=<%=startPage+pageBlock%>">Next</a>
					<%
				}				
			}		
%>		
</div>
</article>

<!-- 게시판 -->
<div class="clear"></div>
<br>
<br>
<br>
<br>
<br>
<br>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>





