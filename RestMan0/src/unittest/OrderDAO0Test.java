package unittest;

import static org.junit.Assert.*;
import java.util.ArrayList;
import org.junit.Test;
import dao.OrderDAO0;
import model.Order0;
import model.OrderItem0;

/** Test module "Order dish online 0" - luu don goi mon. */
public class OrderDAO0Test extends BaseTest0 {
    private final OrderDAO0 dao = new OrderDAO0();

    private OrderItem0 item(int menuItemId, int qty) {
        OrderItem0 it = new OrderItem0(); it.setMenuItemId(menuItemId); it.setQuantity(qty); return it;
    }
    private Order0 order(int reservationId, OrderItem0... items) {
        Order0 o = new Order0(); o.setReservationId(reservationId);
        for (OrderItem0 it : items) o.addItem(it);
        return o;
    }
    private int countOrders(int reservationId) {
        ArrayList<Order0> l = dao.getOrdersOfReservation(reservationId);
        return l == null ? 0 : l.size();
    }

    @Test public void testSaveOrderOk() {
        Order0 o = order(1, item(2, 2), item(5, 1));
        o.setNote("Ít cay");
        assertTrue(dao.saveOrder(o)); assertTrue(o.getId() > 0);
        ArrayList<Order0> l = dao.getOrdersOfReservation(1);
        assertEquals(2, l.size());                              // don mau san co + don moi
        Order0 saved = null; for (Order0 x : l) if (x.getId() == o.getId()) saved = x;
        assertNotNull(saved);
        assertEquals("PENDING", saved.getStatus()); assertEquals("ONLINE", saved.getChannel());
        assertEquals(2, saved.getItems().size());
        assertEquals(2 * 165000 + 35000, saved.getTotalAmount(), 0.001);
        for (OrderItem0 it : saved.getItems()) if (it.getMenuItemId() == 2) assertEquals(165000, it.getUnitPrice(), 0.001);
    }
    @Test public void testSaveOrderOnPendingReservation() { assertTrue(dao.saveOrder(order(4, item(1, 3)))); }
    @Test public void testSaveOrderReservationCompleted() {
        assertFalse(dao.saveOrder(order(2, item(2, 1)))); assertEquals(1, countOrders(2));   // khong them don moi
    }
    @Test public void testSaveOrderReservationCancelled() { assertFalse(dao.saveOrder(order(5, item(2, 1)))); }
    @Test public void testSaveOrderEmpty() { assertFalse(dao.saveOrder(order(1))); }
    @Test public void testSaveOrderNull()  { assertFalse(dao.saveOrder(null)); }
    @Test public void testSaveOrderInactiveDishRollsBack() {
        int before = countOrders(1);
        assertFalse(dao.saveOrder(order(1, item(2, 1), item(7, 1))));   // mon 7 ngung ban -> ca don bi huy
        assertEquals(before, countOrders(1));
    }
    @Test public void testSaveOrderOutOfStockRollsBack() {
        int before = countOrders(1);
        assertFalse(dao.saveOrder(order(1, item(1, 1), item(3, 1))));   // Ca hoi het nguyen lieu
        assertEquals(before, countOrders(1));
    }
    @Test public void testSaveOrderQuantityExceedsStock() {
        assertFalse(dao.saveOrder(order(1, item(2, 100))));              // 100 x 0.2kg > ton 15kg
    }
    @Test public void testPriceSnapshotNotAffectedByLaterPriceChange() throws Exception {
        Order0 o = order(1, item(5, 1)); assertTrue(dao.saveOrder(o));
        dao.con.createStatement().executeUpdate("UPDATE tblMenuItem0 SET price = 99000 WHERE id = 5");
        for (Order0 x : dao.getOrdersOfReservation(1)) if (x.getId() == o.getId())
            assertEquals(35000, x.getItems().get(0).getUnitPrice(), 0.001);
    }
    @Test public void testConfirmAndCancel() {
        assertTrue(dao.confirmOrder(2, 3));  assertFalse(dao.confirmOrder(2, 3));   // chi xac nhan duoc 1 lan
        assertFalse(dao.cancelOrder(2));                                             // da CONFIRMED -> khong huy duoc
    }

    // ---- model Order0
    @Test public void testAddItemMergesSameDish() {
        Order0 o = order(1, item(2, 1)); o.addItem(item(2, 2));
        assertEquals(1, o.getItems().size()); assertEquals(3, o.getItems().get(0).getQuantity());
    }
    @Test public void testRemoveItemAndTotal() {
        OrderItem0 a = item(2, 2); a.setUnitPrice(100);
        OrderItem0 b = item(5, 1); b.setUnitPrice(50);
        Order0 o = order(1, a, b);
        assertEquals(250, o.calcTotal(), 0.001);
        o.removeItem(2); assertEquals(50, o.calcTotal(), 0.001);
    }
}
