<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="model.*, dao.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    Member0 m = new Member0();
    m.setUsername(request.getParameter("username") == null ? "" : request.getParameter("username").trim());
    m.setPassword(request.getParameter("password") == null ? "" : request.getParameter("password"));
    System.out.println("========== LOGIN CHECK ==========");
System.out.println("Username: [" + m.getUsername() + "]");
System.out.println("Password is null: " + (m.getPassword() == null));
System.out.println("Password length: "
        + (m.getPassword() == null ? -1 : m.getPassword().length()));
System.out.println("Java SHA256: " + DAO0.sha256(m.getPassword()));

MemberDAO0 dao = new MemberDAO0();
String role = dao.checkLogin(m);

System.out.println("Returned role: " + role);
System.out.println("=================================");

if (role == null) {
    response.sendRedirect("gdLogin0.jsp?err=1");
    return;
}
    session.invalidate();
    session = request.getSession(true);
    session.setAttribute("member", m);
    session.setAttribute("role", role);
    String home = "MANAGER".equals(role) ? "manager/gdManagerHome0.jsp"
                : "CUSTOMER".equals(role) ? "customer/gdCustomerHome0.jsp"
                : "WAREHOUSE".equals(role) ? "warehouse/gdWarehouseHome0.jsp" : "sales/gdSalesHome0.jsp";
    response.sendRedirect(home);
%>
