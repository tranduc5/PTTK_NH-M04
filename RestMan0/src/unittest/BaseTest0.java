package unittest;

import org.junit.After;
import org.junit.Before;
import dao.DAO0;

/** Lop co so cho cac unit test: mo giao dich truoc moi test, rollback sau test de CSDL khong bi thay doi. */
public abstract class BaseTest0 {
    @Before
    public void openTx() throws Exception {
        new DAO0();                       // bao dam da co ket noi
        DAO0.con.setAutoCommit(false);
    }
    @After
    public void rollbackTx() throws Exception {
        DAO0.con.rollback();
        DAO0.con.setAutoCommit(true);
    }
}
