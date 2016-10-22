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
	  		String sapNum= (String)request.getParameter("sapNum");	 
			String sapName = (String)request.getParameter("sapName");
			String patientName = (String)request.getParameter("patientName");

			
			System.out.println(sapNum);
			System.out.println(sapName);
			System.out.println(patientName);
			
			Connection conn=null;
			Statement stmt=null;
			Statement stmt1=null;
			ResultSet rs = null;
			boolean a = true;
			
			conn = DBconn.conn();
			stmt=conn.createStatement();
			rs = stmt.executeQuery("SELECT COUNT(*) AS 'sapCount' FROM hospital.patient WHERE sapNum='"+sapNum+"';");
			while(rs.next()){
				if(rs.getInt("sapCount")!= 0){
					a=false;
%>						
					<script type="text/javascript">
		              alert("이미 등록된 수액번호 입니다.");
		              location.href="patientRegister.jsp";          
					</script>
<%		
				
				}		
			
			if(a){
			stmt1=conn.createStatement();
			stmt1.executeUpdate("INSERT INTO hospital.patient(sapNum, Name, sapName) VALUES ('"+sapNum+"','"+patientName+"','"+sapName+"');");
			
%>					
			<script type="text/javascript">
              
              alert("환자 정보가 등록되었습니다.");
              location.href="mainPageNurse.jsp";          
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
