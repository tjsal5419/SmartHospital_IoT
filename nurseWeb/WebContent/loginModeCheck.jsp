<%@ include file="navar_session.jspf" %>
<%@page pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %> <! sql이용을 위해 Import !>
<%@ page import ="common.DBconn" %>
	
	<%
	 request.setCharacterEncoding("UTF-8");
	 String id=(String)request.getParameter("id");
	 String pw =(String)request.getParameter("password");
	 String mode=(String)request.getParameter("loginMode");
	 // out.print(mode+id+pw);
	 
	 if(id==""){
%>
		    <script type="text/javascript">
			alert("아이디를 입력해주세요!!!");
				location.href="LoginPage.jsp";			             
				</script>				

<%
	 }
	 else if(pw==""){
%>
		    <script type="text/javascript">
			alert("비밀번호를 입력해주세요!!!");
				location.href="LoginPage.jsp";			             
				</script>				

<%
	 }
	 
	 
		String result="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DBconn.conn();
		String sql="select * from "+mode+";";
		pstmt=conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		 try{
				
				  String Id, PW, Name;
				  boolean whileBreak=true;
				  boolean noQuery=true;
				
				  while (rs.next()){
			    
			      Id=rs.getString("id");
			      PW=rs.getString("Password");
			      Name=rs.getString("Name");
			     

			       if(whileBreak){
			         if(Id.equals(id) && PW.equals(pw)){
			                session.setAttribute("id",Id);
			                session.setAttribute("name",Name);
			                session.setAttribute("mode",mode);			                
			                whileBreak=false;
			                noQuery=false;
			                

					if(mode.equals("nurse"))
					{
				   %>
				   
			                      <script type="text/javascript">
			                          alert("<%=Name%> 간호사님 반갑습니다.");
			                         location.href="mainPageNurse.jsp";			             
			                     </script>
			                     
			        
			<%      }else if(mode.equals("admin")){
			%>
            				    <script type="text/javascript">
                				alert("<%=Name%> 관리자님 반갑습니다.");
               					location.href="mainPageAdmin.jsp";			             
           						</script>				
				
			<%
			}
		
			
							break;
			                  }
			         else if(Id.equals(id)) {
			        	 noQuery=false;
			%> 
			                <script type="text/javascript">
			               
			                     alert("비밀번호를 다시 확인해주세요.");
			                     location.href="LoginPage.jsp";
			               </script>
			<%              }
			         
			            }}
			            
			if(noQuery){

			%>

								<script type="text/javascript">
			               
			                     alert("등록된 정보가 없습니다. 관리자에게 문의주세요.");
			                     location.href="LoginPage.jsp";
			                    </script>



			<%}        
			}	catch(SQLException e)
			{
				out.println(e.getMessage());
			}	
			finally
			{
				if(rs != null) try{rs.close();}catch(SQLException ex){}
				if(pstmt != null) try{ pstmt.close();}catch(SQLException ex){}
				if(conn != null)try{conn.close();}catch(SQLException ex){}
			}
		 
	



%>
</body>
</html>