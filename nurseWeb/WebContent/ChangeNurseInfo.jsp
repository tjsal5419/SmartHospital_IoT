 <%@ include file="navar_session.jspf" %>
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
  <style>   
 h2{
    		color: #1fa67b;
    		font-size: 25px;
    		text-align: center;
    		font-weight: bold;
  			padding-bottom: 15px;
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
   <div class="container" >
	    <div class="row">     
	        <div class="col-xs-12">
             
            <div class="modal fade" id="defaultModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">닫기</button>
                            <h4 class="modal-title">알림창</h4>
                        </div>
                        <div class="modal-body">
                            <p class="modal-contents"></p>
                        </div>
                    </div>
                </div>
            </div>
            <h2> 간호사 등록 페이지 (관리자용) </h2>
            <hr/><br/>
           
                 
        <form name="nurseInfo" class="form-horizontal" role="form" method="post" action="nurseidCheck_Register.jsp">
       
            <div class="form-group" id="divId">
                <label for="inputId" class="col-lg-2 control-label">아&nbsp이&nbsp디</label>
                <div class="col-lg-8">
                    <input type="text" class="form-control onlyAlphabetAndNumber" id="nurseid" name="nurseid" data-rule-required="true" placeholder="20자이내 아이디를 입력해주세요." maxlength="20">
                </div>
                
                  <div class="col-lg-offset-2 col-lg-8">
                  	<br/>
                    <input type="button" id="idCheck" class="btn btn-default" value="중복 확인">
                  </div>
                  <div id="result" class="col-lg-offset-2 col-lg-10"> </div> 
            
        	</div>
       
            <div class="form-group" id="divPassword">
                <label for="inputPassword" class="col-lg-2 control-label">비밀번호</label>
                <div class="col-lg-8">
                    <input type="password" class="form-control" id="password" name="password" data-rule-required="true" placeholder="비밀번호를 입력해주세요." maxlength="20">
                </div>
            </div>
       
            <div class="form-group" id="divPasswordCheck">
                <label for="inputPasswordCheck" class="col-lg-2 control-label">비밀번호 확인</label>
                <div class="col-lg-8">
                    <input type="password" class="form-control" id="passwordCheck" data-rule-required="true" placeholder="비밀번호를 다시 입력해주세요." maxlength="20">
                </div>
            </div>
       
            <div class="form-group" id="divName">
                <label for="inputName" class="col-lg-2 control-label">이&nbsp&nbsp름</label>
                <div class="col-lg-8">
                    <input type="text" class="form-control onlyHangul" id="name" name="name" data-rule-required="true" placeholder="간호사 이름을 입력해주세요." maxlength="10">
                </div>
            </div>
             
            <div class="form-group" id="divPhoneNumber">
                <label for="inputPhoneNumber" class="col-lg-2 control-label">전화번호</label>
                <div class="col-lg-8">
                    <input type="tel" class="form-control onlyNumber" id="phoneNumber" name="phoneNumber" data-rule-required="true" placeholder="간호사 연락처를 입력해주세요.(숫자만 입력 가능)" maxlength="11">
                </div>
            </div>

            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-8">
                    <button type="submit" class="btn btn-default">Sign in</button>
                </div>
            </div>
        </form>
        
        
	</div>
   </div>
  </div>
  </body>
  
          <script>
          	var isMemberChecked="N";
          	
          	$(document).ready(function(){
          		
          		$("#idCheck").click(function(){
          			var param="nurseid="+$("#nurseid").val();
          			isMemberChecked = "Y"
          			          				
          				$.ajax({
          					type: "post",
          					url: "/nurseWeb/member/idCheck.do",
          					data: param,
          					success:function(data){
          						$("#result").html(data);
          	          		}
          				});
          				
          				
          		});
          		
          	});
         
            $(function(){
                var modalContents = $(".modal-contents");
                var modal = $("#defaultModal");
                 
             
                $(".onlyNumber").keyup(function(event){
                    if (!(event.keyCode >=37 && event.keyCode<=40)) {
                        var inputVal = $(this).val();
                        $(this).val(inputVal.replace(/[^0-9]/gi,''));
                    }
                });

                
                $('#nurseid').keyup(function(event){
                     
                    var divId = $('#divId');
                     
                    if($('#id').val()==""){
                        divId.removeClass("has-success");
                        divId.addClass("has-error");
                    }else{
                        divId.removeClass("has-error");
                        divId.addClass("has-success");
                    }
                });
                 
                $('#password').keyup(function(event){
                     
                    var divPassword = $('#divPassword');
                     
                    if($('#password').val()==""){
                        divPassword.removeClass("has-success");
                        divPassword.addClass("has-error");
                    }else{
                        divPassword.removeClass("has-error");
                        divPassword.addClass("has-success");
                    }
                });
                 
                $('#passwordCheck').keyup(function(event){
                     
                    var passwordCheck = $('#passwordCheck').val();
                    var password = $('#password').val();
                    var divPasswordCheck = $('#divPasswordCheck');
                     
                    if((passwordCheck=="") || (password!=passwordCheck)){
                        divPasswordCheck.removeClass("has-success");
                        divPasswordCheck.addClass("has-error");
                    }else{
                        divPasswordCheck.removeClass("has-error");
                        divPasswordCheck.addClass("has-success");
                    }
                });
                 
                $('#name').keyup(function(event){
                     
                    var divName = $('#divName');
                     
                    if($.trim($('#name').val())==""){
                        divName.removeClass("has-success");
                        divName.addClass("has-error");
                    }else{
                        divName.removeClass("has-error");
                        divName.addClass("has-success");
                    }
                });
                 
                 
                 
                $('#phoneNumber').keyup(function(event){
                     
                    var divPhoneNumber = $('#divPhoneNumber');
                     
                    if($.trim($('#phoneNumber').val())==""){
                        divPhoneNumber.removeClass("has-success");
                        divPhoneNumber.addClass("has-error");
                    }else{
                        divPhoneNumber.removeClass("has-error");
                        divPhoneNumber.addClass("has-success");
                    }
                });
                 
                 
                //------- validation 체크
                $( "form" ).submit(function( event ) {
                     
                    var provision = $('#provision');
                    var memberInfo = $('#memberInfo');
                    var divId = $('#divId');
                    var divPassword = $('#divPassword');
                    var divPasswordCheck = $('#divPasswordCheck');
                    var divName = $('#divName');
                    var divPhoneNumber = $('#divPhoneNumber');
                    var result =$('#result');
                     
                     
                    //아이디 확인
                    if($('#nurseid').val()==""){
                        modalContents.text("아이디를 입력해주세요.");
                        modal.modal('show');
                         
                        divId.removeClass("has-success");
                        divId.addClass("has-error");
                        $('#id').focus();
                        return false;
                    }else{
                        divId.removeClass("has-error");
                        divId.addClass("has-success");
                    }
                     
                    //비밀번호 입력 확인
                    if($('#password').val()==""){
                        modalContents.text("비밀번호를 입력해주세요.");
                        modal.modal('show');
                         
                        divPassword.removeClass("has-success");
                        divPassword.addClass("has-error");
                        $('#password').focus();
                        return false;
                    }else{
                        divPassword.removeClass("has-error");
                        divPassword.addClass("has-success");
                    }
                     
                    //비밀번호 확인란 확인
                    if($('#passwordCheck').val()==""){
                        modalContents.text("비밀번호 재 확인란을 입력해주세요.");
                        modal.modal('show');
                         
                        divPasswordCheck.removeClass("has-success");
                        divPasswordCheck.addClass("has-error");
                        $('#passwordCheck').focus();
                        return false;
                    }else{
                        divPasswordCheck.removeClass("has-error");
                        divPasswordCheck.addClass("has-success");
                    }
                     
                    //비밀번호 일치 확인
                    if($('#password').val()!=$('#passwordCheck').val() || $('#passwordCheck').val()==""){
                        modalContents.text("비밀번호가 일치하지 않습니다.");
                        modal.modal('show');
                         
                        divPasswordCheck.removeClass("has-success");
                        divPasswordCheck.addClass("has-error");
                        $('#passwordCheck').focus();
                        return false;
                    }else{
                        divPasswordCheck.removeClass("has-error");
                        divPasswordCheck.addClass("has-success");
                    }
                     
                    //이름 입력 확인 
                    if($('#name').val()==""){
                        modalContents.text("이름을 입력해주세요.");
                        modal.modal('show');
                         
                        divName.removeClass("has-success");
                        divName.addClass("has-error");
                        $('#name').focus();
                        return false;
                    }else{
                        divName.removeClass("has-error");
                        divName.addClass("has-success");
                    } 
                    
                     if(isMemberChecked != "Y"){
                        modalContents.text("아이디 중복 확인을 해주세요.");
                        modal.modal('show');
                        divId.removeClass("has-success");
                        divId.addClass("has-error");
                        
                        return false;
                        
                    }else{
                    	divName.removeClass("has-error");
                        divName.addClass("has-success");
                    }
                     
                    
                 
                });
                 
            });
             
        </script>
        
        
