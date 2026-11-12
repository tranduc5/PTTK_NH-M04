package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Dish0;

/** DAO mon an: dung cho module "Edit dish information 0" va "Order dish online 0". */
public class DishDAO0 extends DAO0 {
    public static final int UPDATE_OK = 1;
    public static final int UPDATE_CONFLICT = 0;   // da bi nguoi khac sua truoc (updatedTime khac)
    public static final int UPDATE_ERROR = -1;

    public DishDAO0() { super(); }

    private Dish0 map(ResultSet rs) throws Exception {
        Dish0 d = new Dish0();
        d.setId(rs.getInt("id")); d.setName(rs.getString("name")); d.setPrice(rs.getDouble("price"));
        d.setDescription(rs.getString("description")); d.setImage(rs.getString("image"));
        d.setStatus(rs.getString("status")); d.setUpdatedTime(rs.getTimestamp("updatedTime"));
        d.setCategoryId(rs.getInt("categoryId")); d.setCategoryName(rs.getString("categoryName"));
        d.setAvailable(rs.getInt("available") == 1);
        return d;
    }
    private ArrayList<Dish0> mapList(ResultSet rs) throws Exception {
        ArrayList<Dish0> list = new ArrayList<Dish0>();
        while (rs.next()) list.add(map(rs));
        return list.isEmpty() ? null : list;
    }

    /** [Module 1] Tim mon theo tu khoa trong ten (rong = tat ca). Khong co -> null. */
    public ArrayList<Dish0> searchDishByName(String keyword) {
        try {
            CallableStatement cs = con.prepareCall("{call sp_search_dish0(?)}");
            cs.setString(1, keyword == null ? "" : keyword.trim());
            return mapList(cs.executeQuery());
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    /** [Module 1] Lay chi tiet mon theo id; khong co -> null. */
    public Dish0 getDishById(int id) {
        try {
            CallableStatement cs = con.prepareCall("{call sp_get_dish0(?)}");
            cs.setInt(1, id);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) return map(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    /** [Module 1] Ten mon da ton tai o mon khac chua (khong phan biet hoa/thuong)? */
    public boolean isNameExist(String name, int excludeId) {
        try {
            CallableStatement cs = con.prepareCall("{call sp_count_dish_name0(?,?)}");
            cs.setString(1, name.trim()); cs.setInt(2, excludeId);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) return rs.getInt("cnt") > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    /**
     * [Module 1] Cap nhat mon (khoa lac quan theo updatedTime: dish.getUpdatedTime() la gia tri luc nap form).
     * @return UPDATE_OK / UPDATE_CONFLICT / UPDATE_ERROR
     */
    public int updateDish(Dish0 d) {
        boolean owner = false;
        try {
            owner = beginTx();
            CallableStatement cs = con.prepareCall("{call sp_update_menuitem0(?,?,?,?,?,?,?)}");
            cs.setInt(1, d.getId()); cs.setString(2, d.getName().trim()); cs.setDouble(3, d.getPrice());
            cs.setString(4, d.getDescription()); cs.setString(5, d.getImage()); cs.setString(6, d.getStatus());
            cs.setTimestamp(7, d.getUpdatedTime());
            if (cs.executeUpdate() == 0) { rollbackTx(owner); return UPDATE_CONFLICT; }
            CallableStatement cs2 = con.prepareCall("{call sp_update_dish_category0(?,?)}");
            cs2.setInt(1, d.getId()); cs2.setInt(2, d.getCategoryId());
            cs2.executeUpdate();
            commitTx(owner);
            return UPDATE_OK;
        } catch (Exception e) { e.printStackTrace(); rollbackTx(owner); }
        return UPDATE_ERROR;
    }

    /** [Module 2] Tim mon dang ban de dat (keyword, categoryId; 0 = moi nhom). Khong co -> null. */
    public ArrayList<Dish0> searchDishesForOrder(String keyword, int categoryId) {
        try {
            CallableStatement cs = con.prepareCall("{call sp_search_dish_for_order0(?,?)}");
            cs.setString(1, keyword == null ? "" : keyword.trim()); cs.setInt(2, categoryId);
            return mapList(cs.executeQuery());
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}
