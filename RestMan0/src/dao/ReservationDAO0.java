package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Reservation0;

public class ReservationDAO0 extends DAO0 {
    public ReservationDAO0() { super(); }

    private Reservation0 map(ResultSet rs) throws Exception {
        Reservation0 r = new Reservation0();
        r.setId(rs.getInt("id")); r.setReservationTime(rs.getTimestamp("reservationTime"));
        r.setGuestCount(rs.getInt("guestCount")); r.setGuestName(rs.getString("guestName"));
        r.setGuestPhone(rs.getString("guestPhone")); r.setChannel(rs.getString("channel"));
        r.setDeposit(rs.getDouble("deposit")); r.setStatus(rs.getString("status"));
        r.setNote(rs.getString("note")); r.setCreatedTime(rs.getTimestamp("createdTime"));
        r.setCustomerId(rs.getInt("customerId")); r.setTableCodes(rs.getString("tableCodes"));
        return r;
    }

    /** [Module 2] Cac dat ban cua khach (loc them theo ten / SDT nguoi dat, rong = bo loc). Khong co -> null. */
    public ArrayList<Reservation0> getReservationsOfCustomer(int customerId, String name, String phone) {
        ArrayList<Reservation0> list = new ArrayList<Reservation0>();
        try {
            CallableStatement cs = con.prepareCall("{call sp_get_reservations_of_customer0(?,?,?)}");
            cs.setInt(1, customerId);
            cs.setString(2, name == null ? "" : name.trim());
            cs.setString(3, phone == null ? "" : phone.trim());
            ResultSet rs = cs.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list.isEmpty() ? null : list;
    }

    public Reservation0 getReservationById(int id) {
        try {
            CallableStatement cs = con.prepareCall("{call sp_get_reservation0(?)}");
            cs.setInt(1, id);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) return map(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    /** [Module 2] Dat ban co the goi mon truc tuyen? (PENDING/CONFIRMED va chua qua gio den 30 phut) */
    public boolean checkOrderable(int reservationId) {
        try {
            CallableStatement cs = con.prepareCall("{call sp_check_orderable0(?)}");
            cs.setInt(1, reservationId);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) return rs.getInt("cnt") > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    /** [Nhan vien ban hang] Cac dat ban trong 1 ngay. Khong co -> null. */
    public ArrayList<Reservation0> getReservationsByDate(java.sql.Date date) {
        ArrayList<Reservation0> list = new ArrayList<Reservation0>();
        try {
            CallableStatement cs = con.prepareCall("{call sp_get_reservations_by_date0(?)}");
            cs.setDate(1, date);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list.isEmpty() ? null : list;
    }
}
