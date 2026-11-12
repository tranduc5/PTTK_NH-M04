<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "CUSTOMER"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("name") == null ? "" : request.getParameter("name");
    String phone = request.getParameter("phone") == null ? "" : request.getParameter("phone");
    ReservationDAO0 rdao = new ReservationDAO0();
    ArrayList<Reservation0> list = rdao.getReservationsOfCustomer(me.getId(), name, phone);   // chi lay dat ban CUA khach dang dang nhap
    String err = request.getParameter("err");
%>
<h1>Chọn đặt bàn để gọi món</h1>
<% if ("1".equals(err)) { %><div class="msg-err">Đặt bàn này không còn có thể gọi món (đã hoàn tất, đã hủy, đang phục vụ hoặc quá giờ đến 30 phút).</div><% } %>
<% if ("2".equals(request.getParameter("ok"))) { %><div class="msg-ok">Đặt món thành công! Nhà hàng sẽ xác nhận đơn của bạn.</div><% } %>
<form method="get">
  <input type="text" name="name" placeholder="Tên người đặt" value="<%=esc(name)%>">
  <input type="text" name="phone" placeholder="Số điện thoại" value="<%=esc(phone)%>">
  <button type="submit">Tìm</button>
</form>
<% if (list == null) { %><p class="msg-err">Không tìm thấy đặt bàn nào của bạn.</p>
<% } else { %>
<table><tr><th>Mã</th><th>Thời gian</th><th>Người đặt</th><th>SĐT</th><th>Số khách</th><th>Bàn</th><th>Trạng thái</th><th></th></tr>
<% for (Reservation0 r : list) { boolean ok = rdao.checkOrderable(r.getId()); %>
<tr><td><%=r.getId()%></td><td><%=new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(r.getReservationTime())%></td>
<td><%=esc(r.getGuestName())%></td><td><%=esc(r.getGuestPhone())%></td><td><%=r.getGuestCount()%></td><td><%=esc(r.getTableCodes())%></td>
<td><span class="tag"><%=esc(r.getStatus())%></span></td>
<td><% if (ok) { %><a class="btn" href="gdOrder0.jsp?rid=<%=r.getId()%>">Gọi món</a><% } %>
<a class="btn gray" href="gdMyOrders0.jsp?rid=<%=r.getId()%>">Đơn đã đặt</a></td></tr>
<% } %></table><% } %>
<a class="btn gray" href="gdCustomerHome0.jsp">&laquo; Về trang chủ</a>
<%@ include file="../common/footer.jspf" %>
