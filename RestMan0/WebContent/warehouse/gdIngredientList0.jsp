<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "WAREHOUSE"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<%
    IngredientDAO0 dao = new IngredientDAO0();
    ArrayList<Ingredient0> list = dao.getAllIngredients();
    ArrayList<ImportReceipt0> receipts = dao.getRecentReceipts(10);
%>
<h1>Tồn kho nguyên liệu</h1>
<% if ("1".equals(request.getParameter("saved"))) { %><div class="msg-ok">Đã lưu phiếu nhập và cập nhật tồn kho.</div><% } %>
<% if (list == null) { %><p>Chưa có nguyên liệu.</p><% } else { %>
<table><tr><th>Nguyên liệu</th><th>ĐVT</th><th class="right">Tồn</th><th class="right">Tối thiểu</th><th></th></tr>
<% for (Ingredient0 i : list) { boolean low = i.getStockQuantity() < i.getMinStock(); %>
<tr><td><%=esc(i.getName())%></td><td><%=esc(i.getUnit())%></td><td class="right"><%=i.getStockQuantity()%></td><td class="right"><%=i.getMinStock()%></td>
<td><%=low ? "<span class='tag bad'>Sắp hết</span>" : "<span class='tag ok'>Đủ</span>"%></td></tr><% } %></table><% } %>
<h3>Phiếu nhập gần đây</h3>
<% if (receipts == null) { %><p class="muted">Chưa có.</p><% } else { %>
<table><tr><th>Mã</th><th>Ngày</th><th>Nhà cung cấp</th><th class="right">Tổng tiền</th><th>Ghi chú</th></tr>
<% for (ImportReceipt0 r : receipts) { %><tr><td><%=r.getId()%></td><td><%=new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(r.getImportDate())%></td><td><%=esc(r.getSupplierName())%></td><td class="right"><%=money(r.getTotalAmount())%></td><td><%=esc(r.getNote())%></td></tr><% } %></table><% } %>
<a class="btn gray" href="gdWarehouseHome0.jsp">&laquo; Về trang chủ</a>
<%@ include file="../common/footer.jspf" %>
