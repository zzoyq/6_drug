package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//하는일
//1.DBMS mysql의 jspbeginner데이터베이스와 연결(접속)
//2.insert(새글추가), update(글수정), delete(글삭제), select(글검색)구문등을 만들어서
//  jspbeginner데이터베이스에 전송하여 실행~
public class BoardDAO {//DB작업 하는 클래스 
	
	//전역변수 선언
	Connection con = null;
	ResultSet  rs = null;
	PreparedStatement pstmt = null;
	String sql="";
	
	
	
	//자원 해제 하는 메소드 
	public void resourceClose(){
	  try{	
		if(pstmt != null) pstmt.close();
		if(rs != null) rs.close();
		if(con != null) con.close();
	  }catch(Exception e){
		  System.out.println("자원해제 실패 : " + e);
	  }
	}//resourceClose()
	
	
	
	//연결할 jspbeginner데이터베이스 정보를 담고 있는
	//DataSource(커넥션풀)을 얻고
	//DataSource(커넥션풀)내부에 DB와 미리 연결을 맺은  Connection접속객체를 얻기 위해
	//메소드 만들기
	private Connection getConnection() throws Exception{ 		
		Connection con = null;
		Context init = new InitialContext();
		//커넥션풀 얻기 
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		//커넥션풀로 부터 커넥션 객체 빌려와서 얻기 
		con = ds.getConnection();
		
		return con; //커넥션을 반환
		
	}//getConnection메소드 끝
	
	
	
	//글목록 검색해서 가져오는 메소드
		public List<BoardBean> getBoardList(int startRow,int pageSize){
			
			//board테이블로 부터 검색한 글정보들을 
			//각각 한줄단위로  BoardBean객체에 저장후~
			//BoardBean객체들을 각각 ArrayList배열에 추가로 저장하기 위한 용도
			List<BoardBean> boardList = new ArrayList<BoardBean>();
			
			try{
				//DB연결
				con = getConnection();
				//SQL문 만들기
				sql = "select * from board order by re_ref desc, re_seq asc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					//검색한 글목록중.. 한줄단위의 데이터를 저장할 용도로 객체 생성
					BoardBean bBean = new BoardBean();
					// rs => BoardBean객체의 각변수에 저장
					bBean.setContent(rs.getString("content"));
					bBean.setDate(rs.getTimestamp("date"));
					bBean.setIp(rs.getString("ip"));
					bBean.setName(rs.getString("name"));
					bBean.setNum(rs.getInt("num"));
					bBean.setPasswd(rs.getString("passwd"));
					bBean.setRe_lev(rs.getInt("re_lev"));
					bBean.setRe_seq(rs.getInt("re_seq"));
					bBean.setRe_ref(rs.getInt("re_ref"));
					bBean.setReadcount(rs.getInt("readcount"));
					bBean.setSubject(rs.getString("subject"));
					bBean.setId(rs.getString("id"));
					//BoardBean 객체  =>  ArrayList배열에 추가
					boardList.add(bBean);
				
				}//while반복문 끝
			
			}catch(Exception e){
				System.out.println("getBoardList메소드 내부에서 예외 발생 : " + e);
			}finally {
				//자원해제
				resourceClose();
			}
			
