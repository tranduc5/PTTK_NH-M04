<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "MANAGER"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<%
    int id = 0;
    try { id = Integer.parseInt(request.getParameter("id")); } catch (Exception e) { }
    Dish0 d = (Dish0) session.getAttribute("editForm");      // du lieu nguoi dung vua nhap (khi loi) -> hien lai
    String err = (String) session.getAttribute("editError");
    session.removeAttribute("editForm"); session.removeAttribute("editError");
    if (d == null || d.getId() != id) d = new DishDAO0().getDishById(id);
    if (d == null) { %><div class="msg-err">Không tìm thấy món ăn.</div><a class="btn gray" href="gdSearchDish0.jsp">Quay lại</a><%@ include file="../common/footer.jspf" %><% return; }
    ArrayList<DishCategory0> cats = new DishCategoryDAO0().getAllCategories();
    long ts = d.getUpdatedTime() == null ? 0 : d.getUpdatedTime().getTime();
%>
<h1>Sửa thông tin món ăn</h1>
<% if (err != null) { %><div class="msg-err"><%=esc(err)%></div><% } %>
<form action="doEditDish0.jsp" method="post">
  <input type="hidden" name="id" value="<%=d.getId()%>">
  <input type="hidden" name="updatedTime" value="<%=ts%>">
  <label>Tên món *</label><input type="text" name="name" maxlength="150" value="<%=esc(d.getName())%>">
  <label>Giá (đ) *</label><input type="number" name="price" min="0" step="1000" value="<%=(long) d.getPrice()%>">
  <label>Nhóm món *</label>
  <select name="categoryId"><% if (cats != null) for (DishCategory0 c : cats) { %>
    <option value="<%=c.getId()%>" <%=c.getId() == d.getCategoryId() ? "selected" : ""%>><%=esc(c.getName())%></option><% } %></select>
  <label>Mô tả</label><textarea name="description" rows="3" maxlength="500"><%=esc(d.getDescription())%></textarea>
  <label>Tên file ảnh</label><input type="text" name="image" value="<%=esc(d.getImage())%>">
  <label>Trạng thái</label>
  <select name="status"><option value="ACTIVE" <%="ACTIVE".equals(d.getStatus()) ? "selected" : ""%>>Đang bán</option>
    <option value="INACTIVE" <%="INACTIVE".equals(d.getStatus()) ? "selected" : ""%>>Ngừng bán</option></select>
  <p><button type="submit">Lưu thay đổi</button> <a class="btn gray" href="gdSearchDish0.jsp?keyword=">Hủy</a></p>
</form>
<%@ include file="../common/footer.jspf" %>
