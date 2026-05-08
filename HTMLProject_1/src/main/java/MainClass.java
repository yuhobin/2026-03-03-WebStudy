
import java.util.*;
import java.sql.*;
public class MainClass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url="jdbc:oracle:thin:@localhost:1521:XE";
			Connection conn=DriverManager.getConnection(url,"hr","happy");
			String sql="SELECT empno,ename,job,to_CHAR(hiredate,'yyyy-MM-dd'),sal "
					+"FROM emp2 "
					+"ORDER BY empno ASC";
			PreparedStatement ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				System.out.println("<tr>");
				System.out.println("<td>"+rs.getInt(1)+"</td>");
				System.out.println("<td>"+rs.getString(2)+"</td>");
				System.out.println("<td>"+rs.getString(3)+"</td>");
				System.out.println("<td>"+rs.getString(4)+"</td>");
				System.out.println("<td>"+rs.getString(5)+"</td>");
				System.out.println("</tr>");
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
