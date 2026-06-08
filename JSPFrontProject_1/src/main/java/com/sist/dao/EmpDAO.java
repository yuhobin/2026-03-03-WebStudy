package com.sist.dao;
import java.io.*;
import java.util.*;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
/*
 * 	MyBatis
 * 		= CRUD
 * 			<select> <update> <insert> <delete>
 * 										 | delete()
 * 								| insert()
 * 						| update()
 * 				| = List selectList()
 * 				| = List selectOne()
 * 		= JOIN / SubQuery() => <resultMap>
 * 		= 동적 쿼리
 * 			<if> <forEach> <where> <choose> <trim> : 다중 검색
 * 		= Annotation 사용
 * 		= MyBatis 단점
 * 			SQL문장을 한개만 처리 
 * 			=> 여러개 처리
 * 				<select> : Procedure형식 => 회원 탈퇴
 * 					BEGIN
 * 					{
 * 					}
 * 					END
 * 					</select>
 * 
 */
// 	내 개인 흐름 이해 필기
// 	기존에 DAO 역할 : DB연결이 핵심 
//	현재 DAO : MyBatis생기고 난 후 DB연결은 전적으로 MyBatis에 일임. XML 파싱을 하고 난 후 
public class EmpDAO {
	private static SqlSessionFactory ssf;
	static {
		try {
			// XML 파싱
			Reader reader=Resources.getResourceAsReader("Config.xml");
			// mapper.xml이 포함
			ssf=new SqlSessionFactoryBuilder().build(reader);
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	// 기능
	/*
	 * <select id="empListData" resultMap="empMap">
			SELECT empno, ename, job, TO_CHAR(hiredate,'yyyy-MM-dd') as dbday, sal, dname, loc
			FROM emp, dept
			WHERE emp.deptno=dept.deptno
			ORDER BY empno ASC
		</select>
	 */
	public static List<EmpVO> empListData() {
		List<EmpVO> list=new ArrayList<EmpVO>();
		// 연결 => Connectiona 주소 읽기
		SqlSession session=null;
		try {
			session=ssf.openSession();
			list=session.selectList("empListData");
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if(session!=null)
				session.close(); // POOL 반환
		}
		return list;
	}
}
