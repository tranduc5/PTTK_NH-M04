package unittest;

import static org.junit.Assert.*;
import java.util.ArrayList;
import org.junit.Test;
import dao.IngredientDAO0;
import model.*;

public class IngredientDAO0Test extends BaseTest0 {
    private final IngredientDAO0 dao = new IngredientDAO0();

    private double stock(int id) { for (Ingredient0 i : dao.getAllIngredients()) if (i.getId() == id) return i.getStockQuantity(); return -1; }
    private ImportReceipt0 receipt(double qty, double price, int ingredientId) {
        ImportReceipt0 r = new ImportReceipt0(); r.setSupplierId(1); r.setStaffId(2); r.setNote("test");
        ImportDetail0 d = new ImportDetail0(); d.setIngredientId(ingredientId); d.setQuantity(qty); d.setUnitPrice(price);
        r.addDetail(d); return r;
    }
    @Test public void testListIngredientsAndSuppliers() {
        assertEquals(5, dao.getAllIngredients().size()); assertEquals(2, dao.getAllSuppliers().size());
    }
    @Test public void testImportIncreasesStock() {
        double before = stock(3);
        assertTrue(dao.saveImportReceipt(receipt(5, 300000, 3)));
        assertEquals(before + 5, stock(3), 0.0001);
        assertEquals(1 + 1, dao.getRecentReceipts(10).size());
    }
    @Test public void testImportInvalidQuantity() {
        double before = stock(3);
        assertFalse(dao.saveImportReceipt(receipt(0, 1000, 3)));
        assertEquals(before, stock(3), 0.0001);
    }
    @Test public void testImportUnknownIngredientRollsBack() {
        ImportReceipt0 r = receipt(2, 1000, 9999);
        assertFalse(dao.saveImportReceipt(r));
        assertEquals(1, dao.getRecentReceipts(10).size());
    }
    @Test public void testImportEmpty() { assertFalse(dao.saveImportReceipt(new ImportReceipt0())); }
}
