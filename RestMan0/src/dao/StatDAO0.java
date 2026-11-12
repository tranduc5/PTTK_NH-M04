package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.CustomerStat0;
import model.DishStat0;

/** DAO thong ke cho quan ly. */
public class StatDAO0 extends DAO0 {
    public StatDAO0() { super(); }

    public ArrayList<DishStat0> statDishRevenue(java.sql.Date from, java.sql.Date to) {
        ArrayList<DishStat0> list = new ArrayList<DishStat0>();
        try {
            CallableStatement cs = con.prepareCall("{call sp_stat_dish_revenue0(?,?)}");
            cs.setDate(1, from); cs.setDate(2, to);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                DishStat0 s = new DishStat0();
                s.setId(rs.getInt("id")); s.setName(rs.getString("name"));
                s.setTotalQuantity(rs.getInt("totalQuantity")); s.setTotalRevenue(rs.getDouble("totalRevenue"));
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list.isEmpty() ? null : list;
    }

    public ArrayList<CustomerStat0> statCustomer(java.sql.Date from, java.sql.Date to) {
        ArrayList<CustomerStat0> list = new ArrayList<CustomerStat0>();
        try {
            CallableStatement cs = con.prepareCall("{call sp_stat_customer0(?,?)}");
            cs.setDate(1, from); cs.setDate(2, to);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                CustomerStat0 s = new CustomerStat0();
                s.setId(rs.getInt("id")); s.setFullName(rs.getString("fullName"));
                s.setReservationCount(rs.getInt("reservationCount")); s.setTotalSpent(rs.getDouble("totalSpent"));
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list.isEmpty() ? null : list;
    }
}
