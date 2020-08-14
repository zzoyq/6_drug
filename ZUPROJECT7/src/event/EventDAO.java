package event;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class EventDAO {
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
 
 
 
 public List<EventBean> getBoardList(int startRow,int pageSize){
	List<EventBean> boardList = new ArrayList<EventBean>();
	
	try {
		con = getConnection();
		
		sql =  "select * from event order by re_ref desc,re_seq asc limit ?,?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, startRow);
		pstmt.setInt(2, pageSize);
		rs =pstmt.executeQuery();
		
		while(rs.next()){
			EventBean eBean = new EventBean();
			eBean.setNum(rs.getInt("num"));
			eBean.setId(rs.getString("id"));
			eBean.setPasswd(rs.getString("passwd"));
			eBean.setSubject(rs.getString("subject"));
			eBean.setImage(rs.getString("image"));
			eBean.setContent(rs.getString("content"));
			eBean.setFile(rs.getString("file"));
			eBean.setRe_ref(rs.getInt("re_ref"));
			eBean.setRe_lev(rs.getInt("re_lev"));
			eBean.setRe_seq(rs.getInt("re_seq"));
			eBean.setReadcount(rs.getInt("readcount"));
			eBean.setDate(rs.getTimestamp("date"));
			eBean.setIp(rs.getString("ip"));
			
			boardList.add(eBean);
			
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
		sql = "select count(*) from event";
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
		sql = "update event set readcount = readcount+1 where num=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		System.out.println("updateReadCount오류 "+e);
	} finally {
		resourceClose();
	}
	
	
 }//updateReadCount
 
 
 
 public EventBean getBoard(int num){ 
	 EventBean eBean = null;
	 
	 try {
		con = getConnection();
		sql="select * from event where num = ?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			eBean = new EventBean();
			
			eBean.setNum(rs.getInt("num"));
			eBean.setId(rs.getString("id"));
			eBean.setPasswd(rs.getString("passwd"));
			eBean.setImage(rs.getString("image"));
			eBean.setSubject(rs.getString("subject"));
			eBean.setContent(rs.getString("content"));
			eBean.setFile(rs.getString("file"));
			eBean.setRe_ref(rs.getInt("re_ref"));
			eBean.setRe_lev(rs.getInt("re_lev"));
			eBean.setRe_seq(rs.getInt("re_seq"));
			eBean.setReadcount(rs.getInt("readcount"));
			eBean.setDate(rs.getTimestamp("date"));
			eBean.setIp(rs.getString("ip"));
		}
	} catch (Exception e) {
		System.out.println("getBoard오류 "+e);
	} finally {
		resourceClose();
	}
	 
	 return eBean;
 }//getBoard
 
 
 
 public int insertBoard(EventBean eBean){
	
	int check = 0;
	int num = 0;
	
	try {
		con = getConnection();
		
		sql = "select passwd from member where id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, eBean.getId());
		rs = pstmt.executeQuery();
		
		if(rs.next()){	
			if(eBean.getPasswd().equals(rs.getString("passwd"))){
				
				check=1;
		
				sql =" select max(num) from event";
				pstmt = con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				
				if(rs.next()){
					num = rs.getInt(1) + 1;
				}else{
					num = 1;
				}		
				
				sql = "insert into event (num,id,passwd,image,subject,content,file,"
						+"re_ref,re_lev,re_seq,readcount,date,ip)"
						+" values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, eBean.getId());
				pstmt.setString(3, eBean.getPasswd());
				pstmt.setString(4, eBean.getImage());
				pstmt.setString(5, eBean.getSubject());
				pstmt.setString(6, eBean.getContent());
				pstmt.setString(7, eBean.getFile());
				pstmt.setInt(8, num);
				pstmt.setInt(9, 0);
				pstmt.setInt(10, 0);
				pstmt.setInt(11, 0);
				pstmt.setTimestamp(12, eBean.getDate());
				pstmt.setString(13, eBean.getIp());
				
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
		sql = "select passwd from event where num=?";		
		pstmt = con.prepareStatement(sql);		
		pstmt.setInt(1, num);		
		rs = pstmt.executeQuery();			
		if(rs.next()){			
			if(passwd.equals(rs.getString("passwd"))){				
				check = 1;
				sql ="delete from event where num=?";				
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
 
 
 
 public int updateBoard(EventBean eBean){
	 int check = 0;
	 try {		
		con = getConnection();
		sql = "select passwd, id from event where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, eBean.getNum());
		rs = pstmt.executeQuery();
		
		if(rs.next()){			
			if(eBean.getPasswd().equals(rs.getString("passwd"))){
					check=-1;
				
				if(eBean.getId().equals(rs.getString("id"))){
					
					check = 1;
					sql = "update event set id = ?, image=?, subject = ?, content =? where num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, eBean.getId());
					pstmt.setString(2, eBean.getImage());				
					pstmt.setString(3, eBean.getSubject());
					pstmt.setString(4, eBean.getContent());
					pstmt.setInt(5, eBean.getNum());
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

 
 
 
 
}//EventDAO
