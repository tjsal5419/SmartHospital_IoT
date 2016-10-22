 <%@ include file="navar_session.jspf" %>
 
<%@page pageEncoding="UTF-8"%>
    
	    <style>
     
			#login {
	    	padding-top: 30px
				}
			#login .form-wrap {
    		width: 40%;
    		margin: 0 auto;
				}
				
			#login h2{
	  		font-size: 15px;
    		text-align: center;
    		font-weight: bold;
  			padding-bottom: 1px;
			}
			#login h3{
	  		font-size: 15px;
    		text-align: center;
  			padding-bottom: 5px;
			}			
				
			#login h1 {
    		color: #1fa67b;
    		font-size: 18px;
    		text-align: center;
    		font-weight: bold;
  			padding-bottom: 15px;
 			}
			#login .form-group {
   			margin-bottom: 20px;
			}
 
 
			#login .checkbox .character-checkbox {
			    width: 25px;
			    height: 25px;
			    cursor: pointer;
			    border-radius: 3px;
			    border: 1px solid #ccc;
			    vertical-align: middle;
			    display: inline-block;
			}
			#login .checkbox .label {
			    color: #6d6d6d;
			    font-size: 13px;
			    font-weight: normal;
			}
			#login .btn.btn-custom {
			    font-size: 14px;
			    margin-bottom: 20px;
			}

			 
			 
			.form-control {
			    color: #212121;
			}
			.btn-custom {
			    color: #fff;
			    background-color: #1fa67b;
			}
			.btn-custom:hover,
			.btn-custom:focus {
			    color: #fff;
			}
 
    	</style>



	<section id="login">
	    <div class="container"  >
	    
	        <div class="row">
	        
	            <div class="col-xs-15">
	            
	            
	                <div class="form-wrap">
	                <h1> 로그인 후 이용해주세요. </h1>
	               			
	                                       	  
	                    <form action="loginModeCheck.jsp" class="form-horizontal" role="form"  method="post" id="loginForm" autocomplete="off">

	                    	  
							<div class="checkbox form-group form-horizontal">
							   <h2>** 로그인 모드를 택해주세요. **</h2>	
								 <h2>
							      <input type="radio" name="loginMode" value="nurse" checked="checked"> 간호사 모드        
							      <input type="radio" name="loginMode" value="admin"> 관리자 모드							      
								</h2>
							</div>
							<hr/>
							  
	                        <div class="form-group">
	                            <input type="text" name="id" id="id" class="form-control" placeholder="아이디를 입력해주세요.">
	                        </div>
	                        <div class="form-group">
	                            <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호를 입력해주세요.">
	                        </div>
	                        <hr/>
	                        
	                        <br/>
	                        <input type="submit" id="btn-login" class="btn btn-custom btn-lg btn-block" value="로그인" >
	                    </form>
	                    	<h3>** 등록되지 않은 간호사의 경우, 관리자에게 문의해주세요.** </h3><br/>
	                     

	                    <hr>
	                </div>
	            </div>
	        </div>
	    </div>
	</section>
	 

 
</body>
</html>
