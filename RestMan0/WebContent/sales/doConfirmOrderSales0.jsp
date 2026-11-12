<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="model.*, dao.*" %>
<% String REQUIRED_ROLE = "SALES"; %>
<%@ include file="../common/auth.jspf" %>
<%
    Member0 me = (Member0) session.getAttribute("member");
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        OrderDAO0 dao = new OrderDAO0();
        if ("1".equals(request.getParameter("cancel"))) dao.cancelOrder(id); else dao.confirmOrder(id, me.getId());
    } catch (Exception e) { }
    String d = request.getParameter("date") == null ? "" : request.getParameter("date").replaceAll("[^0-9-]", "");
    response.sendRedirect("gdReservationList0.jsp?date=" + d);
%>
