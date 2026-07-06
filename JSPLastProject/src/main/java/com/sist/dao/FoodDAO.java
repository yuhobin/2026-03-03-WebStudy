package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.*;
public class FoodDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	/*
	 * <select id="foodListData" resultType="FoodVO" parameterType="int">
		SELECT no, name, poster, type, phone, likecount, replycount
		FROM food2
		ORDER BY ASC
		OFFSET #{start} ROWS FETCH NEXT 12 ROWS ONLY
	</select>
	*/
	public static List<FoodVO> foodListData(int start) {
		SqlSession session=ssf.openSession();
		List<FoodVO> list=session.selectList("foodListData", start);
		session.close();
		return list;
	}
	/*
	<select id="foodTotalPage" resultType="int">
		SELECT CEIL(COUNT(*)/12.0)
		FROM food2
	</select>
	 */
	public static int foodTotalPage() {
		SqlSession session=ssf.openSession();
		int total=session.selectOne("foodTotalPage");
		session.close();
		return total;
	}
}
