<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "CUSTOMER"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<%
    int rid = 0;
    try { rid = Integer.parseInt(request.getParameter("rid")); } catch (Exception e) { }
    Reservation0 res = new ReservationDAO0().getReservationById(rid);
    if (res == null || res.getCustomerId() != me.getId()) { response.sendRedirect("gdFindReservation0.jsp?err=1"); return; }
    ArrayList<Order0> orders = new OrderDAO0().getOrdersOfReservation(rid);
%>
<h1>Đơn gọi món của đặt bàn #<%=rid%></h1>
<% if ("1".equals(request.getParameter("ok"))) { %><div class="msg-ok">Đặt món thành công! Đơn đang chờ nhà hàng xác nhận.</div><% } %>
<% if (orders == null) { %><p class="muted">Chưa có đơn nào.</p><% } else for (Order0 o : orders) { %>
<h3>Đơn #<%=o.getId()%> - <%=new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(o.getOrderTime())%> <span class="tag"><%=esc(o.getStatus())%></span></h3>
<table><tr><th>Món</th><th class="right">Đơn giá</th><th class="right">SL</th><th class="right">Thành tiền</th></tr>
<% for (OrderItem0 it : o.getItems()) { %><tr><td><%=esc(it.getMenuItemName())%></td><td class="right"><%=money(it.getUnitPrice())%></td><td class="right"><%=it.getQuantity()%></td><td class="right"><%=money(it.getAmount())%></td></tr><% } %>
<tr><th colspan="3" class="right">Tổng</th><th class="right"><%=money(o.getTotalAmount())%></th></tr></table>
<% if (o.getNote() != null && !o.getNote().isEmpty()) { %><p>Ghi chú: <%=esc(o.getNote())%></p><% } } %>
<a class="btn gray" href="gdFindReservation0.jsp">&laquo; Danh sách đặt bàn</a>
<%@ include file="../common/footer.jspf" %>
