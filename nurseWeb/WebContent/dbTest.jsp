<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %> <! sql�̿��� ���� Import !>

<%
String URL="jdbc:mysql://localhost:3306/hospital";
String USER="root";
String PASS="jspbook";

Connection conn=null;
Statement stmt=null;
ResultSet rs=null;


try
{
	Class.forName("com.mysql.jdbc.Driver");
	
	conn = DriverManager.getConnection(URL,USER,PASS);
	
	stmt = conn.createStatement();
	
	rs = stmt.executeQuery("select * from patient");
	
	while( rs.next())
	{
	  int Number = rs.getInt("Number");
	  String sapNum = rs.getString("sapNum");
	  
	  out.println("�Ϸù�ȣ"+Number+"���Ŵ� ���� ��ȣ"+sapNum);
%>
<br>
<%	  
	}
	
}
	catch(SQLException e)
	{
		out.println(e.getMessage());
	}	
	finally
	{
		if(rs != null) try{rs.close();}catch(SQLException ex){}
		if(stmt != null) try{ stmt.close();}catch(SQLException ex){}
		if(conn != null)try{conn.close();}catch(SQLException ex){}
	}
	
	

%>
