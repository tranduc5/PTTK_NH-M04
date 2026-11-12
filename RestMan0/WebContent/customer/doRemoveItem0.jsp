<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="model.*, dao.*" %>
<% String REQUIRED_ROLE = "CUSTOMER"; %>
<%@ include file="../common/auth.jspf" %>
<%
    Order0 cart = (Order0) session.getAttribute("cart");
    if (cart == null) { response.sendRedirect("gdFindReservation0.jsp"); return; }
    try { cart.removeItem(Integer.parseInt(request.getParameter("menuItemId"))); } catch (Exception e) { }
    response.sendRedirect("gdOrder0.jsp?rid=" + cart.getReservationId());
%>
