 <%@ include file="navar_session.jspf" %>
 <%@page pageEncoding="UTF-8"%>
<link href='http://fonts.googleapis.com/css?family=Open+Sans:300' rel='stylesheet' type='text/css'>
 	    <style>
			#select {
	    	padding-top: 30px
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
    		font-size: 20px;
    		text-align: center;
    		font-weight: bold;
  			padding-bottom: 15px;
 			}
			#select .form-group {
   			margin-bottom: 20px;
			}
			
			.ghost-button {
			    color: #009688;
			    background: #fff;
			    border: 2px solid #009688;
			    font-size: 17px;
			    padding: 21px 36px;
			    font-weight: normal;
			    margin: 10px 0;
			    margin-right: 12px;
			    display: inline-block;
			    text-decoration: none;
			    font-family: 'Open Sans', sans-serif;
			    min-width: 300px;
			}
			
			.ghost-button:hover, .ghost-button:active {
			  color:#fff;
			  background:#009688;
			}
			body {
  background: #eee;
  text-align: center;
  padding-top: 20px;
}
      	</style>
<body>    	
 <%
 //세션 만료 시 자동 로그아웃 후 페이지 이동하기 위한 소스
    session = request.getSession(false);
    if (session == null || session.getAttribute("id") == null) {
        out.println("<script>alert('로그인이 필요합니다. 로그인 페이지로 이동합니다.'); location.href='/nurseWeb/LoginPage.jsp'; </script>");
        return;  // 중요함!!
    }
%>
<section id="select">

	    <div class="container" >
	    
	        <div class="row">
	        
	            <div class="col-xs-12">
	            
<h1>간호사 전용 페이지</h1>
<h1>환자를 등록하거나 추가하실 수 있습니다</h1>

  <a href="patientSapTable.jsp" class="ghost-button">환자 수액 관리 프로그램</a>
  <br/>
  <a href="patientRegister.jsp" class="ghost-button">환자 정보 추가하기</a>
  <br/>
  <a href="#" class=ghost-button> 환자 정보 추가 방법 </a>
  <br/>
  <a href="Logout.jsp" class="ghost-button" >로그아웃</a>
 <hr/>
 <h2><%=loginName%> 간호사님 환영합니다! 오늘도 즐거운 하루되세요.</h2>

</div>
</div>
</div>

</section>

 </body>
 </html>