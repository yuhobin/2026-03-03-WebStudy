package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
import com.sist.commons.*;

public class RecommandDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	/*
	 * <select id="foodGetType" resultType="string" parameterType="string">
			SELECT type FROM food2
			WHERE no=(SELECT no 
						FROM ( SELECT no, count(*) as review_cnt
								 FROM foodReview
				 				WHERE id=#{id}
				 				GROUP BY no
								 ORDER BY review_cnt DESC)
						WHERE rownum=1);
		</select>
		*/
	
	/*
		<select id="memberGetAddress" resultType="string" parameterType="string">
			SELECT addr1 FROM member
			WHERE id=#{id}
		</select>
		*/
	/*
		<select id="foodRecommandData" resultType="FoodVO" parameterType="hashmap">
			SELECT * 
			FROM (SELECT * FROM food2
			   	 WHERE type LIKE '%'||#{type}||'%' AND address LIKE '%'||#{address}||'%'
			     ORDER BY score DESC)
			WHERE rownum&lt;=5;
		</select>	 
	 */
	public static List<FoodVO> foodRecommandData(String id) {
		SqlSession session=ssf.openSession();
		String type=session.selectOne("foodGetType",id);
		String address=session.selectOne("memberGetAddress",id);
		String[] addrs=address.split("");
		Map map=new HashMap();
		map.put("type", type);
		map.put("address", addrs[1]); // 구 가져오기
		List<FoodVO> list=session.selectList("foodRecommandData", map);
		session.close();
		return list;
	}
}
