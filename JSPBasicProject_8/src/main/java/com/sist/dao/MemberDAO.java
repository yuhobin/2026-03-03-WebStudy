package com.sist.dao;

import java.util.*;
import java.util.Date;
import java.sql.*;
//////////////////////DBCP용 => 라이브러리 
/*
 * 	MyBatis
 * 		1. XML기반
 * 		   ------ XML을 수업 => XML 파싱 => Spring 구조
 * 		2. Annotation 기반 => Sping
 * 	Jquery
 * 		1. 데이터 읽기 => JSON
 * 	------------------------------------------
 * 	크롤링 => 오라클 저장 => 데이터베이스 설계 => 요구사항 분석 / 정규화
 * 		JSoup / 셀레니움 / PlayWeight
 * 		----- 			---------- 
 * 	=> Vue / React / Ajax => 크롤링이 불가능
 * 	=> data.go.kr / seoul => 이미지가 부족
 * 	------------------------------------ 1차 프로젝트 준비
 * 
 * 	기초 
 * 		자바 / 오라클 / HTML / CSS / JavaScript / JSP
 * 		나머지는 => 라이브러리 => 활용 => 실제 사이트 구축
 */
import javax.sql.*;

import com.sist.vo.MemberVO;

import javax.naming.*;
/*
 * 	SpringFramework : JSP + MVC
 * 	-------------------------- 지원하지 않는다 (유지보수)
 * 	Spring-Boot + TymeLeaf + Vue(Pinia) + MyBatis
 * 	--------------------------------------------- + CI/CD
 * 	SpringBoot + NodeJS + React + JPA + MySQL => 개인
 * 
 * 	=> 처음부터 끝까지 (X)
 * 	=> 다음에 나올때 또 공부하면 됨 누적(O)
 */

public class MemberDAO {
	/*
	 *  DBCP : 데이터베이스 연결 시에 가장 시간이 걸린다
	 *  	  -------------------------------
	 *  		연결 : 연결시간 줄이기 위해서 미리 연결한 상태  (속도가 빠르게)
	 *  		=> 몇개 저장 ? maxActive / maxId
	 *  		=> MyBatis = 설정 => default : 8, 8
	 * 	사용법 : 1) server.xml에 등록 => 톰캣이 실행
	 * 			  ----------- <Resource name="jdbc/oracle">
	 * 	=> 1. 저장된 Connection 주소 읽기
	 * 		  ----------------------
	 * 			= JDNI => 가상으로 탐색기 형식으로 
	 * 			  java://comp/env ==> C드라이브 => Connection 주소 저장 
	 * 											-----------
	 * 											이름 : jdbc / oracle 
	 * 		2. Connection 주소 대입
	 * 			conn=ds.getConnection()
	 * 	=> getConnection() / disConnection()
	 * 		주소 읽기				반환 => 재사용이 가능
	 * 
	 */
	private Connection conn;
	private PreparedStatement ps;
	private static MemberDAO dao; // 싱글턴
	// => 보안이 좋다
	public void getConnection() {
		try {
				// 연결 => Pool 연결
				Context init=new InitialContext();
				Context c=(Context)init.lookup("java:comp/env");
				DataSource ds=(DataSource)c.lookup("jdbc/oracle");
				// connection 정보 읽기
				conn=ds.getConnection();
			String sql="SELECT ";
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void disConnrction() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
			// 닫는것이 아니라 => Pool안으로 반환 => 재사용이 가능
			// Pool => Connection 객체 저장 메모리 공간
			// Connection 개수를 제어할 수 있다
			// 많이 생성이 되면 서버부하가 있다
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static MemberDAO newInstance() {
		if(dao==null)
			dao=new MemberDAO();
		return dao;
	}
	///////////// 기본 설정
	// 기능 설정
	public MemberVO memberLogin(String id, String pwd) {
		MemberVO vo=new MemberVO();
		try {
			// 1. Connection 주소값 읽기
			getConnection();
			// 2. SQL 제작
			String sql="SELECT COUNT(*) FROM member "
						+"WHERE id=?";
			// 3. SQL문장을 오라클로 전송
			ps=conn.prepareStatement(sql);
			// 4. ?가 있는 경우에 값을 채운다 => SQL Injection
			ps.setString(1, id); // ?는 앞에서부터 1 2 3 ...
			// 5. 결과값 받기
			ResultSet rs=ps.executeQuery();
			rs.next();
			int count=rs.getInt(1);
			rs.close();
			////////////////// ID 존재여부 확인 
			if(count==0) {
				vo.setMsg("NOID");	 // ID가 없는 경우
			}
			else {	// ID가 있는 경우
				sql="SELECT id, name, pwd, isadmin, post, addr1, addr2, phone "
					+"FROM member "
					+"WHERE id=?";
				ps=conn.prepareStatement(sql);
				ps.setString(1, id);
				rs=ps.executeQuery();
				rs.next();
				String db_id=rs.getString(1);
				String name=rs.getString(2);
				String db_pwd=rs.getString(3);
				String isadmin=rs.getString(4);
				String post=rs.getString(5);
				String Addr1=rs.getString(6);
				String Addr2=rs.getString(7);
				String phone=rs.getString(8);
				// 로그인 시에 Session에 하는 사용자의 정보를 가지고 온다
				// 배송지에 문제 
				if(pwd.equals(db_pwd)) { // 로그인
					vo.setId(db_id);
					vo.setIsadmin(isadmin);
					vo.setName(name);
					vo.setPhone(phone);
					vo.setAddr1(Addr1);
					vo.setAddr2(Addr2);
					vo.setPost(post);
					vo.setMsg("OK");
				} 
				else {	// 비밀번호가 틀린 경우
						vo.setMsg("NOPWD");
				}
				rs.close();
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			disConnrction();
		}
		return vo;
	}
}
