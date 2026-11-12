package dao;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Lop DAO0 co so (theo giao trinh chuong 5): giu ket noi CSDL dung chung.
 * Cac DAO con ke thua va goi stored procedure qua CallableStatement.
 */
public class DAO0 {
    public static Connection con;

    // Co the doi bang -Drestman.url=... -Drestman.user=... -Drestman.pass=...
    private static final String URL = System.getProperty("restman.url",
            "jdbc:mysql://localhost:3306/restman0?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Ho_Chi_Minh");
    private static final String USER = System.getProperty("restman.user", "root");
    private static final String PASS = System.getProperty("restman.pass", "12345");

    public DAO0() {
        try {
            if (con == null || con.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(URL, USER, PASS);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private java.sql.Savepoint savepoint;

    /**
     * Bat dau giao dich. Tra ve true neu DAO nay "so huu" giao dich (ket noi dang auto-commit).
     * Neu nguoi goi (vd. unit test) da tat auto-commit de tu rollback, DAO chi dat savepoint.
     */
    protected boolean beginTx() throws Exception {
        if (con.getAutoCommit()) { con.setAutoCommit(false); savepoint = null; return true; }
        savepoint = con.setSavepoint();
        return false;
    }
    protected void commitTx(boolean owner) throws Exception {
        if (owner) { con.commit(); con.setAutoCommit(true); }
    }
    protected void rollbackTx(boolean owner) {
        try {
            if (owner) { con.rollback(); con.setAutoCommit(true); }
            else if (savepoint != null) con.rollback(savepoint);
        } catch (Exception ex) { ex.printStackTrace(); }
    }

    /** Ma hoa mat khau SHA-256 (hex) - khop voi du lieu mau. */
    public static String sha256(String s) {
        try {
            byte[] h = MessageDigest.getInstance("SHA-256").digest(s.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : h) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (Exception e) { throw new RuntimeException(e); }
    }
}
