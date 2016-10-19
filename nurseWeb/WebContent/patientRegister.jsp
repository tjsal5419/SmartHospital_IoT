 <%@ include file="navar_session.jspf" %>
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
 
 <body>
   <div class="container" >
	    <div class="row">     
	        <div class="col-xs-12">
             
            <div class="modal fade" id="defaultModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">��</button>
                            <h4 class="modal-title">�˸�</h4>
                        </div>
                        <div class="modal-body">
                            <p class="modal-contents"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">�ݱ�</button>
                        </div>
                    </div>
                </div>
            </div>
            <hr/>
                 
 
 
        <form class="form-horizontal" role="form" method="post" action="javascript:alert( 'success!' );">
       
            <div class="form-group" id="divId">
                <label for="inputId" class="col-lg-2 control-label">아&nbsp이&nbsp디</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control onlyAlphabetAndNumber" id="id" data-rule-required="true" placeholder="20자이내 아이디를 입력해주세요." maxlength="30">
                </div>
            </div>
       
            <div class="form-group" id="divPassword">
                <label for="inputPassword" class="col-lg-2 control-label">비밀번호</label>
                <div class="col-lg-10">
                    <input type="password" class="form-control" id="password" name="excludeHangul" data-rule-required="true" placeholder="비밀번호를 입력해주세요." maxlength="30">
                </div>
            </div>
       
            <div class="form-group" id="divPasswordCheck">
                <label for="inputPasswordCheck" class="col-lg-2 control-label">비밀번호 확인</label>
                <div class="col-lg-10">
                    <input type="password" class="form-control" id="passwordCheck" data-rule-required="true" placeholder="비밀번호를 다시 입력해주세요." maxlength="30">
                </div>
            </div>
       
            <div class="form-group" id="divName">
                <label for="inputName" class="col-lg-2 control-label">이&nbsp&nbsp름</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control onlyHangul" id="name" data-rule-required="true" placeholder="간호사 이름을 입력해주세요." maxlength="15">
                </div>
            </div>
             
            <div class="form-group" id="divPhoneNumber">
                <label for="inputPhoneNumber" class="col-lg-2 control-label">전화번호</label>
                <div class="col-lg-10">
                    <input type="tel" class="form-control onlyNumber" id="phoneNumber" data-rule-required="true" placeholder="간호사 연락처를 입력해주세요." maxlength="11">
                </div>
            </div>

            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                    <button type="submit" class="btn btn-default">Sign in</button>
                </div>
            </div>
        </form>
        
        
        
	</div>
   </div>
  </div>
  
  </body>
  
          <script>
         
            $(function(){
                var modalContents = $(".modal-contents");
                var modal = $("#defaultModal");
                 
             
                $(".onlyNumber").keyup(function(event){
                    if (!(event.keyCode >=37 && event.keyCode<=40)) {
                        var inputVal = $(this).val();
                        $(this).val(inputVal.replace(/[^0-9]/gi,''));
                    }
                });

                
                $('#id').keyup(function(event){
                     
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
                 
                 
                //------- validation �˻�
                $( "form" ).submit(function( event ) {
                     
                    var provision = $('#provision');
                    var memberInfo = $('#memberInfo');
                    var divId = $('#divId');
                    var divPassword = $('#divPassword');
                    var divPasswordCheck = $('#divPasswordCheck');
                    var divName = $('#divName');
                    var divPhoneNumber = $('#divPhoneNumber');
                     
                     
                    //���̵� �˻�
                    if($('#id').val()==""){
                        modalContents.text("���̵� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.");
                        modal.modal('show');
                         
                        divId.removeClass("has-success");
                        divId.addClass("has-error");
                        $('#id').focus();
                        return false;
                    }else{
                        divId.removeClass("has-error");
                        divId.addClass("has-success");
                    }
                     
                    //�н����� �˻�
                    if($('#password').val()==""){
                        modalContents.text("�н����带 �Է��Ͽ� �ֽñ� �ٶ��ϴ�.");
                        modal.modal('show');
                         
                        divPassword.removeClass("has-success");
                        divPassword.addClass("has-error");
                        $('#password').focus();
                        return false;
                    }else{
                        divPassword.removeClass("has-error");
                        divPassword.addClass("has-success");
                    }
                     
                    //�н����� Ȯ��
                    if($('#passwordCheck').val()==""){
                        modalContents.text("�н����� Ȯ���� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.");
                        modal.modal('show');
                         
                        divPasswordCheck.removeClass("has-success");
                        divPasswordCheck.addClass("has-error");
                        $('#passwordCheck').focus();
                        return false;
                    }else{
                        divPasswordCheck.removeClass("has-error");
                        divPasswordCheck.addClass("has-success");
                    }
                     
                    //�н����� ��
                    if($('#password').val()!=$('#passwordCheck').val() || $('#passwordCheck').val()==""){
                        modalContents.text("�н����尡 ��ġ���� �ʽ��ϴ�.");
                        modal.modal('show');
                         
                        divPasswordCheck.removeClass("has-success");
                        divPasswordCheck.addClass("has-error");
                        $('#passwordCheck').focus();
                        return false;
                    }else{
                        divPasswordCheck.removeClass("has-error");
                        divPasswordCheck.addClass("has-success");
                    }
                     
                    //�̸�
                    if($('#name').val()==""){
                        modalContents.text("�̸��� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.");
                        modal.modal('show');
                         
                        divName.removeClass("has-success");
                        divName.addClass("has-error");
                        $('#name').focus();
                        return false;
                    }else{
                        divName.removeClass("has-error");
                        divName.addClass("has-success");
                    }
                     
                     
                    //�޴��� ��ȣ
                    if($('#phoneNumber').val()==""){
                        modalContents.text("�޴��� ��ȣ�� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.");
                        modal.modal('show');
                         
                        divPhoneNumber.removeClass("has-success");
                        divPhoneNumber.addClass("has-error");
                        $('#phoneNumber').focus();
                        return false;
                    }else{
                        divPhoneNumber.removeClass("has-error");
                        divPhoneNumber.addClass("has-success");
                    }
                     
                 
                });
                 
            });
             
        </script>
        
