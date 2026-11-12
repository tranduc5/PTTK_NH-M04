<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% String REQUIRED_ROLE = "MANAGER"; %>
<%@ include file="../common/header.jspf" %>
<%@ include file="../common/auth.jspf" %>
<h1>Trang chủ quản lý</h1>
<div class="card"><h3>Quản lý thực đơn</h3><p>Tìm kiếm và sửa thông tin món ăn.</p><a class="btn" href="gdDishMenu0.jsp">Mở</a></div>
<div class="card"><h3>Thống kê món ăn</h3><p>Doanh thu theo món.</p><a class="btn" href="gdStatDish0.jsp">Mở</a></div>
<div class="card"><h3>Thống kê khách hàng</h3><p>Khách đặt bàn / chi tiêu.</p><a class="btn" href="gdStatCustomer0.jsp">Mở</a></div>
<%@ include file="../common/footer.jspf" %>