			return boardList; //검색한 글정보들(BoardBean객체들)을 저장하고 있는 배열공간인?
							  //ArrayList를  notice.jsp페이지로 반환(리턴)
		}//getBoardList메소드 끝
	
		
	
		//board테이블에 저장된 전체 글개수를 조회 해서 제공하는 메소드
		public int getBoardCount(){
			//board테이블에 저장되어 있는 조회한 글개수를 저장할 변수
			int count = 0;
			
			try {
				//커넥션풀로 부터 케넥션 얻기(DB와의 연결)
				con = getConnection();
				//SQL문 : 전체 글개수 조회
				sql = "select count(*) from board";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();//전체 글개수 조회후 반환
				//전체 글 개수가 조회 된다면
				if(rs.next()){
					count = rs.getInt(1);// 조회한 글개수를 저장
				}
			} catch (Exception e) {
				System.out.println("getBoardCount()메소드 내부에서 예외발생 : " + e);
			} finally {
				//자원해제
				resourceClose();
			}	
			return count; //조회한 글 개수를 리턴
		}//getBoardCount
	
	
		
		//글번호를 매개변수로 전달받아 글번호에 해당하는 글의 조회수를 1증가 시키는 메소드
		public void updateReadCount(int num){
			try {
				//DB연결
				con = getConnection();
				//SQL문 만들기 : 매개변수로 전달받은 num에 해당하는 글의 조회수를 1증가 시키는 SQL문만들기
				sql = "update board set readcount = readcount+1  where num=?";
				//PreparedStatement SQL문 실행객체 얻기
				pstmt = con.prepareStatement(sql);
				//? 기호에 대응되는 글번호num을 설정
				pstmt.setInt(1, num);
				//UPDATE SQL문 실행~
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				System.out.println("updateReadCount메소드 내부에서 예외 발생 : " + e.toString());
			} finally {
				//자원해제
				resourceClose();
			}	
		}//updateReadCount
		
		
		
		//매개변수로 전달받는 글num에 해당하는 글을 조회 하여 반환 하는 메소드
		public BoardBean getBoard(int num){	
			BoardBean bBean = null;		
			try {
				//DB연결
				con = getConnection();
				//SQL문 만들기  : 매개변수로 전달 받는 글num에 해당하는 글 조회 
				sql = "select * from board where num=?"; 
				//PreparedStatement실행객체 얻기
				pstmt = con.prepareStatement(sql);
				 //?기호에 대응되는 글num설정
				pstmt.setInt(1, num);
				 //SELECT문 실행후  조회한 결과 레코드 얻기
				rs = pstmt.executeQuery();
					
				//rs => BoardBean객체
				rs.next();
				bBean = new BoardBean();
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setIp(rs.getString("ip"));
				bBean.setName(rs.getString("name"));
				bBean.setId(rs.getString("id"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));

			} catch (Exception e) {
				System.out.println("getBoard메소드에서 예외 발생 : " + e);
			} finally{
				resourceClose();
			}
			//BoardBean객체 리턴
			return bBean;
		}//getBoard
		
		
		
	//입력한 새글 정보를  jspbeginner데이터베이스 안의? board테이블에 추가 하기 전에
	//추가할 새글의 글번호를 구하고
	//그글번호 를 이용하여 입력한 새글 정보를 board테이블에 insert 시키는 메소드
	public void insertBoard(BoardBean bBean){ //<--입력한 새글정보는 매개변수로 전달 받음
		
		//추가할 새글번호를 저장할 변수 
		int num = 0;
		
		try {
			//1.커넥션풀로 부터 커넥션객체 얻기
			con = getConnection();
			//2.DB의 테이블에 저장되어 있는 가장 최신 글번호 얻기
			//글이 없을 경우 -> 글번호 1로 만들어 주어야 하고
			//글이 있을 경우 -> 최신글번호 + 1로 만들어 주어야 함
			sql = "select max(num) from board";
			//3. SQL문을 실행할 PreparedStatement실행 객체 얻기
			pstmt = con.prepareStatement(sql);
			//4. SQL문 실행후 결과 데이터 얻기
			rs = pstmt.executeQuery();
			//5.최신글번호가 검색되어 온다면
			if(rs.next()){
				//추가할 새글번호를???  
				//검색해서 얻은 최신글번호 + 1 의 값으로 만들어서 저장
				num = rs.getInt(1) + 1;
			}else{
				num = 1;
			}
			//6. insert SQL문 만들기
			sql = "insert into board "
				+ "(num,name,id,passwd,subject,"
				+ "content,re_ref,re_lev,"
				+ "re_seq,readcount,date,ip)"
				+"values(?,?,?,?,?,?,?,?,?,?,?,?)";
			//7.SQL문을 실행할 PreparedStatement실행 객체 얻기
			pstmt = con.prepareStatement(sql);
			//8.?값(입력한 새글정보들) 설정
			pstmt.setInt(1, num);
			pstmt.setString(2, bBean.getName());
			pstmt.setString(3, bBean.getId());
			pstmt.setString(4, bBean.getPasswd());
			pstmt.setString(5, bBean.getSubject());
			pstmt.setString(6, bBean.getContent());
			pstmt.setInt(7, num);//주글(새글)과 답변글을 묶어서 나타내는 그룹번호 
								// 여기서는 주글(새로추가할글)의 그룹번호
			pstmt.setInt(8, 0);//주글(새로추가할글)의 들여쓰기 정도 레벨값 0 
			pstmt.setInt(9, 0);//주글 순서
			pstmt.setInt(10, 0);//주글(새로추가할글)의 조회수 0
			pstmt.setTimestamp(11, bBean.getDate()); //주글을 추가한 날짜및 시간 
			pstmt.setString(12, bBean.getIp());//주글(새글)을 추가한 사람의  IP주소 
			
			//insert문 실행
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("insertBoard메소드 내부에서 예외발생 : " + e);
		} finally {
			//자원해제
			resourceClose();
		}
		
	}//insertBoard메소드 끝 <------ writePro.jsp페이지에서 호출하는 메소드 	
	

	
	//삭제할 글번호와 입력한 비밀번호를 매개변수로 전달받아...글 삭제 시키는 메소드
	public int deleteBoard(int num, String  passwd){
		int check = 0;
			
		try {
			//커넥션풀로 부터 케넥션객체 얻기(DB연결)
			con = getConnection();
			//SQL문  매개변수로 전달 받는 글num에 해당하는 글의 비밀번호 검색
			sql = "select passwd from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){//삭제할 글에 대한 비밀번호가 검색 된다면?
				//사용자가입력한 비밀번호와  검색해온 글의 비밀번호를 비교하여 동일하면?
				if(passwd.equals(rs.getString("passwd"))){
					check = 1; //삭제성공~
					//SQL문 만들기 : 매개변수로 전달받은 글번호에 해당하는 글을 삭제 
					sql = "delete from board where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate(); //delete실행
				}else{// 사용자가 입력한 비밀번호와  DB에 저장된 비밀번호가 다르면?
					check = 0; //삭제 실패~
				}				
			}	
		} catch (Exception e) {
			System.out.println("deleteBoard메소드 내부에서 예외 발생 : " + e);
		} finally {
			//자원해제
			resourceClose();
		}
		return check; //사용자가 입력한 비밀번호와  DB에 저장된 글의 비밀번호가 일치하면
					  //check변수의 값 1을 리턴
					  //그반대이면 check변수의 값 0을 리턴
	}//delelte
	
	
	
