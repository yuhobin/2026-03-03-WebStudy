package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
import com.sist.commons.*;
public class BoardDAO {
	private static BoardDAO dao; 
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	public static BoardDAO newInstance() {
		if(dao==null)
			dao=new BoardDAO();
		return dao;
	}
	/*
	 *  <select id="boardListData" resultType="BoardVO" parameterType="int">
			SELECT no, subject, name, TO_CHAR(regdate,'yyyy-MM-dd') as dbday, hit
			FROM freeboard 
			ORDER BY no DESC 
			OFFSET #{start} ROWS FETCH NEXT 10 ROWS ONLY
		</select>
		*/
	public static List<BoardVO> boardListData(int start) {
		SqlSession session=ssf.openSession();
		List<BoardVO> list=session.selectList("boardListData", start);
		session.close();
		return list;
	}
	/*
		<select id="boardTotalPage" resultType="int">
			SELECT CEIL(COUNT(*)/10.0)
			FROM freeboard
		</select>
		*/
	public static int boardTotalPage() {
		SqlSession session=ssf.openSession();
		int total=session.selectOne("boardTotalPage");
		session.close();
		return total;
	}
	/*
		<insert id="boardInsert" parameterType="BoardVO">
			INSERT INTO freeboard(no, name, subject, content, pwd)
			VALUES(
				fb_no_seq.nextval,
				#{name}, #{subject}, #{content}, #{pwd}
			)
		</insert>
	 */
	// 모든 mapper / 모든 @RequestMapping  => Ajax / Vue
	// 중복이 되면 안된다 (id)
	public static void boardInsert(BoardVO vo) {
		SqlSession session=ssf.openSession(true);
		session.insert("boardInsert",vo);
		session.close();
	}
	// 수정하기
	// 삭제하기
	// 상세보기
	/*
	 *  <update id="boardHitIncrement" parameterType="int">
			UPDATE freeboard SET
			hit=hit+1
			WHERE no=#{no}
		</update>
		<!-- 
			1. 회원가입 (로그인)
			2. 게시판 : CRUD
			3. 공지사항 : 관리자 / 일반 사용자
			4. HttpSession / Cookie
							  | 최신 방문 / 장바구니 / 자동로그인 (Spring => remember-me 사용)
		 -->
		<select id="boardDetailData" resultType="BoardVO" parameterType="int">
			SELECT no, name, subject, content, hit, TO_CHAR(regdate,'yyyy-MM-dd hh24:mi:ss') as dbday
			FROM freeboard
			WHERE no=#{no}
		</select>
	 */
	public static BoardVO boardDetailData(int no) {
		SqlSession session=ssf.openSession(true);
		session.update("boardHitIncrement",no);
		BoardVO vo=session.selectOne("boardDetailData", no);
		session.close();
		return vo;
	}
	// 현재 코딩 순서 흐름 JSP => Mapper => DAO => Model => JSP
	/*
	 * <select id="boardGetPassword" resultType="string" parameterType="int">
			SELECT pwd
			FROM freeboard
			WHERE no=#{no}
		</select>
		<delete id="boardDelete" parameterType="int">
			DELETE FROM freeboard
			WHERE no=#{no}
		</delete>
	 */
	public static String boardDelete(int no, String pwd) {
		String result="no";
		SqlSession session=ssf.openSession();
		String db_pwd=session.selectOne("boardGetPassword", no);
		if(db_pwd.equals(pwd)) {
			session.delete("boardDelete",no);
			session.commit();
			result="yes";
		}
		session.close();
		return result;
	}
	/*
	 * <update id="boardUpdate">
			UPDATE freeboard SET (no, name, subject, content, pwd)
			#{no},#{name},#{subject},#{content},#{pwd}
			WHERE no=#{no} 
		</update>
	 */
	public static BoardVO  boardUpdate(int no) {
		
		SqlSession session=ssf.openSession(true);
		BoardVO vo=session.selectOne("boardUpdate", no);
		session.close();
		return vo;
		/*
		String result="no";
		SqlSession session=ssf.openSession();
		String db_pwd=session.selectOne("boardGetPassword", no);
		if(db_pwd.equals(pwd)) {
			session.delete("boardUpdate",no);
			session.commit();
			result="yes";
		}
		session.close();
		return result; */
		/*
		SqlSession session=ssf.openSession();
		session.update("boardUpdate");
		session.close(); */
	
	}
	
}
