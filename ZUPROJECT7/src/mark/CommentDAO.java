package mark;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import mark.CommentBean;


public class CommentDAO {
	
	//전역변수 
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql ="";
	
	//자원 해제 
	public void resourceClose(){
		  try{	
			if(pstmt != null) pstmt.close();
			if(rs != null) rs.close();
			if(con != null) con.close();
		  }catch(Exception e){
			  System.out.println("자원해제 오류 : " + e);
		 }
	}//resourceClose()
	
	
	
	private Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		con = ds.getConnection();
		return con;
		
	} //getConnection
			
	
	
	//list
		public List<CommentBean> getComment(int num){ 
			
			List<CommentBean> commentList=new ArrayList<CommentBean>();
			
			try {
				con=getConnection();
				sql="select * from comment where re_ref=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs=pstmt.executeQuery();
				
				while(rs.next()){
					CommentBean cBean=new CommentBean();
					cBean.setNum(rs.getInt("num"));
					cBean.setId(rs.getString("id"));
					cBean.setPasswd(rs.getString("passwd"));
					cBean.setContent(rs.getString("content"));
					cBean.setDate(rs.getTimestamp("date"));
					cBean.setRe_ref(rs.getInt("re_ref"));
					commentList.add(cBean);
				}
			} catch (Exception e) {
				System.out.println("List오류  : " + e);
			}finally{
				resourceClose();
			}
			return commentList;
		} //list
	
		
		
	//insert
	public void insertComment(CommentBean cBean){

		int num =0;
		
		try{
			con = getConnection();
			sql="select max(num) from comment";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num=rs.getInt(1)+1;
			}else{
				num=1;
			}
			sql = "insert into comment values(?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, cBean.getId());
			pstmt.setString(3, cBean.getPasswd());
			pstmt.setString(4, cBean.getContent());
			pstmt.setTimestamp(5, cBean.getDate());
			pstmt.setInt(6, cBean.getRe_ref());
			pstmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("insert 오류 :" +e);
		}finally{
			resourceClose();
		}
	}//insert
	
	
	
	//delete
	public int deleteComment(int num){
		int check = 0;
		
		try {
			con = getConnection();
			sql = "delete from comment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			check = pstmt.executeUpdate();
			
	
		} catch (Exception e) {
			System.out.println("delete오류  : ");
			e.printStackTrace();
		} finally {
			resourceClose();
		}
		return check;
	}//delete
	
	
	
	//update
	public int updateComment(CommentBean cBean){		
		int check = 0;
		try {
			con = getConnection();
			sql = "select passwd from comment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cBean.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				if(cBean.getPasswd().equals(rs.getString("passwd"))){
					
					check =1; 
					
					sql = "update comment set content=? where num=?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, cBean.getContent());
					pstmt.setInt(2, cBean.getNum());
					
					pstmt.executeUpdate();
					
				}else{
					check = 0; 
				}			
			}
						
		} catch (Exception e) {
			System.out.println("update 오류:" + e);
		} finally {
			//자원해제
			resourceClose();
		}	
		return check; 
	}//update
	
	
	
}//CommentDAO
