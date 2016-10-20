package common;

import java.sql.*;

public class DBconn {
	public static Connection conn(){
	String URL="jdbc:mysql://localhost:3306/hospital";
	String USER="root";
	String PASS="jspbook";

	Connection conn=null;
	// PreparedStatement stmt=null;
	// ResultSet rs=null;

	 try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL,USER,PASS);
			//stmt = conn.createStatement();
			//rs = stmt.executeQuery("select * from "+mode);
	 } catch(Exception e){
		 e.printStackTrace();
	 }
	return conn;
}}