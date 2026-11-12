<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "MANAGER"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");
    String keyword = request.getParameter("keyword");
    boolean searched = keyword != null;
    ArrayList<Dish0> dishes = searched ? new DishDAO0().searchDishByName(keyword) : null;
%>
<h1>Tìm món ăn cần sửa</h1>
<% if ("1".equals(request.getParameter("saved"))) { %><div class="msg-ok">Đã cập nhật thông tin món ăn.</div><% } %>
<form method="get" action="gdSearchDish0.jsp">
  <input type="text" name="keyword" placeholder="Nhập tên món (để trống = tất cả)" value="<%=esc(keyword)%>">
  <button type="submit">Tìm kiếm</button>
</form>
<% if (searched) {
     if (dishes == null) { %><p class="msg-err">Không tìm thấy món ăn nào phù hợp.</p><% }
     else { %>
<table><tr><th>#</th><th>Tên món</th><th>Nhóm</th><th class="right">Giá</th><th>Trạng thái</th><th>Nguyên liệu</th><th></th></tr>
<% int i = 1; for (Dish0 d : dishes) { %>
<tr><td><%=i++%></td><td><%=esc(d.getName())%></td><td><%=esc(d.getCategoryName())%></td>
<td class="right"><%=money(d.getPrice())%></td>
<td><span class="tag <%="ACTIVE".equals(d.getStatus()) ? "ok" : "bad"%>"><%="ACTIVE".equals(d.getStatus()) ? "Đang bán" : "Ngừng bán"%></span></td>
<td><%=d.isAvailable() ? "Đủ" : "<span class='tag bad'>Thiếu</span>"%></td>
<td><a class="btn" href="gdEditDish0.jsp?id=<%=d.getId()%>">Sửa</a></td></tr>
<% } %></table>
<% } } %>
<a class="btn gray" href="gdDishMenu0.jsp">&laquo; Quay lại</a>
<%@ include file="../common/footer.jspf" %>
