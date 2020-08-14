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
<%@page import="mark.BookmarkDAO"%>
<%@page import="mark.BookmarkBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String pageNum = request.getParameter("pageNum");

	BookmarkBean bBean = new BookmarkBean();
	
	
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
		
		bBean.setNum(Integer.parseInt(multi.getParameter("num")));	
		bBean.setId(multi.getParameter("id"));
		bBean.setPasswd(multi.getParameter("passwd"));
		bBean.setSubject(multi.getParameter("subject"));
		bBean.setImage(filename); 
		bBean.setContent(multi.getParameter("content"));
	
	} catch(Exception e){
		System.out.println("MultipartRequest에서 오류발생: "+e);
	}
	
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
	
	BookmarkDAO bdao = new BookmarkDAO(); 
	int check = bdao.updateBoard(bBean);
	
	if(check == 1){ //수정성공
%>
		<script type="text/javascript">
			alert("북마크가 수정되었습니다.");
			location.href = "bookmark.jsp";			
		</script>
<%			
	} else{ // 수정실패, 비밀번호 틀림
%>
	<script type="text/javascript">
		alert("비밀번호를 다시 입력바랍니다.");
		history.back();
	</script>
<%		
	}
%>	