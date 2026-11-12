<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "CUSTOMER"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<%
    int rid = 0;
    try { rid = Integer.parseInt(request.getParameter("rid")); } catch (Exception e) { }
    ReservationDAO0 rdao = new ReservationDAO0();
    Reservation0 res = rdao.getReservationById(rid);
    // Phai la dat ban cua chinh khach va con co the goi mon
    if (res == null || res.getCustomerId() != me.getId() || !rdao.checkOrderable(rid)) {
        session.removeAttribute("cart");
        response.sendRedirect("gdFindReservation0.jsp?err=1"); return;
    }
    Order0 cart = (Order0) session.getAttribute("cart");
    if (cart == null || cart.getReservationId() != rid) {      // doi dat ban -> gio moi
        cart = new Order0(); cart.setReservationId(rid); session.setAttribute("cart", cart);
    }
    if (request.getParameter("note") != null) cart.setNote(request.getParameter("note"));
%>
<h1>Gọi món trực tuyến</h1>
<% if ("1".equals(request.getParameter("err"))) { %><div class="msg-err">Không thể lưu đơn: có món vừa ngừng bán / hết nguyên liệu, hoặc đặt bàn không còn hợp lệ. Vui lòng kiểm tra lại giỏ.</div><% } %>
<% if ("1".equals(request.getParameter("added"))) { %><div class="msg-ok">Đã thêm món vào đơn.</div><% } %>
<p><b>Đặt bàn #<%=res.getId()%></b> - <%=new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(res.getReservationTime())%>
 - <%=esc(res.getGuestName())%> - <%=res.getGuestCount()%> khách - Bàn: <%=esc(res.getTableCodes())%></p>
<h3>Các món đã chọn</h3>
<% if (cart.getItems().isEmpty()) { %><p class="muted">Chưa có món nào.</p>
<% } else { %>
<table><tr><th>#</th><th>Món</th><th class="right">Đơn giá</th><th class="right">SL</th><th class="right">Thành tiền</th><th>Ghi chú</th><th></th></tr>
<% int i = 1; for (OrderItem0 it : cart.getItems()) { %>
<tr><td><%=i++%></td><td><%=esc(it.getMenuItemName())%></td><td class="right"><%=money(it.getUnitPrice())%></td><td class="right"><%=it.getQuantity()%></td>
<td class="right"><%=money(it.getAmount())%></td><td><%=esc(it.getNote())%></td>
<td><a class="btn gray" href="doRemoveItem0.jsp?menuItemId=<%=it.getMenuItemId()%>">Xóa</a></td></tr>
<% } %>
<tr><th colspan="4" class="right">Tổng cộng (tạm tính)</th><th class="right"><%=money(cart.calcTotal())%></th><th colspan="2"></th></tr></table>
<% } %>
<p><a class="btn" href="gdSearchDishOrder0.jsp">+ Thêm món</a></p>
<% if (!cart.getItems().isEmpty()) { %>
<form action="doConfirmOrder0.jsp" method="post">
  <label>Ghi chú cho nhà hàng</label><textarea name="note" rows="2" maxlength="255"><%=esc(cart.getNote())%></textarea>
  <p><button type="submit">Xác nhận đặt món</button></p>
</form><% } %>
<a class="btn gray" href="gdFindReservation0.jsp">&laquo; Chọn đặt bàn khác</a>
<%@ include file="../common/footer.jspf" %>
