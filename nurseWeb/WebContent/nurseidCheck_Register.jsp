<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="common.DBconn" %>
<%@ page import="java.lang.String.*" %>
<html>
<body>
<%

		try{
			
	        request.setCharacterEncoding("UTF-8");
	  		String nurseid= (String)request.getParameter("nurseid");
	 
			String nursepw = (String)request.getParameter("password");
			String nurseName = (String)request.getParameter("name");
			String nursePhoneNum = (String)request.getParameter("phoneNumber");
			
			System.out.println(nurseid);
			
			Connection conn=null;
			Statement stmt=null;
			ResultSet rs = null;
			ResultSet rs1 = null;
			boolean a = true;
			
			conn = DBconn.conn();
			stmt=conn.createStatement();
			rs = stmt.executeQuery("SELECT COUNT(*) AS 'idCount' FROM hospital.nurse WHERE id='"+nurseid+"';");
			while(rs.next()){
				if(rs.getInt("idCount")!= 0){
					a=false;
%>						
					<script type="text/javascript">
		              alert("이미 등록된 아이디입니다.");
		              location.href="nurseRegister.jsp";          
					</script>
<%		
				
				}		
			
			
			if(a){
			stmt.executeUpdate("INSERT INTO hospital.nurse(id,password,Name,Phone) VALUES ('"+nurseid+"','"+nursepw+"','"+nurseName+"','"+nursePhoneNum+"');");
			
%>					
			<script type="text/javascript">
              
              alert("간호사 정보가 등록되었습니다.");
              location.href="LoginPage.jsp";          
			</script>
<%		
			
			}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
			
		}
		

%>
</body>
</html>
