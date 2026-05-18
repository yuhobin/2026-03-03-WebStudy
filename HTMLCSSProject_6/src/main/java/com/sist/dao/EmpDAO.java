package com.sist.dao;
import java.util.*;
import java.util.Date;
import java.sql.*;

public class EmpDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	public EmpDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 1. 연결
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 2. 해제
	public void disConnection() {
		try {
			if(conn!=null) conn.close();
			if(ps!=null) ps.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//1. 목록
	public List<EmpVO> EmpListData(int page) {
		List<EmpVO> list=new ArrayList<EmpVO>();
		try {
			getConnection();
			/*
			 * private int empno, deptno;
				private double sal;
				private String ename, job, isadmin;
				private Date hiredate;
}
			 */
			String sql="SELECT empno, deptno, sal, ename, job, TO_CHAR(hiredate,'yyyy-MM-dd') "
						+"FROM emp2 "
						+"ORDER BY empno ASC "
						+"OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, (page*10)-10);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				EmpVO vo=new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setDeptno(rs.getInt(2));
				vo.setSal(rs.getDouble(3));
				vo.setEname(rs.getString(4));
				vo.setJob(rs.getString(5));
				vo.setDbday(rs.getString(6));
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
	//1-1 총페이지
	public int EmpRowCount() {
		int count=0;
		try {
			getConnection();
			String sql="SELECT COUNT(*) FROM Emp2";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			count=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
		return count;
	}
	//1-2 총페이지 계산
	public int EmpTotalPage() {
	    int total = 0;
	    try {
	        // 이미 만들어두신 EmpRowCount()를 활용합니다.
	        int count = EmpRowCount(); 
	        
	        // 전체 페이지 수 계산 (한 페이지당 10개씩)
	        // 예: 101개면 11페이지가 나와야 하므로 올림 처리가 필요합니다.
	        total = (int)(Math.ceil(count / 10.0));
	        
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return total;
	}
}
