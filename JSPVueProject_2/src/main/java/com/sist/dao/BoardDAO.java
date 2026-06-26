package com.sist.dao;
import java.util.*;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.*;
import com.sist.vo.*;
public class BoardDAO {
	private static SqlSessionFactory ssf;
	static {
		try {
			Reader reader=Resources.getResourceAsReader("Config.xml");
			ssf=new SqlSessionFactoryBuilder().build(reader);
			// xml => 파싱 (프레임워크 => XML을 제공 => 파싱)
			// XML / 크롤링
			// => 읽어가는 방법 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/*
	 * <select id="boardListData" resultType="BoardVO" parameterType="int">
		SELECT no, subject, name, TO_CHAR(regdate,'yyyy-MM-dd') as dbday, hit
		FROM jspboard
		ORDER BY no DESC
		OFFSET #{start} ROWS FETCH NEXT 12 ROWS ONLY
	</select>
	*/
	public static List<BoardVO> boardListData(int start) {
		SqlSession session=ssf.openSession();
		List<BoardVO> list=session.selectList("boardListData",start);
		session.close();
		return list;
	}
	/*
	<select id="boardRowCount" resultType="int">
		SELECT COUNT(*) FROM jspboard
	</select>
	 */
	public static int boardRowCount() {
		SqlSession session=ssf.openSession();
		int count=session.selectOne("boardRowCount");
		session.close();
		return count;
	}
	/*
	 * <insert id="boardInsert" parameterType="BoardVO">
			<!--  sequence : 자동 증가 번호 
				#{} = setString() => ''
				${} = 일반문자열 => ''(X) = column/table
			-->
			<selectKey keyProperty="no" resultType="int" order="BEFORE">
				SELECT NVL(MAX(no)+1,1) as no FROM jspboard
			</selectKey>
			INSERT INTO jspboard VALUES(
				#{no},
				#{name},
				#{subject},
				#{content},
				#{pwd},
				SYSDATE,
				0
			)
		</insert>
	 */
	public static void boardInsert(BoardVO vo) {
		SqlSession session=ssf.openSession(true); // commit
		session.insert("boardInsert",vo);
		session.close();
		
	}
	/*
	 *  <update id="hitIncrement" parameterType="int">
		 	UPDATE jspboard SET
		 	hit=hit+1
		 	<include refid="where-no"/>
		 </update>
		 <select id="boardDetailData" resultType="BoardVO" parameterType="int">
		 	SELECT no, name, subject, content, hit, TO_CHAR(regdate,'yyyy-MM-dd hh24:mi:ss') as dbday
		 	FROM jspboard
		 	<include refid="where-no"/>
		 </select>
	 */
	public static BoardVO boardDetailData(int no) {
		SqlSession session=ssf.openSession(true);
		session.update("hitIncrement",no);
		BoardVO vo= session.selectOne("boardDetailData",no);
		session.close();
		return vo;
	}
	/*
	 *  <!-- 삭제하는 부분 -->
	 <select id="boardGetPassword" resultType="string" parameterType="int">
	 	SELECT pwd
	 	FROM jspboard
	 	WHERE no=#{no}
	 </select>
	 <delete id="boardDelete" parameterType="int">
	 	DELETE FROM jspboard
	 	WHERE no=#{no}
	 </delete>
	 */
	public static boolean boardDelete(int no, String pwd) {
		boolean bCheck=false;
		// autocommit => 해제 => 트랜잭션
		SqlSession session=ssf.openSession(true);
		// 								  delete / insert / update
		String db_pwd=session.selectOne("boardGetPassword",no);
		if(db_pwd.equals(pwd)) {
			bCheck=true;
			session.delete("boardDelete",no);
			session.commit();
		}
		session.close();
		return bCheck;
	}
	/*
	 * 	Primary : 중복 없다
	 * 		=> <태그 id="">
	 * 				------ MyBatis / Spring (클래스 찾기)
	 * 								 => 클래스 관리자 
	 * 		=> 어노테이션
	 */
	// 수정
	public static BoardVO boardUpdateData(int no) {
		// MyBatis 연결 => Connection 
		SqlSession session=ssf.openSession();
		BoardVO vo=session.selectOne("boardDetailData", no);
		session.close();
		return vo;
	}
	
	/*
	 *  <update id="boardUpdate" parameterType="BoardVO">
		  	UPDATE jspboard SET
		  	name=#{name}, subject=#{subject}, content=#{content}
		  	WHERE no=#{no}
		  </update>
	 */
	// mapper에 있는 SQL 문장은 한번 사용하는 것이 아니다 (필요시에 계속 호출이 가능)
	public static boolean boardUpdate(BoardVO vo) {
		boolean bCheck=false;
		// autocommit => 해제 => 트랜잭션
		SqlSession session=ssf.openSession(true);
		// 								  delete / insert / update
		String db_pwd=session.selectOne("boardGetPassword",vo.getNo());
		if(db_pwd.equals(vo.getPwd())) {
			bCheck=true;
			session.delete("boardUpdate",vo);
			//session.commit();
		}
		session.close();
		return bCheck;
	}
}
