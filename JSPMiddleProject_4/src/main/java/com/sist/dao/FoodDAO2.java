package com.sist.dao;

import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class FoodDAO2 {
	private Connection conn;
	private PreparedStatement ps;
	private static FoodDAO2 dao2;
	
	// 1. 연결 
	public void getConnection() {
		try {
			Context init=new InitialContext();
			// JNDI => directory =>  탐색기 => 탐색기 열기 
			Context c=(Context)init.lookup("java://comp/env");
			// c드라이버
			DataSource ds=(DataSource)c.lookup("jdbc/oracle");
			conn=ds.getConnection(); // 미리 생성된 Connection 주소를 불러온다
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 2. 사용 후 반환 
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 3. 기능
	public List<FoodVO2> foodListData2(int page) {
		List<FoodVO2> list=new ArrayList<FoodVO2>();
		try {
			getConnection();
			String sql="SELECT no, name, phone, address, poster "
						+"FROM food "
						+"ORDER BY no ASC "
						+"OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, (page*12)-12);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				FoodVO2 vo=new FoodVO2();
				vo.setNo(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setPhone(rs.getString(3));
				vo.setAddress(rs.getString(4));
				vo.setPoster(rs.getString(5));
				
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
		return list;
	}
	// 3-1-1 총페이지 
	public int foodTotalPage2() {
		int total=0;
		try {
			getConnection();
			String sql="SELECT CEIL(COUNT(*)/12.0) FROM food";
			//여기서부터 작성
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
}
