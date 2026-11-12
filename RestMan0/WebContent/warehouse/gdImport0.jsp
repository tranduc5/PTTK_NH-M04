<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "WAREHOUSE"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<%
    IngredientDAO0 dao = new IngredientDAO0();
    ArrayList<Ingredient0> ings = dao.getAllIngredients();
    ArrayList<Supplier0> sups = dao.getAllSuppliers();
%>
<h1>Lập phiếu nhập kho</h1>
<% if ("1".equals(request.getParameter("err"))) { %><div class="msg-err">Dữ liệu không hợp lệ: chọn ít nhất 1 nguyên liệu với số lượng &gt; 0 và đơn giá &ge; 0.</div><% } %>
<form action="doImport0.jsp" method="post">
  <label>Nhà cung cấp</label>
  <select name="supplierId"><% if (sups != null) for (Supplier0 s : sups) { %><option value="<%=s.getId()%>"><%=esc(s.getName())%></option><% } %></select>
  <label>Ghi chú</label><input type="text" name="note" maxlength="255">
  <table><tr><th>Nguyên liệu</th><th>Số lượng nhập</th><th>Đơn giá (đ)</th></tr>
  <% if (ings != null) for (Ingredient0 i : ings) { %>
  <tr><td><%=esc(i.getName())%> (<%=esc(i.getUnit())%>)<input type="hidden" name="ingId" value="<%=i.getId()%>"></td>
  <td><input type="number" name="qty" min="0" step="0.1" value="0"></td><td><input type="number" name="price" min="0" step="1000" value="0"></td></tr><% } %>
  </table>
  <button type="submit">Lưu phiếu nhập</button> <a class="btn gray" href="gdWarehouseHome0.jsp">Hủy</a>
</form>
<%@ include file="../common/footer.jspf" %>
