 <%@ include file="navar_session.jspf" %>
 <%@page pageEncoding="UTF-8"%>
 <%@ page import = "java.sql.*" %> <! sql이용을 위해 Import !>
<%@ page import ="common.DBconn" %>
<link href='http://fonts.googleapis.com/css?family=Open+Sans:300' rel='stylesheet' type='text/css'>
 	    <style>
			#select {
	    	padding-top: 5px
				}
			#select .form-wrap {
    		width: 80%;
    		margin: 0 auto;
				}
				
			#select h2{
	  		font-size: 15px;
    		text-align: center;
    		font-weight: bold;
  			padding-bottom: 1px;
			}
			#select h3{
	  		font-size: 12px;
    		text-align: center;
  			padding-bottom: 5px;
			}			
				
			#select h1 {
    		color: #009688;
    		font-size: 25px;
    		text-align: center;
    		font-weight: bold;
  			padding-bottom: 15px;
 			}
			#select .form-group {
   			margin-bottom: 20px;
			}
			

			body {
  background: #eee;
  text-align: center;
  padding-top: 5px;
}
      	</style>
<head>
<meta http-equiv="refresh" content="5;" />
</head>      	

<body>    	
<section id="select">

	    <div class="container" >
	    
	        <div class="row">
	        
	            <div class="col-md-12">
	            
<%
		String result="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String[] underSapNum;
		underSapNum = new String[100];
		String[] underName;
		underName = new String[100];
		int underNum = 0;
		String alertMsg;
		
%>	            
	            
<h1>환자 수액 조회 페이지</h1>
<div>
<input type="button" id="idCheck" class="btn btn-default" value="환자 정보 추가" onclick="window.location='/nurseWeb/patientRegister.jsp';">
</div>
'미등록'표시가 나면 링거액 측정기를 켜주세요.
<br/><br/>

<%	try{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DBconn.conn();
	String sql="select * from hospital.patient ORDER BY sapNum ASC";
	pstmt=conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
%>	

	<div class="panel panel-default">
	  <!-- Default panel contents -->
	 <div class="panel-heading">
	 ** 꼭 환자 등록 후, 측정기를 켜주세요 ** 
	</div>
		
	  <!-- Table -->
	 <table class="table">
	 <tr>
	 <td>링거대 번호</td>
	 <td>환자명</td>
	 <td>수액 이름</td>
	 <td>수액 양</td> 
	 <td>투여시기</td>
	 <td>스위치</td>
	 <td>정보 삭제</td>
	 
	 </tr>
<%	  
	while(rs.next()){
%>

	<tr>
		<td><%=rs.getString("sapNum")%></td>
		<td><%=rs.getString("Name") %></td>
		<td>	
		<%=rs.getString("sapName") %>
		</td>
		<td>
<% 		if(rs.getString("sapAmount")!=null && rs.getString("switch").equals("1")){
		if(rs.getString("sapAmount").equals("1")){
			underSapNum[underNum] = new String(rs.getString("sapNum"));
			underName[underNum] = new String(rs.getString("Name"));
			underNum=underNum+1;
			
			
			
%>	
<span style="color:red">부족</span>

<%			}else if(rs.getString("sapAmount").equals("2")){ %>		
		적당
<%			}else if(rs.getString("sapAmount").equals("3")){
%>		충분
<% 		}}
		else if(rs.getString("switch").equals("0")){ %>
			스위치가 꺼져있습니다.
<%			}  %>		
		 
		</td>
		<td>
<% 			if(rs.getString("sapDate")!=null){  %>		
		<%=rs.getString("sapDate") %>
<%			}else{%>
			미등록		
<%			} %>		
		</td>
		<td>
<%		if(rs.getString("switch").equals("1")){
%>		ON
<%}		else{ %>
		OFF
<%} %>		
		</td>
<!--	<td><a href="ChangePatientInfo.jsp?sapNum= <%=rs.getString("sapNum")%>">수정</a></td> -->
		<td><a href="CheckDeletePatientInfo.jsp?sapNum=<%=rs.getString("sapNum")%>">삭제</a></td>

	</tr>
		
<%	
	}
%>


</table>

<% 
if(underNum!=0){ %>
<%	alertMsg = " ";
	for(int i=0;i<underNum;i++){
		 	alertMsg = alertMsg + underSapNum[i]+ " 링거대의" + underName[i] + "씨 환자 수액교체 시기입니다.\\n";
}
	alertMsg = alertMsg + "경고 창은 수액 교체 후 사라집니다.";
	underSapNum = null;
	underName = null ;
	underNum=0;
	System.out.println(alertMsg);
%>
<script>
        alert('<%=alertMsg%>');
</script>        
<%
}
%>
  


<% 
}catch(Exception e){
	System.out.println(e);
}finally{
	
}
%>
	
</div>

</div>
</div>
</div>

</section>

 </body>
 </html>