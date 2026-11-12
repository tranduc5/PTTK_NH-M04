<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "CUSTOMER"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");
    if (session.getAttribute("cart") == null) { response.sendRedirect("gdFindReservation0.jsp"); return; }
    String kw = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
    int catId = 0;
    try { catId = Integer.parseInt(request.getParameter("categoryId")); } catch (Exception e) { }
    ArrayList<Dish0> list = new DishDAO0().searchDishesForOrder(kw, catId);
    ArrayList<DishCategory0> cats = new DishCategoryDAO0().getAllCategories();
%>
<h1>Chọn món</h1>
<form method="get">
  <input type="text" name="keyword" placeholder="Tên món" value="<%=esc(kw)%>">
  <select name="categoryId"><option value="0">Tất cả nhóm</option>
  <% if (cats != null) for (DishCategory0 c : cats) { %><option value="<%=c.getId()%>" <%=c.getId() == catId ? "selected" : ""%>><%=esc(c.getName())%></option><% } %></select>
  <button type="submit">Tìm</button>
</form>
<% if (list == null) { %><p class="msg-err">Không tìm thấy món phù hợp.</p><% } else { %>
<table><tr><th>Món</th><th>Nhóm</th><th>Mô tả</th><th class="right">Giá</th><th></th></tr>
<% for (Dish0 d : list) { %>
<tr><td><%=esc(d.getName())%></td><td><%=esc(d.getCategoryName())%></td><td><%=esc(d.getDescription())%></td><td class="right"><%=money(d.getPrice())%></td>
<td><% if (d.isAvailable()) { %><a class="btn" href="gdEnterQuantity0.jsp?id=<%=d.getId()%>">Chọn</a><% } else { %><span class="tag bad">Tạm hết</span><% } %></td></tr>
<% } %></table><% } %>
<a class="btn gray" href="gdOrder0.jsp?rid=<%=((Order0) session.getAttribute("cart")).getReservationId()%>">&laquo; Quay lại đơn</a>
<%@ include file="../common/footer.jspf" %>
