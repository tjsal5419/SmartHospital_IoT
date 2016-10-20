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
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">닫기</button>
                            <h4 class="modal-title">알림창</h4>
                        </div>
                        <div class="modal-body">
                            <p class="modal-contents"></p>
                        </div>
                    </div>
                </div>
            </div>
            <hr/>
                 
        <form class="form-horizontal" role="form" method="post" action="patientSapCheck_Register.jsp">
       
            <div class="form-group" id="divSap">
                <label class="col-lg-2 control-label"> 링거대 번호 </label>
                <div class="col-lg-8">
                    <input type="text" class="form-control onlyNumber" id="sapNum" name="sapNum" data-rule-required="true" placeholder="3자리 링거대 고유 번호를 입력해주세요(ex:000)" maxlength="3">
                </div>
                
                  <div class="col-lg-offset-2 col-lg-8">
                    <input type="button" id="sapCheck" class="btn btn-default" value="링거대 이용 여부 확인">
                  </div>
                  <div id="result" class="col-lg-offset-2 col-lg-10"> </div> 
            
        	</div>
       
            <div class="form-group" id="divSapName">
                <label class="col-lg-2 control-label"> 링거액 이름 </label>
                <div class="col-lg-8">
                    <input type="text" class="form-control" id="sapName" name="sapName" data-rule-required="true" placeholder="링거액 이름을 입력해주세요." maxlength="10">
                </div>
            </div>
       
            <div class="form-group" id="divName">
                <label for="inputName" class="col-lg-2 control-label">환자 이름</label>
                <div class="col-lg-8">
                    <input type="text" class="form-control onlyHangul" id="name" name="name" data-rule-required="true" placeholder="환자 이름을 입력해주세요." maxlength="10">
                </div>
            </div>
             
            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-8">
                    <button type="submit" class="btn btn-default">등록하기</button>
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
          		
          		$("#sapCheck").click(function(){
          			var param="sapNum="+$("#sapNum").val();
          			isMemberChecked = "Y"
          			          				
          				$.ajax({
          					type: "post",
          					url: "/nurseWeb/patientMember/sapCheck.do",
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

                
                $('#sapNum').keyup(function(event){
                     
                    var divSap = $('#divSap');
                     
                    if($('#sapNum').val()==""){
                        divSap.removeClass("has-success");
                        divSap.addClass("has-error");
                    }else{
                        divSap.removeClass("has-error");
                        divSap.addClass("has-success");
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
                 
                 
                 
                //------- validation 체크
                $( "form" ).submit(function( event ) {
                     
                    var provision = $('#provision');
                    var memberInfo = $('#memberInfo');
                    var divSap = $('#divSap');
                    var divName = $('#divName');


                    if($('#sapNum').val()==""){
                        modalContents.text("링거액 번호를 입력해주세요.");
                        modal.modal('show');
                         
                        divSap.removeClass("has-success");
                        divSap.addClass("has-error");
                        $('#divSap').focus();
                        return false;
                    }
                    else{
                        divSap.removeClass("has-error");
                        divSap.addClass("has-success");
                    } 
                    
                    //이름 입력 확인 
                    if($('#name').val()==""){
                        modalContents.text("환자이름을 입력해주세요.");
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
                        divSap.removeClass("has-success");
                        divSap.addClass("has-error");
                        
                        return false;
                        
                    }else{
                    	divName.removeClass("has-error");
                        divName.addClass("has-success");
                    }
                     
                    
                 
                });
                 
            });
             
        </script>
        
        
