<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="event.EventDAO" %>
<%@page import="event.EventBean" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리 
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}

	EventBean eBean = new EventBean();
	
    
	String imagePath = request.getRealPath("/image");
	int size =10*1024*1024;
	
	String filename ="";
	String originalfilename = "";
	try{
		MultipartRequest multi = new MultipartRequest(
			request,
			imagePath,
			size,
			"UTF-8",
			new DefaultFileRenamePolicy()
			);
	
	Enumeration files = multi.getFileNames();
	
	String file = (String)files.nextElement();
	filename = multi.getFilesystemName(file);
	originalfilename = multi.getOriginalFileName(file);
	
	eBean.setId(multi.getParameter("id"));
	eBean.setPasswd(multi.getParameter("passwd"));
	eBean.setSubject(multi.getParameter("subject"));
	eBean.setImage(filename);
	eBean.setContent(multi.getParameter("content"));
	
	
	} catch(Exception e){
		System.out.println(" MultipartRequest에서 오류발생: "+e);
	}
	
	
	eBean.setDate(new Timestamp(System.currentTimeMillis()));
	eBean.setIp(request.getRemoteAddr());
	
	if(filename != null){
		ParameterBlock pb = new ParameterBlock();
		pb.add(imagePath +"/"+filename);
		RenderedOp rOp=JAI.create("fileload", pb);
		
		BufferedImage bi = rOp.getAsBufferedImage();
		BufferedImage thumb = new BufferedImage(50,50,BufferedImage.TYPE_INT_RGB);
		Graphics2D g = thumb.createGraphics();
		g.drawImage(bi, 0, 0,50, 50, null);
		File file = new File(imagePath+"/sm_"+filename);
		ImageIO.write(thumb, "jpg",file);
	}
	
	EventDAO edao = new EventDAO();
	int check = edao.insertBoard(eBean);  
	
	if(check == 1){	
%>	
		<script type="text/javascript">
			alert("이벤트가 성공적으로 작성되었습니다. ");
			location.href = "event.jsp";			
		</script>	
<%
	}else{
%>			
	<script type="text/javascript">
		alert("오류가 발생했습니다. 다시 시도해주세요. ");
		history.back();
	</script>  	
<%
	}
%>