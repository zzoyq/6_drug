package mark;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class BookmarkDAO {
	//전역변
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql ="";
	
	
	
 private Connection getConnection() throws Exception{
	
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
	
	con = ds.getConnection();
	return con;
 }//getConnection()
 
 
 
 public void resourceClose(){
	 try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
			
		} catch (SQLException e) {
			System.out.println("자원해제 오류 : " + e);
		}
 }//resourceClose()
 
 
 
 public List<BookmarkBean> getBoardList(int startRow,int pageSize){
	List<BookmarkBean> boardList = new ArrayList<BookmarkBean>();
	
	try {
		con = getConnection();
		
		sql =  "select * from bookmark order by re_ref desc,re_seq asc limit ?,?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, startRow);
		pstmt.setInt(2, pageSize);
		rs =pstmt.executeQuery();
		
		while(rs.next()){
			BookmarkBean bBean = new BookmarkBean();
			bBean.setNum(rs.getInt("num"));
			bBean.setId(rs.getString("id"));
			bBean.setPasswd(rs.getString("passwd"));
			bBean.setSubject(rs.getString("subject"));
			bBean.setImage(rs.getString("image"));
			bBean.setContent(rs.getString("content"));
			bBean.setFile(rs.getString("file"));
			bBean.setRe_ref(rs.getInt("re_ref"));
			bBean.setRe_lev(rs.getInt("re_lev"));
			bBean.setRe_seq(rs.getInt("re_seq"));
			bBean.setReadcount(rs.getInt("readcount"));
			bBean.setDate(rs.getTimestamp("date"));
			bBean.setIp(rs.getString("ip"));
			
			boardList.add(bBean);
			
		}
	} catch (Exception e) {
		System.out.println("getBoardList오류 "+e);
	} finally {
		resourceClose();
	}
	
	return boardList;
			
 }// getBoardList
 
 
 public int getBoardCount(){
	
	int count=0;
	
	try {
		con = getConnection();
		sql = "select count(*) from bookmark";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			count = rs.getInt(1);
		}
		
	} catch (Exception e) {
		System.out.println("getBoardCount오류 "+e);
	} finally {
		resourceClose();
	}	
	return count;
 } //getBoardCount()

 
 
 public void updateReadCount(int num){
		
	 try {
		con = getConnection();
		sql = "update bookmark set readcount = readcount+1 where num=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		System.out.println("updateReadCount오류 "+e);
	} finally {
		resourceClose();
	}
	
	
 }//updateReadCount
 
 
 
 public BookmarkBean getBoard(int num){ 
	 BookmarkBean bBean = null;
	 
	 try {
		con = getConnection();
		sql="select * from bookmark where num = ?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			bBean = new BookmarkBean();
			
			bBean.setNum(rs.getInt("num"));
			bBean.setId(rs.getString("id"));
			bBean.setPasswd(rs.getString("passwd"));
			bBean.setImage(rs.getString("image"));
			bBean.setSubject(rs.getString("subject"));
			bBean.setContent(rs.getString("content"));
			bBean.setFile(rs.getString("file"));
			bBean.setRe_ref(rs.getInt("re_ref"));
			bBean.setRe_lev(rs.getInt("re_lev"));
			bBean.setRe_seq(rs.getInt("re_seq"));
			bBean.setReadcount(rs.getInt("readcount"));
			bBean.setDate(rs.getTimestamp("date"));
			bBean.setIp(rs.getString("ip"));
		}
	} catch (Exception e) {
		System.out.println("getBoard오류 "+e);
	} finally {
		resourceClose();
	}
	 
	 return bBean;
 }//getBoard
 
 
 
 public int insertBoard(BookmarkBean bBean){
	
	int check = 0;
	int num = 0;
	
	try {
		con = getConnection();
		
		sql = "select passwd from member where id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, bBean.getId());
		rs = pstmt.executeQuery();
		
		if(rs.next()){	
			if(bBean.getPasswd().equals(rs.getString("passwd"))){
				
				check=1;
		
				sql =" select max(num) from bookmark";
				pstmt = con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				
				if(rs.next()){
					num = rs.getInt(1) + 1;
				}else{
					num = 1;
				}		
				
				sql = "insert into bookmark (num,id,passwd,image,subject,content,file,"
						+"re_ref,re_lev,re_seq,readcount,date,ip)"
						+" values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, bBean.getId());
				pstmt.setString(3, bBean.getPasswd());
				pstmt.setString(4, bBean.getImage());
				pstmt.setString(5, bBean.getSubject());
				pstmt.setString(6, bBean.getContent());
				pstmt.setString(7, bBean.getFile());
				pstmt.setInt(8, num);
				pstmt.setInt(9, 0);
				pstmt.setInt(10, 0);
				pstmt.setInt(11, 0);
				pstmt.setTimestamp(12, bBean.getDate());
				pstmt.setString(13, bBean.getIp());
				
				pstmt.executeUpdate();
			} else{
				check = 0;
			}
		}	
	} catch (Exception e) {
		System.out.println("insertBoard오류  "+e);		
	}finally {
		resourceClose();
	}
	return check;	
 }//insertBoard
 

 
 public int deleteBoard(int num, String passwd){
	 int check = 0 ;
	
	 try {
		con =getConnection();
		sql = "select passwd from bookmark where num=?";		
		pstmt = con.prepareStatement(sql);		
		pstmt.setInt(1, num);		
		rs = pstmt.executeQuery();			
		if(rs.next()){			
			if(passwd.equals(rs.getString("passwd"))){				
				check = 1;
				sql ="delete from bookmark where num=?";				
				pstmt = con.prepareStatement(sql);				
				pstmt.setInt(1,num);				
				pstmt.executeUpdate();				
			}else{
				check = 0;
			}
		}
	} catch (Exception e) {
		System.out.println("deleteBoard오류 "+e);
	}finally {
		resourceClose();
	}	 
	 return check;
 }//deleteBoard
 
 
 
 public int updateBoard(BookmarkBean bBean){
	 int check = 0;
	 try {		
		con = getConnection();
		sql = "select passwd, id from bookmark where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, bBean.getNum());
		rs = pstmt.executeQuery();
		
		if(rs.next()){			
			if(bBean.getPasswd().equals(rs.getString("passwd"))){
					check=-1;
				
				if(bBean.getId().equals(rs.getString("id"))){
					
					check = 1;
					sql = "update bookmark set id = ?, image=?, subject = ?, content =? where num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bBean.getId());
					pstmt.setString(2, bBean.getImage());				
					pstmt.setString(3, bBean.getSubject());
					pstmt.setString(4, bBean.getContent());
					pstmt.setInt(5, bBean.getNum());
					pstmt.executeUpdate();		
				}
			}else{
				check = 0;				
			}
		}		
	} catch (Exception e) {
		System.out.println("updateBoard오류 "+e);
	} finally {
		resourceClose();
	}
	 return check;
	
 }//updateBoard

 
 
 
 
}//BookmarkDAO
