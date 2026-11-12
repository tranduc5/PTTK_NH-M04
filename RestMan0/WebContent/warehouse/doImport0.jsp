<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="model.*, dao.*" %>
<% request.setCharacterEncoding("UTF-8"); String REQUIRED_ROLE = "WAREHOUSE"; %>
<%@ include file="../common/auth.jspf" %>
<%
    Member0 me = (Member0) session.getAttribute("member");
    boolean ok = false;
    try {
        ImportReceipt0 r = new ImportReceipt0();
        r.setSupplierId(Integer.parseInt(request.getParameter("supplierId")));
        r.setStaffId(me.getId()); r.setNote(request.getParameter("note"));
        String[] ids = request.getParameterValues("ingId"), qs = request.getParameterValues("qty"), ps = request.getParameterValues("price");
        for (int i = 0; i < ids.length; i++) {
            double q = Double.parseDouble(qs[i]);
            if (q <= 0) continue;                       // bo qua dong khong nhap
            ImportDetail0 d = new ImportDetail0();
            d.setIngredientId(Integer.parseInt(ids[i])); d.setQuantity(q); d.setUnitPrice(Double.parseDouble(ps[i]));
            r.addDetail(d);
        }
        ok = new IngredientDAO0().saveImportReceipt(r);
    } catch (Exception e) { ok = false; }
    response.sendRedirect(ok ? "gdIngredientList0.jsp?saved=1" : "gdImport0.jsp?err=1");
%>
