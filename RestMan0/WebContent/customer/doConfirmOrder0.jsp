<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="model.*, dao.*" %>
<% request.setCharacterEncoding("UTF-8"); String REQUIRED_ROLE = "CUSTOMER"; %>
<%@ include file="../common/auth.jspf" %>
<%
    Order0 cart = (Order0) session.getAttribute("cart");
    Member0 me = (Member0) session.getAttribute("member");
    if (cart == null || cart.getItems().isEmpty()) { response.sendRedirect("gdFindReservation0.jsp"); return; }
    Reservation0 res = new ReservationDAO0().getReservationById(cart.getReservationId());
    if (res == null || res.getCustomerId() != me.getId()) { session.removeAttribute("cart"); response.sendRedirect("gdFindReservation0.jsp?err=1"); return; }
    cart.setNote(request.getParameter("note"));
    if (new OrderDAO0().saveOrder(cart)) {
        int rid = cart.getReservationId();
        session.removeAttribute("cart");
        response.sendRedirect("gdMyOrders0.jsp?rid=" + rid + "&ok=1");
    } else {
        response.sendRedirect("gdOrder0.jsp?rid=" + cart.getReservationId() + "&err=1");
    }
%>
