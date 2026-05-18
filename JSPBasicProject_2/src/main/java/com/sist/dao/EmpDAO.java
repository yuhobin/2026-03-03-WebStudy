package com.sist.dao;
// JOIN  : 상세보기, 장바구니, 회원 관리, 댓글
// 구매, 예약
import java.util.*;
import java.util.Date;
import java.nio.file.attribute.AclEntry;
import java.sql.*;
public class EmpDAO {
	// 필요한 객체 => 전체적으로 사용
	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	// 드라이버 등록
	public EmpDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 오라클 연동
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
		} catch (Exception e) {
		e.printStackTrace();
		}
	}
	public void disConnection() {
		try {
			if(conn!=null) conn.close();
			if(ps!=null) ps.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/////////////////////공통 기반 => MyBatis / JPA에선 사용하지 않는다
	public List<EmpVO> empListData(int page){
	    List<EmpVO> list = new ArrayList<EmpVO>();
	    try {
	        getConnection();
	        
	        // 1. SQL 수정: 오타 해결 및 조인 컬럼 명시
	        // hiredate 오타 수정, emp.deptno로 수정
	        String sql = "SELECT empno, emp.deptno, ename, job, TO_CHAR(hiredate,'yyyy-MM-dd'), sal, dname, loc "
	                    + "FROM emp JOIN dept "
	                    + "ON emp.deptno = dept.deptno";
	        
	        ps = conn.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	        
	        while(rs.next()) {
	            EmpVO vo = new EmpVO();
	            // SELECT 절의 순서와 rs.getXXX(순서)가 일치해야 합니다.
	            vo.setEmpno(rs.getInt(1));
	            vo.setDeptno(rs.getInt(2));
	            vo.setEname(rs.getString(3));
	            vo.setJob(rs.getString(4));
	            vo.setDbday(rs.getString(5)); // TO_CHAR 결과값
	            vo.setSal(rs.getInt(6));
	            
	            // DeptVO 객체에 데이터 담기 (이미 EmpVO에서 new DeptVO()가 되어 있으므로 바로 사용)
	            vo.getDvo().setDname(rs.getString(7)); 
	            vo.getDvo().setLoc(rs.getString(8));
	            
	            list.add(vo);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        disConnection();
	    }
	    return list;
	}
	
	
}
