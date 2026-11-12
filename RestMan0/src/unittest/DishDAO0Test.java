package unittest;

import static org.junit.Assert.*;
import java.util.ArrayList;
import org.junit.Test;
import dao.DishDAO0;
import model.Dish0;

/** Test module "Edit dish information 0". */
public class DishDAO0Test extends BaseTest0 {
    private final DishDAO0 dao = new DishDAO0();

    // ---- searchDishByName
    @Test public void testSearchFound() {
        ArrayList<Dish0> l = dao.searchDishByName("bò");
        assertNotNull(l); assertEquals(1, l.size()); assertEquals("Bò lúc lắc", l.get(0).getName());
    }
    @Test public void testSearchAllWhenEmptyKeyword() {
        ArrayList<Dish0> l = dao.searchDishByName("");
        assertNotNull(l); assertEquals(7, l.size());          // 7 mon don (combo khong nam trong danh sach sua mon)
    }
    @Test public void testSearchNotFound() { assertNull(dao.searchDishByName("khong-co-mon-nay")); }

    // ---- getDishById
    @Test public void testGetDishById() {
        Dish0 d = dao.getDishById(2);
        assertNotNull(d); assertEquals("Bò lúc lắc", d.getName()); assertEquals(165000, d.getPrice(), 0.001);
        assertEquals("Món chính", d.getCategoryName()); assertTrue(d.isAvailable());
    }
    @Test public void testGetDishByIdNotFound() { assertNull(dao.getDishById(9999)); }
    @Test public void testAvailabilityFalseWhenIngredientShort() { assertFalse(dao.getDishById(3).isAvailable()); } // Ca hoi: ton 0.1 < 0.25

    // ---- isNameExist
    @Test public void testNameExistCaseInsensitive() { assertTrue(dao.isNameExist("BÒ LÚC LẮC", 0)); }
    @Test public void testNameNotExistWhenOwnId()    { assertFalse(dao.isNameExist("Bò lúc lắc", 2)); }
    @Test public void testNameNotExist()             { assertFalse(dao.isNameExist("Mon moi hoan toan", 0)); }

    // ---- updateDish
    @Test public void testUpdateDishOk() {
        Dish0 d = dao.getDishById(2);
        d.setName("Bò lúc lắc đặc biệt"); d.setPrice(175000); d.setDescription("Mô tả mới"); d.setCategoryId(1);
        assertEquals(DishDAO0.UPDATE_OK, dao.updateDish(d));
        Dish0 r = dao.getDishById(2);
        assertEquals("Bò lúc lắc đặc biệt", r.getName()); assertEquals(175000, r.getPrice(), 0.001);
        assertEquals(1, r.getCategoryId()); assertEquals("Mô tả mới", r.getDescription());
    }
    @Test public void testUpdateDishToInactive() {
        Dish0 d = dao.getDishById(1); d.setStatus("INACTIVE");
        assertEquals(DishDAO0.UPDATE_OK, dao.updateDish(d));
        assertEquals("INACTIVE", dao.getDishById(1).getStatus());
        ArrayList<Dish0> forOrder = dao.searchDishesForOrder("Gỏi cuốn", 0);
        assertNull(forOrder);                                  // mon ngung ban khong hien trong man hinh dat mon
    }
    @Test public void testUpdateDishConflict() {
        Dish0 a = dao.getDishById(5);          // hai quan ly cung mo form
        Dish0 b = dao.getDishById(5);
        a.setPrice(40000);
        assertEquals(DishDAO0.UPDATE_OK, dao.updateDish(a));
        b.setPrice(50000);                      // b giu updatedTime cu
        assertEquals(DishDAO0.UPDATE_CONFLICT, dao.updateDish(b));
        assertEquals(40000, dao.getDishById(5).getPrice(), 0.001);   // khong bi ghi de
    }
    @Test public void testUpdateDishNotExist() {
        Dish0 d = dao.getDishById(1); d.setId(9999);
        assertEquals(DishDAO0.UPDATE_CONFLICT, dao.updateDish(d));
    }

    // ---- searchDishesForOrder (module 2)
    @Test public void testSearchForOrderHidesInactive() {
        ArrayList<Dish0> l = dao.searchDishesForOrder("", 0);
        assertNotNull(l); assertEquals(6, l.size());
        for (Dish0 d : l) assertEquals("ACTIVE", d.getStatus());
    }
    @Test public void testSearchForOrderByCategory() {
        ArrayList<Dish0> l = dao.searchDishesForOrder("", 3);
        assertNotNull(l); assertEquals(1, l.size()); assertEquals("Trà đào cam sả", l.get(0).getName());
    }
}
