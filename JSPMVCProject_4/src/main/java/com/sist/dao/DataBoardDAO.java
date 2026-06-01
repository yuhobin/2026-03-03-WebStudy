package com.sist.dao;
/*
 * 	데이터베이스 연동 
 * 	JDBC ======> DBCP =======> ORM 
 * 								데이터베이스 처리하는 라이브러리 집합
 * 								MyBatis / JPA (개인 프로젝트)
 * 								| = XML 이용하는 방식 : JSP 사이트
 * 								| = Annotation 방식 : Spring-Boot
 * 	1) MyBatis(3버전) => IBatis (2버전) : OpenSource 그룹
 * 		| Google에서 인수
 * 		SQL을 작성 => MyBatis로 전송 
 * 					| 자동으로 처리 (연결 / 전송 / 실행 / 결과값 닫기)
 * 			| => 설정 => XML
 * 			  => 1) SQL문장 작성 / 2) VO 설정 / 3) ?에 값 채우기 
 * 			  => 반복적인 구조를 없앤다
 * 	2) 동작 구조 
 * 		= Config.xml => Connection => 한개만 설정
 * 		= mapper.xml => PreparedStatement / ResultSet => 테이블 당 1개 생성
 * 		1. Config.xml을 이용해서 => getConnection() / disConnection()
 * 		2. mapper을 읽어서 JDBC를 이용해서 처리 
 * 		
 * 	3) 장점
 * 		SQL 문장을 직접 제어 => 개발자 
 * 		성능 최적화 => 튜닝
 * 		복잡한 SQL 문장 제어 
 * 	4) 단점 
 * 		SQL문장을 직접 제어 => JPA에서는 SQL문장을 자동화
 * 		DB변경 시 수정 
 * 		객체 지향 ORM이 약하다 
 * 	-----------------------------------------
 * 	SQL문장은 동일 / 동적 쿼리 (다중 검색) / #{} / ${}
 * 								    ----  ----
 * 										   | '' 없이 처리 => table명, column명
 * 									| ?에 값을 채운다 => ''
 * 	=> resultType : 결과값 담기 (ResultSet)
 * 	=> parameterType : ?에 값이 들어온다
 * 		=> 1. ? 여러개인 경우 => VO
 * 		=> 2. VO에 없는 변수 여러개 => Map
 * 	=> SqlSessionFactory : SqlSession 생성 / XML 파싱
 * 	=> SqlSession : PreparedStatement / ResultSet 담당
 * 	   -----------conn.preparedStatement()
 * 				  ps.executeQuery()
 */
import java.util.*;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.sist.vo.DataBoardVO;

import java.io.*;
public class DataBoardDAO {
	// 1. XMl 파싱
	private static SqlSessionFactory ssf;
	static {
		try {
			Reader reader=Resources.getResourceAsReader("Config.xml");
			// classpath영역에 파일 저장 => 경로명 없이 파일명만 저장 
			// src/main/java => Spring에서도 자동인식
			ssf=new SqlSessionFactoryBuilder().build(reader);
			/*
			 * 	map.put("id","sql")
			 * 	map1.put("id",resultType)
			 * 	map2.put("id",parameterType)
			 */
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 2. 기능
	public static List<DataBoardVO> databoardListData(int start) {
		List<DataBoardVO> list=new ArrayList<DataBoardVO>();
		SqlSession session=null; // conn 생성
		try {
			session=ssf.openSession();
			list=session.selectList("databoardListData",start);
		} catch (Exception e) {
			
		}
		finally {
			if(session!=null)
				session.close(); // 반환
		}
		return list;
	}
	public static int databoardTotalPage() {
		int total=0;
		SqlSession session=null; // conn 생성
		try {
			session=ssf.openSession();
			total=session.selectOne("databoardTotalPage");
		} catch (Exception e) {
			
		}
		finally {
			if(session!=null)
				session.close(); // 반환
		}
		return total;
	}
	/*
	public static int databoardTotalPage2() {
		int total=0;
		SqlSession session=ssf.openSession();
		total=session.selectOne("databoardTotalPage");
		session.close(); // 반환
		
		return total;
	}
	*/
	// 데이터 추가
	/*
	 * 	<insert id="databoardInsert" parameterType="DataBoardVO">
	       INSERT INTO mvcDataBoard VALUES(
	       	mdb_no_seq.nextval,
	       	#{name},
	       	#{subject},
	       	#{content},
	       	#{pwd},
	       	SYSDATE,
	       	0,
	       	#{filename},
	       	#{filesize}
	       )
	     </insert>
	     
	     // 1. 파일명 중복
	     // 2. 여러개 동시에 올리는 방법
	     // 3. 보완
	 */
	public static void databoardInsert(DataBoardVO vo) {
		// ssf.openSession() => conn.setAutomit(false)
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.insert("databoardInsert",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if(session!=null)
				session.close();
		}
		
		
	}
	/*
	 * <update id="hitIncrement" parameterType="int">
	      	UPDATE mvcDataBoard SET
	      	hit=hit+1
	      	<include refid="where-no"/>
	      </update>
	      <!-- 
	      	실제 데이터 읽기
	       -->
	       <select id="databoardDetailData" parameterType="int"
	       resultType="DataBoardVO"
	       >
		       SELECT no, name, subject, content, hit,
		       		TO_CHAR(redgate,"YYYY-MM-DD") as dbday,
		       		filesize, filename
		       FROM mvcDataBoard
		       <include refid="where-no"/>
	       </select>
	       
	       상세보기
	       
	       => selectOne() => 1 ROW => 상세보기, 총페이지 ...
	       => selectList() => 다중 ROW : 목록 / 검색
	       => insert(), update(), delete()
	 */
	public static DataBoardVO databoardDetailData(int no) {
		DataBoardVO vo=new DataBoardVO();
		SqlSession session=null; // PreparedStatement / ResultSet
		try {
			session=ssf.openSession();
			// 조회수 증가
			session.update("hitIncrement",no);
			session.commit();
			vo=session.selectOne("databoardDetailData",no);
			// 자동 형변환 => 제네릭을 이용한 형변환
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if(session!=null)
				session.close(); // 반환
		}
		
		return vo;
	}
}
