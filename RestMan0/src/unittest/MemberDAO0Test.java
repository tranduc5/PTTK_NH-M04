package unittest;

import static org.junit.Assert.*;
import org.junit.Test;
import dao.MemberDAO0;
import model.Member0;

public class MemberDAO0Test extends BaseTest0 {
    private String login(String u, String p) {
        Member0 m = new Member0(); m.setUsername(u); m.setPassword(p);
        return new MemberDAO0().checkLogin(m);
    }
    @Test public void testManagerLogin()   { assertEquals("MANAGER", login("manager0", "123456")); }
    @Test public void testCustomerLogin()  { assertEquals("CUSTOMER", login("customer0", "123456")); }
    @Test public void testWarehouseLogin() { assertEquals("WAREHOUSE", login("warehouse0", "123456")); }
    @Test public void testSalesLogin()     { assertEquals("SALES", login("sales0", "123456")); }
    @Test public void testWrongPassword()  { assertNull(login("manager0", "sai-mat-khau")); }
    @Test public void testUnknownUser()    { assertNull(login("khongtontai", "123456")); }
    @Test public void testSqlInjectionIsHarmless() { assertNull(login("' OR '1'='1", "x")); }
}
