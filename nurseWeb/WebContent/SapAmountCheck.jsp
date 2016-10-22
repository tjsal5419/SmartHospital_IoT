 <%@ include file="navar_session.jspf" %>
 <%@page pageEncoding="UTF-8"%>
 <%
 //세션 만료 시 자동 로그아웃 후 페이지 이동하기 위한 소스
    session = request.getSession(false);
    if (session == null || session.getAttribute("id") == null) {
        out.println("<script>alert('로그인이 필요합니다. 로그인 페이지로 이동합니다.'); location.href='/nurseWeb/LoginPage.jsp'; </script>");
        return;  // 중요함!!
    }
%>
<div class="panel panel-default">
  <!-- Default panel contents -->
  <div class="panel-heading">Panel heading</div>

  <!-- Table -->
  <table class="table">
    ...
  </table>
</div>