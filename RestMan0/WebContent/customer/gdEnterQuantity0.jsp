<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "CUSTOMER"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<%
    Order0 cart = (Order0) session.getAttribute("cart");
    if (cart == null) { response.sendRedirect("gdFindReservation0.jsp"); return; }
    int id = 0;
    try { id = Integer.parseInt(request.getParameter("id")); } catch (Exception e) { }
    Dish0 d = new DishDAO0().getDishById(id);
    if (d == null || !"ACTIVE".equals(d.getStatus()) || !d.isAvailable()) {
%><div class="msg-err">Món này hiện không thể đặt.</div><a class="btn gray" href="gdSearchDishOrder0.jsp">Quay lại</a><%@ include file="../common/footer.jspf" %><% return; }
%>
<h1>Nhập số lượng</h1>
<% if ("1".equals(request.getParameter("err"))) { %><div class="msg-err">Số lượng phải là số nguyên từ 1 đến 50.</div><% } %>
<p><b><%=esc(d.getName())%></b> - <%=money(d.getPrice())%></p>
<form action="doAddItem0.jsp" method="post">
  <input type="hidden" name="id" value="<%=d.getId()%>">
  <label>Số lượng</label><input type="number" name="quantity" min="1" max="50" value="1">
  <label>Ghi chú món (không bắt buộc)</label><input type="text" name="note" maxlength="255">
  <p><button type="submit">Thêm vào đơn</button> <a class="btn gray" href="gdSearchDishOrder0.jsp">Hủy</a></p>
</form>
<%@ include file="../common/footer.jspf" %>
