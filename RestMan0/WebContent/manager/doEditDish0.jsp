<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="model.*, dao.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String REQUIRED_ROLE = "MANAGER";
%>
<%@ include file="../common/auth.jspf" %>
<%
    Dish0 d = new Dish0();
    String err = null;
    int id = 0;
    try {
        id = Integer.parseInt(request.getParameter("id"));
        d.setId(id);
        d.setUpdatedTime(new java.sql.Timestamp(Long.parseLong(request.getParameter("updatedTime"))));
        d.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
    } catch (Exception e) { err = "Dữ liệu gửi lên không hợp lệ."; }
    d.setName(request.getParameter("name") == null ? "" : request.getParameter("name").trim());
    d.setDescription(request.getParameter("description"));
    d.setImage(request.getParameter("image"));
    d.setStatus("INACTIVE".equals(request.getParameter("status")) ? "INACTIVE" : "ACTIVE");
    try {
        d.setPrice(Double.parseDouble(request.getParameter("price")));
        if (d.getPrice() <= 0) err = "Giá món phải lớn hơn 0.";
    } catch (Exception e) { if (err == null) err = "Giá món phải là số."; }

    DishDAO0 dao = new DishDAO0();
    if (err == null && d.getName().isEmpty()) err = "Tên món không được để trống.";
    if (err == null && d.getName().length() > 150) err = "Tên món tối đa 150 ký tự.";
    if (err == null && dao.isNameExist(d.getName(), d.getId())) err = "Tên món đã tồn tại, vui lòng chọn tên khác.";
    if (err == null) {
        int rc = dao.updateDish(d);
        if (rc == DishDAO0.UPDATE_OK) { response.sendRedirect("gdSearchDish0.jsp?keyword=&saved=1"); return; }
        err = rc == DishDAO0.UPDATE_CONFLICT
            ? "Món ăn vừa được người khác thay đổi (hoặc không còn tồn tại). Vui lòng mở lại để xem dữ liệu mới nhất."
            : "Lỗi hệ thống khi lưu, vui lòng thử lại.";
        if (rc == DishDAO0.UPDATE_CONFLICT) { session.setAttribute("editError", err); response.sendRedirect("gdEditDish0.jsp?id=" + id); return; }
    }
    session.setAttribute("editForm", d);
    session.setAttribute("editError", err);
    response.sendRedirect("gdEditDish0.jsp?id=" + id);
%>