/*수정할 글정보(BoardBean)객체를 메소드의 매개변수로 전달받아.. DB에 저장된 비밀번호와 일치하면 글 수정*/
	public int updateBoard(BoardBean bBean){		
		int check = 0;
		try {
			//1.DB연결
			con = getConnection();
			//2. 매개변수로 전달받는 BoardBean객체의 num변수에 저장된 수정할 글번호에 해당하는
			//   비밀번호 검색
			sql = "select passwd from board where num=?";
			//3. select문을 실행할 PreparedStatement객체 얻기
			pstmt = con.prepareStatement(sql);
			//4. ? 설정
			pstmt.setInt(1, bBean.getNum());
			
			//비밀번호 검색후 검색한 데이터를 ResultSet에 저장후 반환 받기 
			rs = pstmt.executeQuery();
			
			//5. 수정할 글번호에 대한 비밀번호가 검색이 되면?
			if(rs.next()){
				
				//글수정시 사용자가 입력 비밀번호와 DB에 저장되어 있는 수정할 글의 비밀번호가 일치하면?
				if(bBean.getPasswd().equals(rs.getString("passwd"))){
					
					check =1; //비밀번호 맞음 -> 글을 수정 해야함
					
					sql = "update board set name=?, subject=?, content=? where num=?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, bBean.getName());
					pstmt.setString(2, bBean.getSubject());
					pstmt.setString(3, bBean.getContent());
					pstmt.setInt(4, bBean.getNum());
					
					//UPDATE문장 실행
					pstmt.executeUpdate();
					
				}else{
					check = 0; //비밀번호 틀림-> 글을 수정하지 않음
				}			
			}
						
		} catch (Exception e) {
			System.out.println("updateBoard메소드 오류:" + e);
		} finally {
			//자원해제
			resourceClose();
		}	
		return check; //updatePro.jsp로 수정에 성공하면 1을 반환 실패하면 0을 반환
	}//update
	
	/*
	 	답변 달기 필드 설명
	 		re_ref     부모글과 그로부터 파생된 답변글(자식글)이 같은 값을 가지기 위한 그룹값
	 		re_seq	     같은 그룹글들 내의 순서
	 		re_lev	     같은 그룹내에서의 깊이(들여쓰기정도값)
	 
	 	답변 달기 규칙 설명
	 	순서1) re_ref 그룹값은 부모글의 그룹번호(re_ref)값을 사용한다.
	 	순서2) re_seq 값은 부모글의  re_seq에서  +1 증가 한 값을 사용한다.
	 	순서3) re_lev 값은 부모글의 re_lev에서  +1 증가 한 값을 사용한다.
	 
	 */
	public void reInsertBoard(BoardBean bBean){
		
		int num = 0; //답변글의 글번호를 생성하여 저장할 용도
		
		try{
			//1.DB연결
			con = getConnection();
			//2. DB에 저장된 가장 최신글 번호 검색해오기
			sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			//3. select실행 후 최신글번호 얻기
			rs = pstmt.executeQuery();
			//4. 최신글번호가 검색 되면
			if(rs.next()){
				//답변글 글번호를 검색된 최신글번호의 +1 한값으로 저장
				num = rs.getInt(1) + 1;
			}else{//최신글번호가 검색되지 않으면(게시판에 글이 저장되지 않았다면)
				//답변글 글번호를 1로 저장
				num = 1;
			}
			
			//re_seq 답글 순서 재배치
			//조건 : 부모글 그룹과 같은 그룹이면서.. 
			//      부모글의 seq값보다 큰 글들은? seq값을 1증가 시킨다
			sql = "update board set re_seq=re_seq+1 where re_ref=? and re_seq > ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getRe_ref()); //부모글의 그룹번호 사용
			pstmt.setInt(2, bBean.getRe_seq());//부모글의 글 순서
			pstmt.executeUpdate();
			
			//답변글 정보 DB에 추가
			sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bBean.getName());
			pstmt.setString(3, bBean.getId());
			pstmt.setString(4, bBean.getPasswd());
			pstmt.setString(5, bBean.getSubject());
			pstmt.setString(6, bBean.getContent());
			pstmt.setInt(7, bBean.getRe_ref()); //답변글 INSERT시 부모글의 그룹값을 사용하여 INSERT
												//이유 : 부모글과 답변글은 같은 그룹값을 가지기 위함
			pstmt.setInt(8,bBean.getRe_lev()+1);//부모글의 re_lev에  + 1을 사용하여 답변글 INSERT함
			pstmt.setInt(9,bBean.getRe_seq()+1);//부모글의 re_seq에  + 1을 사용하여 답변글 INSERT함
			pstmt.setInt(10, 0);//답변글 INSERT시 글조회수 0
		    pstmt.setTimestamp(11, bBean.getDate()); //답글을 작성한 날짜 	
			pstmt.setString(12, bBean.getIp());//답글 작성자의 IP주소 
			
			//답글 INSERT
			pstmt.executeUpdate();
			
		}catch(Exception err){
			System.out.println("reInsertBoard메소드 내부에서 오류 : " + err);
		}finally {
			//자원해제
			resourceClose();
		}	
	}//reinsert
	
	
	
	
	
	
}//BoardDAO클래스 끝















