<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "SALES"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<%
    String ds = request.getParameter("date");
    java.sql.Date day = new java.sql.Date(System.currentTimeMillis());
    try { if (ds != null && !ds.isEmpty()) day = java.sql.Date.valueOf(ds); } catch (Exception e) { }
    ReservationDAO0 rdao = new ReservationDAO0(); OrderDAO0 odao = new OrderDAO0();
    ArrayList<Reservation0> list = rdao.getReservationsByDate(day);
%>
<h1>Đặt bàn ngày <%=day%></h1>
<form method="get"><input type="date" name="date" value="<%=day%>"> <button>Xem</button></form>
<% if (list == null) { %><p class="msg-err">Không có đặt bàn nào.</p><% } else for (Reservation0 r : list) { ArrayList<Order0> os = odao.getOrdersOfReservation(r.getId()); %>
<h3>#<%=r.getId()%> - <%=new java.text.SimpleDateFormat("HH:mm").format(r.getReservationTime())%> - <%=esc(r.getGuestName())%> (<%=esc(r.getGuestPhone())%>) - <%=r.getGuestCount()%> khách - Bàn <%=esc(r.getTableCodes())%> <span class="tag"><%=esc(r.getStatus())%></span></h3>
<% if (os != null) { for (Order0 o : os) { %>
<p>Đơn #<%=o.getId()%> <span class="tag"><%=esc(o.getStatus())%></span> - <%=money(o.getTotalAmount())%> :
<% for (OrderItem0 it : o.getItems()) { %><%=esc(it.getMenuItemName())%> x<%=it.getQuantity()%>; <% } %>
<% if ("PENDING".equals(o.getStatus())) { %><a class="btn" href="doConfirmOrderSales0.jsp?id=<%=o.getId()%>&date=<%=day%>">Xác nhận</a>
<a class="btn gray" href="doConfirmOrderSales0.jsp?id=<%=o.getId()%>&date=<%=day%>&cancel=1">Hủy đơn</a><% } %></p>
<% } } } %>
<a class="btn gray" href="gdSalesHome0.jsp">&laquo; Về trang chủ</a>
<%@ include file="../common/footer.jspf" %>
