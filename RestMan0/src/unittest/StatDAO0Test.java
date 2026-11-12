package unittest;

import static org.junit.Assert.*;
import java.util.ArrayList;
import org.junit.Test;
import dao.StatDAO0;
import model.*;

public class StatDAO0Test extends BaseTest0 {
    private final StatDAO0 dao = new StatDAO0();
    private java.sql.Date d(int daysFromToday) { return new java.sql.Date(System.currentTimeMillis() + daysFromToday * 86400000L); }

    @Test public void testDishRevenue() {
        ArrayList<DishStat0> l = dao.statDishRevenue(d(-7), d(1));
        assertNotNull(l);
        assertEquals("Bò lúc lắc", l.get(0).getName());                    // 2 x 165000 = 330000 la cao nhat
        assertEquals(330000, l.get(0).getTotalRevenue(), 0.001);
    }
    @Test public void testDishRevenueEmptyRange() { assertNull(dao.statDishRevenue(d(-400), d(-390))); }
    @Test public void testCustomerStat() {
        ArrayList<CustomerStat0> l = dao.statCustomer(d(-7), d(7));
        assertNotNull(l); assertEquals("Nguyễn Văn An", l.get(0).getFullName());
        assertTrue(l.get(0).getTotalSpent() > 0);
    }
}
