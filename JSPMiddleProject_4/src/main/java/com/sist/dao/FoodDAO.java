package com.sist.dao;
/*
 * 	1. FoodVO
 * 	2. FoodDAO
 * 	3. JSP
 * 	--------------Model / Controller
 * 
 * 	1. JSP ===> MV구조 ===> MVC구조 ===> SpringFrameWork
 * 										| 설정파일 복잡
 * 										| --------- 단순화 => Spring-Boot
 * 	2. JDBC ===> DBCP ===> MyBatis ===> JPA
 * 	3. Oracle ===> MySQL ===> MariaDB
 * 								| AWS에 서치 => Docker
 *  ----------------------------------------------------
 *  4. Git Action ===> Docker ===> Docker-compose ===> 쿠바네틱스 ===> Jenkins
 *  														   | nginx / ngrook(도메인) 
 *  5. javaScript(바닐라JS) ===> JQuery(3,4)
 *  							| Ajax
 *  						   VueJS
 *  							| vuex, pinia
 *  						   ReactJS
 *  							| tanstack-Query
 *  							  nodeJS / typeScript
 *  							| redux
 *  6. Spring AI
 *  
 *  JDBC : 시간이 오래 걸린다 / 보안이 취약하다 
 *  DBCP : JDBC의 단점을 보완 
 *  ----------------------- 기반 => MyBatis => iBatis (google 인수)
 *  							  -------- 초창기 iBatis (오픈소스 그룹)
 *  								= XML
 *  								= Annotation => Spring 
 *   | DBCP 단점 : 웹에서만 사용이 가능 
 *  
 */
import java.util.*;
import java.sql.*;

//import com.sist.dao.*;

import javax.sql.*; // DataSource => 데이터베이스의 정보를 가지고 있다
import javax.naming.*; // Context => 저장 메모리 관리

/*
 * 	1. Pool안에 여러개의 Connection을 저장 (Pool => 저장 메모리 공간)
 * 		maxActive / maxIdle
 * 					 | Pool안에 존재하는 Connection 개수
 * 		 | 접근자의 최대 Connection
 * 	2. 사용자 요청시에 => Pool에서 Connection을 가지고 온다
 * 	3. Connection => 오라클 접근
 * 	4. PreparedStatement => SQL문장 수행
 * 	5. Connection 객체를 => Pool안으로 반환 (재사용)
 */

public class FoodDAO {
	private Connection conn;
	private PreparedStatement ps;
	private static FoodDAO dao;
	
	// 1. 미리 연결되어 있는 Connection의 주소를 얻어온다
	public void getConnection() {
		try {
			// 저장된 메모리 주소를 가지고 온다
			Context init=new InitialContext(); 
			//JNDI => directory => 탐색기  => 탐색기 열기 
			Context c=(Context)init.lookup("java://comp/env");
			// c드라이버
			DataSource ds=(DataSource)c.lookup("jdbc/oracle");
			// 파일 찾기 : jdbc/oracle
			conn=ds.getConnection(); // 미리 생성된 Connection 주소를 읽어온다
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	// 2. 사용 후에 반환
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
			// tomcat에서 지원하는 라이브러리 사용 => tomcat-dbcp.jar
			// conn.close() => Pool안의 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 3. 기능
	// 3-1. 목록
	public List<FoodVO> foodListData(int page) {
		List<FoodVO> list=new ArrayList<FoodVO>();
		try {
			getConnection();
			String sql="SELECT no, poster, name, address "
					+"FROM food "
					+"ORDER BY no ASC "
					+"OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, (page*12)-12);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				FoodVO vo=new FoodVO();
				vo.setNo(rs.getInt(1));
				vo.setPoster(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setAddress(rs.getString(4));
				
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			// 오류 처리
			e.printStackTrace();
		}
		finally {
			disConnection();
			// 반환
		}
		return list;
	}
	// 3-1-1. 총페이지
	public int foodTotalPage() {
		int total=0;
		try {
			getConnection();
			String sql="SELECT CEIL(COUNT(*)/12.0) FROM food";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
			
		} catch (Exception e) {
			// 오류 처리
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
		return total;
	}
	// 3-2. 상세보기
	
}
