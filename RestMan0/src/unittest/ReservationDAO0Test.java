package unittest;

import static org.junit.Assert.*;
import java.util.ArrayList;
import org.junit.Test;
import dao.ReservationDAO0;
import model.Reservation0;

/** Test module "Order dish online 0" - buoc tim dat ban cua khach. */
public class ReservationDAO0Test extends BaseTest0 {
    private final ReservationDAO0 dao = new ReservationDAO0();

    @Test public void testGetAllOfCustomer() {
        ArrayList<Reservation0> l = dao.getReservationsOfCustomer(4, "", "");
        assertNotNull(l); assertEquals(5, l.size());
        for (Reservation0 r : l) assertEquals(4, r.getCustomerId());
    }
    @Test public void testFilterByName()  { assertEquals(5, dao.getReservationsOfCustomer(4, "Văn An", "").size()); }
    @Test public void testFilterByPhone() { assertEquals(5, dao.getReservationsOfCustomer(4, "", "0901").size()); }
    @Test public void testNoMatch()       { assertNull(dao.getReservationsOfCustomer(4, "Không ai", "")); }
    @Test public void testCannotSeeOthersReservation() {
        ArrayList<Reservation0> l = dao.getReservationsOfCustomer(5, "", "");
        assertEquals(1, l.size()); assertEquals(4, l.get(0).getId());
    }
    @Test public void testTableCodes() { assertEquals("T01,T02", dao.getReservationById(1).getTableCodes().replace(" ", "")); }
    @Test public void testGetByIdNotFound() { assertNull(dao.getReservationById(9999)); }

    @Test public void testOrderableConfirmed()          { assertTrue(dao.checkOrderable(1)); }
    @Test public void testOrderableWithinGracePeriod()  { assertTrue(dao.checkOrderable(3)); }   // den muon 10 phut
    @Test public void testOrderablePending()            { assertTrue(dao.checkOrderable(4)); }
    @Test public void testNotOrderableCompleted()       { assertFalse(dao.checkOrderable(2)); }
    @Test public void testNotOrderableCancelled()       { assertFalse(dao.checkOrderable(5)); }
    @Test public void testNotOrderableSeated()          { assertFalse(dao.checkOrderable(6)); }
    @Test public void testNotOrderableUnknown()         { assertFalse(dao.checkOrderable(9999)); }
}
