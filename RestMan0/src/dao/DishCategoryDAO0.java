package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.DishCategory0;

public class DishCategoryDAO0 extends DAO0 {
    public DishCategoryDAO0() { super(); }

    /** Lay moi nhom mon (sap theo ten). Khong co -> null. */
    public ArrayList<DishCategory0> getAllCategories() {
        ArrayList<DishCategory0> list = new ArrayList<DishCategory0>();
        try {
            CallableStatement cs = con.prepareCall("{call sp_get_all_categories0()}");
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                DishCategory0 c = new DishCategory0();
                c.setId(rs.getInt("id")); c.setName(rs.getString("name")); c.setDescription(rs.getString("description"));
                list.add(c);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list.isEmpty() ? null : list;
    }
}
