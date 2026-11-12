<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "MANAGER"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<%
    String f = request.getParameter("from"), t = request.getParameter("to");
    ArrayList<DishStat0> list = null; String err = null;
    if (f != null && t != null) {
        try {
            java.sql.Date from = java.sql.Date.valueOf(f), to = java.sql.Date.valueOf(t);
            if (from.after(to)) err = "Ngày bắt đầu phải trước ngày kết thúc."; else list = new StatDAO0().statDishRevenue(from, to);
        } catch (Exception e) { err = "Ngày không hợp lệ."; }
    }
%>
<h1>Thống kê doanh thu theo món</h1>
<form method="get"><input type="date" name="from" value="<%=esc(f)%>"> → <input type="date" name="to" value="<%=esc(t)%>"> <button>Xem</button></form>
<% if (err != null) { %><div class="msg-err"><%=err%></div><% }
   else if (f != null && list == null) { %><p class="msg-err">Không có dữ liệu trong khoảng thời gian này.</p><% }
   else if (list != null) { double sum = 0; %>
<table><tr><th>#</th><th>Món</th><th class="right">Số lượng</th><th class="right">Doanh thu</th></tr>
<% int i = 1; for (DishStat0 s : list) { sum += s.getTotalRevenue(); %>
<tr><td><%=i++%></td><td><%=esc(s.getName())%></td><td class="right"><%=s.getTotalQuantity()%></td><td class="right"><%=money(s.getTotalRevenue())%></td></tr><% } %>
<tr><th colspan="3" class="right">Tổng</th><th class="right"><%=money(sum)%></th></tr></table><% } %>
<a class="btn gray" href="gdManagerHome0.jsp">&laquo; Về trang chủ</a>
<%@ include file="../common/footer.jspf" %>
