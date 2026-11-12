package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Order0;
import model.OrderItem0;

public class OrderDAO0 extends DAO0 {
    public OrderDAO0() { super(); }

    /**
     * [Module 2] Luu don goi mon truc tuyen trong 1 giao dich:
     * kiem tra lai dat ban con hop le -> them tblOrder0 (PENDING, ONLINE) -> them tblOrderItem0 (chot don gia hien tai).
     * Mon bi ngung ban / het nguyen lieu luc luu -> rollback, tra ve false. Thanh cong: order.id duoc gan.
     */
    public boolean saveOrder(Order0 order) {
        if (order == null || order.getItems().isEmpty()) return false;
        boolean owner = false;
        try {
            owner = beginTx();
            CallableStatement chk = con.prepareCall("{call sp_check_orderable0(?)}");
            chk.setInt(1, order.getReservationId());
            ResultSet r0 = chk.executeQuery();
            if (!(r0.next() && r0.getInt("cnt") > 0)) { rollbackTx(owner); return false; }

            CallableStatement ins = con.prepareCall("{call sp_insert_order0(?,?)}");
            ins.setInt(1, order.getReservationId()); ins.setString(2, order.getNote());
            ins.executeUpdate();
            ResultSet rs = con.prepareCall("{call sp_last_insert_id0()}").executeQuery();
            rs.next();
            int orderId = rs.getInt("id");

            for (OrderItem0 it : order.getItems()) {
                CallableStatement ci = con.prepareCall("{call sp_insert_order_item0(?,?,?,?)}");
                ci.setInt(1, orderId); ci.setInt(2, it.getMenuItemId()); ci.setInt(3, it.getQuantity()); ci.setString(4, it.getNote());
                if (ci.executeUpdate() == 0) { rollbackTx(owner); return false; }  // mon khong con ban duoc
            }
            commitTx(owner);
            order.setId(orderId);
            return true;
        } catch (Exception e) { e.printStackTrace(); rollbackTx(owner); }
        return false;
    }

    /** Cac don goi mon cua 1 dat ban (kem danh sach mon). Khong co -> null. */
    public ArrayList<Order0> getOrdersOfReservation(int reservationId) {
        ArrayList<Order0> list = new ArrayList<Order0>();
        try {
            CallableStatement cs = con.prepareCall("{call sp_get_orders_of_reservation0(?)}");
            cs.setInt(1, reservationId);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                Order0 o = new Order0();
                o.setId(rs.getInt("id")); o.setOrderTime(rs.getTimestamp("orderTime")); o.setChannel(rs.getString("channel"));
                o.setStatus(rs.getString("status")); o.setNote(rs.getString("note")); o.setReservationId(reservationId);
                o.setTotalAmount(rs.getDouble("totalAmount"));
                list.add(o);
            }
            for (Order0 o : list) o.setItems(getItems(o.getId()));
        } catch (Exception e) { e.printStackTrace(); }
        return list.isEmpty() ? null : list;
    }

    private ArrayList<OrderItem0> getItems(int orderId) throws Exception {
        ArrayList<OrderItem0> items = new ArrayList<OrderItem0>();
        CallableStatement cs = con.prepareCall("{call sp_get_order_items0(?)}");
        cs.setInt(1, orderId);
        ResultSet rs = cs.executeQuery();
        while (rs.next()) {
            OrderItem0 it = new OrderItem0();
            it.setId(rs.getInt("id")); it.setQuantity(rs.getInt("quantity")); it.setUnitPrice(rs.getDouble("unitPrice"));
            it.setStatus(rs.getString("status")); it.setNote(rs.getString("note"));
            it.setMenuItemId(rs.getInt("menuItemId")); it.setMenuItemName(rs.getString("menuItemName"));
            items.add(it);
        }
        return items;
    }

    /** [Nhan vien ban hang] Xac nhan don dang cho (PENDING -> CONFIRMED). */
    public boolean confirmOrder(int orderId, int staffId) {
        try {
            CallableStatement cs = con.prepareCall("{call sp_confirm_order0(?,?)}");
            cs.setInt(1, orderId); cs.setInt(2, staffId);
            return cs.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    /** Huy don dang cho (PENDING -> CANCELLED). */
    public boolean cancelOrder(int orderId) {
        try {
            CallableStatement cs = con.prepareCall("{call sp_cancel_order0(?)}");
            cs.setInt(1, orderId);
            return cs.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}
