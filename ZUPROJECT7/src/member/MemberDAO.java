package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {//DB작업
	
	//전역변수
	Connection con = null;
	ResultSet  rs = null;
	PreparedStatement pstmt = null;
	String sql="";
	
	
	
	//자원 해제
	public void resourceClose(){
	  try{	
		if(pstmt != null) pstmt.close();
		if(rs != null) rs.close();
		if(con != null) con.close();
	  }catch(Exception e){
		  System.out.println("자원해제 실패 : " + e);
	  }
	}//resourceClose()
	
	
	
	private Connection getConnection() throws Exception{ 
		
		Connection con = null;
		Context init = new InitialContext();
		//커넥션풀 얻기 
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		//커넥션풀로 부터 커넥션 객체 빌려와서 얻기 
		con = ds.getConnection();
		
		return con; //커넥션을 반환
		
	}//getConnection메소드 끝
	
	//join.jsp에서 입력한 회원정보들을 -> 
	//MemberBean객체의 각변수에 저장후 -> 
	//MemberDAO의 insertMember메소드의매개변수로 전달 받음
	/*입력받은 회원정보들을 DB에 insert시키는 메소드 */
	public  void   insertMember(MemberBean  memberBean){
			
		try{	
			//1.DB접속(연결) : 커넥션풀 DataSource로 부터  커넥션 Connection객체 빌려오기 
			con = getConnection();
			
			//2.SQL문 만들기 (INSERT)
			sql = "insert into member(name,id,passwd,age,gender,phone,email,postcode,address,address2)"
				+ "values(?,?,?,?,?,?,?,?,?,?)";
			
			//3. 위 Insert전체 문자열 중에서 ?기호에 대응되는 설정값을 제외한  전체 구문을
			//  PreparedStatement객체에 로딩후 
			//  PreparedStatement객체 자체를 반환
			pstmt = con.prepareStatement(sql);
			//4. ?기호에 대응되는 값들을  설정
			pstmt.setString(1, memberBean.getName());
			pstmt.setString(2, memberBean.getId());
			pstmt.setString(3, memberBean.getPasswd());
			pstmt.setInt(4, memberBean.getAge());
			pstmt.setString(5, memberBean.getGender());
			pstmt.setString(6, memberBean.getPhone());
			pstmt.setString(7, memberBean.getEmail());
			pstmt.setString(8, memberBean.getPostcode());
			pstmt.setString(9, memberBean.getAddress());
			pstmt.setString(10, memberBean.getAddress2());

		
			//5. insert 문장을 DB에 전송 하여 실행
			pstmt.executeUpdate();
		  }catch(Exception e){
			  System.out.println("insertMember메소드 내부에서 SQL실행예외 : " + e);
		  }	finally { //무조건 한번 실행 해야 할 구문이 있을때.... 작성하는 영역
			//6.자원해제
			resourceClose();  
		  }
	}//insertMember메소드 끝
	
	
	//아이디 중복 체크 하는 메소드
	//->  회원가입시 사용자가 입력한 아이디가 DB에 존재하는지 SELECT하여 
	//    존재하면   check변수의 값을 1로 저장 하여  아이디 중복을 나타내고,
	//    존재 하지 않으면  check변수의 값을 0으로 저장 하여 아이디 중복아님을 나타내고,
	//->  결과 적으로 아이디 중복이냐 중복이 아니냐는 check변수에 판단 값이 저장 되므로
	//    check변수의 값을 리턴(반환) 함.
	public int idCheck(String id){//입력한 아이디를 매개변수로 전달 받는다.
		
		int check = 0; //아이디 중복이냐 , 아니냐를? 판단 하는값을 저장
		
		try {
			//1.커넥션풀로 부터 커넥션 객체 얻기(DB연결)
			con = getConnection();
			//2.SQL문 만들기 : 사용자가 입력한 아이디에 해당하는 레코드 검색
			sql = "select * from member where id=?";
			//3.SQL문을 실행할 PreparedStatement객체 얻기
			pstmt = con.prepareStatement(sql);
			//4. ?기호에 대응 되는 입력한 아이디 값 설정
			pstmt.setString(1, id);
			//5. select 실행 후 검색한 결과데이터 얻기
			rs = pstmt.executeQuery();
			//6. ResultSet객체 메모리에 입력한 아이디에 해당하는 회원정보가 검색 되어 저장되어 있으면
			if(rs.next()){
				check = 1; //아이디중복
			}else{
				check = 0; //아이디중복아님
			}
		} catch (Exception e) {
			System.out.println("idCheck메소드 내부에서 예외 발생 : " + e);
		} finally {
			//7.자원해제
			resourceClose();
		}
		//8.리턴 
		return check; // 1 또는 0을  join_IDcheck.jsp로 리턴한다.
	
	}//idCheck()메소드 끝
	
	
	//로그인 처리시 사용하는 메소드(loginPro.jsp페이지에서 호출하는 메소드)
	//입력받은 id,passwd값과 DB에 저장되어 있는 id,passwd값을 비교하여
	//로그인처리 하는 메소드 
	public int userCheck(String id, String passwd){//사용자가 입력한 아이디, 비밀번호 전달 받음
		
		int check = -1;  //  1  ->  아이디 맞음, 비밀번호 맞음
						 //  0  ->  아이디 맞음 , 비밀번호 틀림
						 //  -1 ->  아이디 틀림	
		try {
			//1.커넥션풀로부터 커넥션 얻기
			con = getConnection();
			//2.SQL문 만들기  : 사용자가 입력한 아이디에 해당하는 레코드 검색
			sql = "select * from member where id=?";
			//3.SQL문을 실행할 PreparedStatement객체 얻기
			pstmt  = con.prepareStatement(sql);
			//4. ?기호에 대응 되는 입력한 아이디값을 설정
			pstmt.setString(1, id);
			//5. 입력한 아이디에 해당하는 레코드 검색 실행~
			rs = pstmt.executeQuery();
			//6. 입력한 아이디에 해당하는 레코드가 ResultSet에 저장되어 있다면
			if(rs.next()){//입력한 아이디가 DB에 저장되어 있다면
				//로그인시 사용자가 입력한 비밀번호와 DB에 저장되어 있던 비밀번호를 비교하여
				//동일하면?
				if(passwd.equals(rs.getString("passwd"))){
					check = 1; //아이디 맞음 , 비밀번호 맞음
				}else{	
					check = 0; //아이디 맞음 , 비밀번호 틀림
				}
			}else{//입력한 아이디에 해당하는 레코드가 검색되지 않는다면
				 //(입력한 아이디가 DB에 저장되어 있지 않다면)
				check = -1;
			}
		} catch (Exception e) {
			System.out.println("userCheck메소드 내부에서 예외 발생 : " + e);
		} finally {
			//자원해제
			resourceClose();
		}
		return check;//loginPro.jsp로 반환 
	}
	
	
	
	public MemberBean getData(String id) {

		MemberBean mBean = null;
		
		try {
			con = getConnection();
			sql ="select name, id, passwd, age, phone, email, address, address2 from member where id like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				mBean = new MemberBean();
				mBean.setName(rs.getString("name"));
				mBean.setId(rs.getString("id"));
				mBean.setPasswd(rs.getString("passwd"));
				mBean.setAge(rs.getInt("age"));
				mBean.setPhone(rs.getString("phone"));
				mBean.setEmail(rs.getString("email"));
				mBean.setAddress(rs.getString("address"));
				mBean.setAddress2(rs.getString("address2"));
				
			}
		} catch (Exception e) {
			System.out.println("getData 메소드 내부에서 예외 발생 : "+e);
		}finally {
			resourceClose();
		}
		return mBean;
	}
	
	
	
	//update
	public int infoUpdate(MemberBean memberBean){
		int check = 0;
		try {
			con = getConnection();
			String sql = "select name from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, memberBean.getId());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(memberBean.getName().equals(rs.getString("name"))){
					pstmt.close();
					pstmt = null;
					
					sql = "update member set passwd=?, phone=?, email=?, address=?, address2=? where id=?";
				
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, memberBean.getPasswd());
					pstmt.setString(2, memberBean.getPhone());
					pstmt.setString(3, memberBean.getEmail());
					pstmt.setString(4, memberBean.getAddress());
					pstmt.setString(5, memberBean.getAddress2());
					pstmt.setString(6, memberBean.getId());
					
					pstmt.executeUpdate();
					
					check = 1;
				}else{
					check = 0;
				}
			}
		} catch (Exception e) {
			System.out.println("update 오류 : " +e);
			e.printStackTrace();
		}finally {
			resourceClose();
		}
		return check;
	}//update
	
	//delete
	public int deleteMember(String id, String passwd){
	 
	        int deleteM = 0;
	 
	        try {
	            con = getConnection();
	            String sql = "select passwd from member where id=?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, id);
	            
	            rs = pstmt.executeQuery();
	            if(rs.next()){
	            	if(passwd.equals(rs.getString("passwd"))){
	            		deleteM = 1;  //성공 
	            		pstmt = con.prepareStatement("delete from member where id=?");
	            		pstmt.setString(1, id);
	            		pstmt.executeUpdate();
	            		
	            	}else{
	            		deleteM = 0; //실패 
	            }
	           } 	
	        } catch (Exception e) {
	        	System.out.println("delete오류: "+e);
	        	e.printStackTrace();
	        } finally {
	            resourceClose();
	        }
			return deleteM;
	    }//deleteMemeber 
	
	
}//MemberDAO클래스 끝







