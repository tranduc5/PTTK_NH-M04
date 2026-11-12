<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="model.*, dao.*" %>
<% request.setCharacterEncoding("UTF-8"); String REQUIRED_ROLE = "CUSTOMER"; %>
<%@ include file="../common/auth.jspf" %>
<%
    Order0 cart = (Order0) session.getAttribute("cart");
    if (cart == null) { response.sendRedirect("gdFindReservation0.jsp"); return; }
    int id = 0, qty = 0;
    try { id = Integer.parseInt(request.getParameter("id")); qty = Integer.parseInt(request.getParameter("quantity")); } catch (Exception e) { }
    if (qty < 1 || qty > 50) { response.sendRedirect("gdEnterQuantity0.jsp?id=" + id + "&err=1"); return; }
    Dish0 d = new DishDAO0().getDishById(id);
    if (d == null || !"ACTIVE".equals(d.getStatus()) || !d.isAvailable()) { response.sendRedirect("gdSearchDishOrder0.jsp"); return; }
    OrderItem0 it = new OrderItem0();
    it.setMenuItemId(d.getId()); it.setMenuItemName(d.getName()); it.setUnitPrice(d.getPrice());
    it.setQuantity(qty); it.setNote(request.getParameter("note"));
    cart.addItem(it);
    response.sendRedirect("gdOrder0.jsp?rid=" + cart.getReservationId() + "&added=1");
%>
