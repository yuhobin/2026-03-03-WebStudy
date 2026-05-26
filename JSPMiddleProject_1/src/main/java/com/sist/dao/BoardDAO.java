package com.sist.dao;
import java.util.*;
import java.sql.*;
///////////Connction Pool
import javax.sql.*;
import javax.xml.crypto.dsig.dom.DOMSignContext;

import com.sist.vo.BoardVO;

import javax.naming.*;

public class BoardDAO {
	private Connection conn;
	private PreparedStatement ps;
	private static BoardDAO dao;
	
	public void getConnection() {
		try {
			Context init=new InitialContext(); // JNDI 초기화
			// => 탐색시 형식으로 만들어져 있다 => 탐색시를 연다
			Context c=(Context)init.lookup("java://comp/env");
			// 저장된 Connection 객체 얻기
			DataSource ds=(DataSource)c.lookup("jdbc/oracle");
			conn=ds.getConnection(); // 주소값을 가지고 와서 저장
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 사용 후 반환 => 재사용 기법 
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/*
	 * 	1. 요청 받는다
	 * 	2. Pool안에 저장된 Connection 객체를 가지고 온다
	 * 	3. SQL 문장 => SQL 실행 => 결과값을 받는다
	 * 	4. 사용 후에 Pool로 반환
	 * 	=> Connection 객체를 관리 => 메모리 누수 현상 방지
	 * 							  ---------------
	 * 	=> 미리 Connection이 연결된 상태이기 때문에 연결 소모시간을 줄일 수 있다. 
	 * 										--------------
	 * 	=> Connection을 관리 => 쉽게 서버가 다운되지 않는다   
	 * 						 ----------------
	 * 	=> 웹사이트의 일반 데이터베이스 연동은 Connection Pool로 되어 있다 
	 */
	// Connection과 관련 => 연결 / 닫기만 처리
	public static BoardDAO newInstance() {
		if(dao==null)
			dao=new BoardDAO();
		return dao;
	}
	// 1. 기능
	public List<BoardVO> boardListData(int page) {
		List<BoardVO> list=new ArrayList<BoardVO>();
		try {
			// 1. 미리 만들어진 Connection 주소 얻기
			getConnection();
			// 2. SQL 문장 
			String sql="SELECT no, subject, name, TO_CHAR(regdate,'yyyy-MM-dd'), hit "
					+"FROM jspboard "
					+"ORDER BY no DESC "
					+"OFFSET ?  ROWS FETCH NEXT 10 ROWS ONLY";
			// 2. SQL문장을 전송
			ps=conn.prepareStatement(sql);
			// 3. 실행 요청 => ?에 값을 채운다
			ps.setInt(1, (page*10)-10); // 0번부터 시작한다
			// 4. 실행후에 결과값 읽기
			ResultSet rs=ps.executeQuery();
			// 5. List에 값을 채운다
			while(rs.next()) {
				BoardVO vo=new BoardVO();
				vo.setNo(rs.getInt(1));
				vo.setSubject(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setDbday(rs.getString(4));
				vo.setHit(rs.getInt(5));
				
				list.add(vo);
				
			}
			rs.close();
		} catch (Exception e) {
			// 오류 처리 
			e.printStackTrace();
		}
		finally {
			disConnection(); // 반환 => Pool안으로 첨부
		}
		return list;
	}
	// 총페이지 
	public int boardTotalPage() {
		int total=0;
		try {
			getConnection();
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM jspboard";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
		return total;
	}
	// 데이터 추가 
	public void boardInsert(BoardVO vo) {
		try {
			getConnection();
			String sql="INSERT INTO jspboard(name, subject, content, pwd) "
					+"VALUES(?,?,?,?)";
			// no => auto_increment
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getSubject());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getPwd());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
	}
	// DAO => Detail
	public BoardVO boardDetailData(int no) {
		BoardVO vo=new BoardVO();
		try {
			getConnection();
			String sql="UPDATE jspboard SET "
						+"hit=hit+1 "
						+"WHERE no=?";
		ps=conn.prepareStatement(sql);
		ps.setInt(1, no);
		ps.executeUpdate();
		// 조회수 증가
		sql="SELECT no, name, subject, content, hit, TO_CHAR(regdate,'yyyy-MM-dd hh24:mi:ss') "
				+ "FROM jspboard "
				+ "WHERE no=?";
		ps=conn.prepareStatement(sql);
		ps.setInt(1, no);
		ResultSet rs=ps.executeQuery();
		rs.next();
		vo.setNo(rs.getInt(1));
		vo.setName(rs.getString(2));
		vo.setSubject(rs.getString(3));
		vo.setContent(rs.getString(4));
		vo.setHit(rs.getInt(5));
		vo.setDbday(rs.getString(6));
		rs.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			disConnection();
		} 
		return vo;
		
	}
}
