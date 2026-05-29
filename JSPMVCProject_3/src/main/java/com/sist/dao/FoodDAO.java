package com.sist.dao;

import java.util.*;
import java.util.concurrent.ThreadPoolExecutor.DiscardOldestPolicy;
import java.sql.*;
import com.sist.commons.*;

public class FoodDAO {
	private Connection conn;
	private PreparedStatement ps;
	private DBCPUtil db=new DBCPUtil();
	
	// 기능
	public List<FoodVO> foodListData(int page) {
		List<FoodVO> list=new ArrayList<FoodVO>();
		try {
			conn=db.getConnection();
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
			e.printStackTrace();
		}
		finally {
			db.disConnection(conn, ps);
		}
		return list;
	}
}
