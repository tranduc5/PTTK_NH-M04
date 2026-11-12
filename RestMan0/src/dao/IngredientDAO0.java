package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.ImportDetail0;
import model.ImportReceipt0;
import model.Ingredient0;
import model.Supplier0;

/** DAO kho: nguyen lieu, nha cung cap, phieu nhap. */
public class IngredientDAO0 extends DAO0 {
    public IngredientDAO0() { super(); }

    public ArrayList<Ingredient0> getAllIngredients() {
        ArrayList<Ingredient0> list = new ArrayList<Ingredient0>();
        try {
            ResultSet rs = con.prepareCall("{call sp_get_all_ingredients0()}").executeQuery();
            while (rs.next()) {
                Ingredient0 i = new Ingredient0();
                i.setId(rs.getInt("id")); i.setName(rs.getString("name")); i.setUnit(rs.getString("unit"));
                i.setStockQuantity(rs.getDouble("stockQuantity")); i.setMinStock(rs.getDouble("minStock"));
                i.setDescription(rs.getString("description"));
                list.add(i);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list.isEmpty() ? null : list;
    }

    public ArrayList<Supplier0> getAllSuppliers() {
        ArrayList<Supplier0> list = new ArrayList<Supplier0>();
        try {
            ResultSet rs = con.prepareCall("{call sp_get_all_suppliers0()}").executeQuery();
            while (rs.next()) {
                Supplier0 s = new Supplier0();
                s.setId(rs.getInt("id")); s.setName(rs.getString("name")); s.setAddress(rs.getString("address"));
                s.setPhone(rs.getString("phone")); s.setEmail(rs.getString("email")); s.setNote(rs.getString("note"));
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list.isEmpty() ? null : list;
    }

    /** Luu phieu nhap (+ chi tiet) va cong ton kho trong 1 giao dich. */
    public boolean saveImportReceipt(ImportReceipt0 receipt) {
        if (receipt == null || receipt.getDetails().isEmpty()) return false;
        boolean owner = false;
        try {
            owner = beginTx();
            CallableStatement ins = con.prepareCall("{call sp_insert_import_receipt0(?,?,?)}");
            ins.setInt(1, receipt.getSupplierId()); ins.setInt(2, receipt.getStaffId()); ins.setString(3, receipt.getNote());
            ins.executeUpdate();
            ResultSet rs = con.prepareCall("{call sp_last_insert_id0()}").executeQuery();
            rs.next();
            int id = rs.getInt("id");
            for (ImportDetail0 d : receipt.getDetails()) {
                if (d.getQuantity() <= 0 || d.getUnitPrice() < 0) { rollbackTx(owner); return false; }
                CallableStatement cd = con.prepareCall("{call sp_insert_import_detail0(?,?,?,?)}");
                cd.setInt(1, id); cd.setInt(2, d.getIngredientId()); cd.setDouble(3, d.getQuantity()); cd.setDouble(4, d.getUnitPrice());
                cd.executeUpdate();
                CallableStatement st = con.prepareCall("{call sp_add_stock0(?,?)}");
                st.setInt(1, d.getIngredientId()); st.setDouble(2, d.getQuantity());
                if (st.executeUpdate() == 0) { rollbackTx(owner); return false; }
            }
            commitTx(owner);
            receipt.setId(id);
            return true;
        } catch (Exception e) { e.printStackTrace(); rollbackTx(owner); }
        return false;
    }

    public ArrayList<ImportReceipt0> getRecentReceipts(int limit) {
        ArrayList<ImportReceipt0> list = new ArrayList<ImportReceipt0>();
        try {
            CallableStatement cs = con.prepareCall("{call sp_get_recent_receipts0(?)}");
            cs.setInt(1, limit);
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                ImportReceipt0 r = new ImportReceipt0();
                r.setId(rs.getInt("id")); r.setImportDate(rs.getTimestamp("importDate")); r.setNote(rs.getString("note"));
                r.setSupplierName(rs.getString("supplierName")); r.setTotalAmount(rs.getDouble("totalAmount"));
                list.add(r);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list.isEmpty() ? null : list;
    }
}
