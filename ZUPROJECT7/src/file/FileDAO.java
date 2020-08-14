package file;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class FileDAO {
	
	//전역변수 
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql ="";

	 public void resourceClose(){
		 try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				  System.out.println("자원해제 실패 : " + e);
			}
	 }//resourceClose()
	
 private Connection getConnection() throws Exception{
	
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
	
	con = ds.getConnection();
	return con;
 }//getConnection()
 

 
 public List<FileBean> getBoardList(int startRow,int pageSize){
	List<FileBean> boardList = new ArrayList<FileBean>();
	
	try {
		con = getConnection();
		
		sql =  "select * from file order by re_ref desc,re_seq asc limit ?,?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, startRow);
		pstmt.setInt(2, pageSize);
		rs =pstmt.executeQuery();
		
		while(rs.next()){
			FileBean fBean = new FileBean();
			fBean.setNum(rs.getInt("num"));
			fBean.setId(rs.getString("id"));
			fBean.setPasswd(rs.getString("passwd"));
			fBean.setSubject(rs.getString("subject"));
			fBean.setContent(rs.getString("content"));
			fBean.setFile(rs.getString("file"));
			fBean.setRe_ref(rs.getInt("re_ref"));
			fBean.setRe_lev(rs.getInt("re_lev"));
			fBean.setRe_seq(rs.getInt("re_seq"));
			fBean.setReadcount(rs.getInt("readcount"));
			fBean.setDate(rs.getTimestamp("date"));
			fBean.setIp(rs.getString("ip"));
			
			boardList.add(fBean);
			
		}
	} catch (Exception e) {
		System.out.println("getBoardList 오류 "+e);
	} finally {
		resourceClose();
	}
	
	return boardList;
			
 }// getBoardList
 
 
 public int getBoardCount(){
	
	int count=0;
	
	try {
		con = getConnection();
		sql = "select count(*) from file";
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

 public int insertBoard(FileBean fBean){
	
	int check = 0;
	int num = 0;
	
	try {
		con = getConnection();
		
		sql = "select passwd from member where id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, fBean.getId());
		rs = pstmt.executeQuery();
		
		if(rs.next()){	
			if(fBean.getPasswd().equals(rs.getString("passwd"))){
				
				check=1;
		
				
				sql =" select max(num) from file";
				pstmt = con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				
				if(rs.next()){
					num = rs.getInt(1) + 1;
				}else{
					num = 1;
				}		
				
				sql = "insert into file (num,id,passwd,subject,content,file, "
						+"re_ref,re_lev,re_seq,readcount,date,ip)"
						+" values(?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, fBean.getId());
				pstmt.setString(3, fBean.getPasswd());
				pstmt.setString(4, fBean.getSubject());
				pstmt.setString(5, fBean.getContent());
				pstmt.setString(6, fBean.getFile());
				pstmt.setInt(7, num);
				pstmt.setInt(8, 0);
				pstmt.setInt(9, 0);
				pstmt.setInt(10, 0);
				pstmt.setTimestamp(11, fBean.getDate());
				pstmt.setString(12, fBean.getIp());
				
				pstmt.executeUpdate();
			} else{
				check = 0;
			}
		}	
	} catch (Exception e) {
		System.out.println("insertBoard 오류  "+e);		
	}finally {
		resourceClose();
	}return check;	
 }//insertBoard
 

 public void updateReadCount(int num){
	 try {
		con = getConnection();
		sql = "update file set readcount = readcount+1 where num=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		System.out.println("updateReadCount오류 "+e);
	} finally {
		resourceClose();
	}
	
	
 }//updateReadCount

 public FileBean getBoard(int num){ 
	 FileBean fBean = null;
	 
	 try {
		con = getConnection();
		sql="select * from file where num = ?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			fBean = new FileBean();
			
			fBean.setNum(rs.getInt("num"));
			fBean.setId(rs.getString("id"));
			fBean.setPasswd(rs.getString("passwd"));
			fBean.setSubject(rs.getString("subject"));
			fBean.setContent(rs.getString("content"));
			fBean.setFile(rs.getString("file"));
			fBean.setRe_ref(rs.getInt("re_ref"));
			fBean.setRe_lev(rs.getInt("re_lev"));
			fBean.setRe_seq(rs.getInt("re_seq"));
			fBean.setReadcount(rs.getInt("readcount"));
			fBean.setDate(rs.getTimestamp("date"));
			fBean.setIp(rs.getString("ip"));
		}
	} catch (Exception e) {
		System.out.println("getBoard()오류 "+e);
	} finally {
		resourceClose();
	}
	 
	 return fBean;
 }
 
 public int updateBoard(FileBean fBean){
	 int check = 0;
	 try {		
		con = getConnection();
		sql = "select passwd, id from file where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, fBean.getNum());
		rs = pstmt.executeQuery();
		
		if(rs.next()){			
			if(fBean.getPasswd().equals(rs.getString("passwd"))){
					check=-1;
				
				if(fBean.getId().equals(rs.getString("id"))){
					
					check = 1;
					sql = "update file set id = ?, file=?, subject = ?, content =? where num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, fBean.getId());
					pstmt.setString(2, fBean.getFile());
					pstmt.setString(3, fBean.getSubject());
					pstmt.setString(4, fBean.getContent());
					pstmt.setInt(5, fBean.getNum());
					pstmt.executeUpdate();		
				}
			}else{
				check = 0;				
			}
		}		
	} catch (Exception e) {
		System.out.println("updateBoard()오류 "+e);
	} finally {
		resourceClose();
	}
	 return check;
	
 }
 
 
  	

 public int reInsertBoard(FileBean fBean){
	 int num = 0;
	 int check = 0;
	 
	 try {
		con = getConnection();
		sql = "select passwd from file where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, fBean.getNum());
		rs = pstmt.executeQuery();
		
		if(rs.next()){			
			if(fBean.getPasswd().equals(rs.getString("passwd"))){
		
				check=1;
		
				sql = "select max(num) from file";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					num = rs.getInt(1) + 1; 
				}else{
					num = 1;
				}
				
				sql ="update file set re_seq = re_seq+1 where re_ref=? and re_seq > ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, fBean.getRe_ref());
				pstmt.setInt(2, fBean.getRe_seq());
				pstmt.executeUpdate();
				
				
				sql = "insert into file (num,id,passwd,subject,content,file, "
						+"re_ref,re_lev,re_seq,readcount,date,ip)"
						+" values(?,?,?,?,?,?,?,?,?,?,now(),?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, fBean.getId());
				pstmt.setString(3, fBean.getPasswd());
				pstmt.setString(4, fBean.getSubject());
				pstmt.setString(5, fBean.getContent());
				pstmt.setString(6, fBean.getFile());
				pstmt.setInt(7, fBean.getRe_ref());
				pstmt.setInt(8, fBean.getRe_lev()+1);
				pstmt.setInt(9, fBean.getRe_seq()+1);
				pstmt.setInt(10, 0);
				pstmt.setString(11, fBean.getIp());
				pstmt.executeUpdate();
			}else{
				check = 0;
			}
			
		}	
		
	} catch (Exception e) {
		System.out.println("reInsertBoard()오류 "+e);
		e.printStackTrace();
	}finally {
		resourceClose();
	}return check;
 }//reInsertBoard() 
 
 public int deleteBoard(int num, String passwd){
	 int check = 0 ;
	
	 try {
		con =getConnection();
		sql = "select passwd from file where num=?";		
		pstmt = con.prepareStatement(sql);		
		pstmt.setInt(1, num);		
		rs = pstmt.executeQuery();			
		if(rs.next()){			
			if(passwd.equals(rs.getString("passwd"))){				
				check = 1;
				sql ="delete from file where num=?";				
				pstmt = con.prepareStatement(sql);				
				pstmt.setInt(1,num);				
				pstmt.executeUpdate();				
			}else{
				System.out.println("삭제실패 ");
				check = 0;
			}
		}
	} catch (Exception e) {
		System.out.println("deleteBoard() 오류 "+e);
	}finally {
		resourceClose();
	}	 
	 return check;
 }
 
 
}
