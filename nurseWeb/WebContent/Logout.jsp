<%@ include file="navar_session.jspf" %>
<%@page pageEncoding="UTF-8"%>
  
	
<% session.invalidate(); %>

<script type="text/javascript">
              
              alert("로그아웃되었습니다.");
              location.href="LoginPage.jsp";
              
             
</script>