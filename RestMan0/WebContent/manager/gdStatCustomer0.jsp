<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "MANAGER"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<%
    String f = request.getParameter("from"), t = request.getParameter("to");
    ArrayList<CustomerStat0> list = null; String err = null;
    if (f != null && t != null) {
        try {
            java.sql.Date from = java.sql.Date.valueOf(f), to = java.sql.Date.valueOf(t);
            if (from.after(to)) err = "Ngày bắt đầu phải trước ngày kết thúc."; else list = new StatDAO0().statCustomer(from, to);
        } catch (Exception e) { err = "Ngày không hợp lệ."; }
    }
%>
<h1>Thống kê khách hàng</h1>
<form method="get"><input type="date" name="from" value="<%=esc(f)%>"> → <input type="date" name="to" value="<%=esc(t)%>"> <button>Xem</button></form>
<% if (err != null) { %><div class="msg-err"><%=err%></div><% }
   else if (f != null && list == null) { %><p class="msg-err">Không có dữ liệu.</p><% }
   else if (list != null) { %>
<table><tr><th>#</th><th>Khách hàng</th><th class="right">Số lần đặt bàn</th><th class="right">Tổng chi tiêu (đơn gọi món)</th></tr>
<% int i = 1; for (CustomerStat0 s : list) { %>
<tr><td><%=i++%></td><td><%=esc(s.getFullName())%></td><td class="right"><%=s.getReservationCount()%></td><td class="right"><%=money(s.getTotalSpent())%></td></tr><% } %></table><% } %>
<a class="btn gray" href="gdManagerHome0.jsp">&laquo; Về trang chủ</a>
<%@ include file="../common/footer.jspf" %>
