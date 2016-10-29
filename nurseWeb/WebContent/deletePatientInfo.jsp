<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page import = "java.sql.*" %> <! sql이용을 위해 Import !>
<%@ page import ="common.DBconn" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<% 
request.setCharacterEncoding("UTF-8");
String sapNum = (String)request.getParameter("sapNum");
Connection conn=null;
PreparedStatement pstmt=null;
ResultSet rs=null;
try{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DBconn.conn();
	String sql="delete from hospital.patient where sapNum="+sapNum;
	pstmt=conn.prepareStatement(sql);
	pstmt.executeUpdate();
}catch(Exception e){
	System.out.println(e);
}
	
%>

<script type="text/javascript">
              
              alert("삭제되었습니다.");
              location.href="patientSapTable.jsp";
              
             
</script>	

</body>
</html>