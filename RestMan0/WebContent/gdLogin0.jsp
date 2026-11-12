<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/header.jspf" %>
<h1>Đăng nhập hệ thống</h1>
<% String err = request.getParameter("err");
   if ("1".equals(err)) { %><div class="msg-err">Sai tên đăng nhập hoặc mật khẩu.</div><% }
   if ("2".equals(err)) { %><div class="msg-err">Bạn chưa đăng nhập hoặc không có quyền truy cập trang này.</div><% } %>
<!--<form action="doLogin0.jsp" method="post">-->
<form action="<%= request.getContextPath() %>/doLogin0.jsp"
      method="post"> 
  <label>Tên đăng nhập</label><input type="text" name="username" required>
  <label>Mật khẩu</label><input type="password" name="password" required>
  <p><button type="submit">Đăng nhập</button></p>
</form>
<p class="muted">Tài khoản mẫu (mật khẩu 123456): manager0, customer0, warehouse0, sales0</p>
<%@ include file="common/footer.jspf" %>
