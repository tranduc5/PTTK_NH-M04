<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "WAREHOUSE"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<h1>Trang chủ nhân viên kho</h1>
<div class="card"><h3>Tồn kho nguyên liệu</h3><a class="btn" href="gdIngredientList0.jsp">Xem</a></div>
<div class="card"><h3>Lập phiếu nhập</h3><a class="btn" href="gdImport0.jsp">Nhập kho</a></div>
<%@ include file="../common/footer.jspf" %>
