//package dao;
//
//import java.sql.CallableStatement;
//import java.sql.ResultSet;
//import model.Member0;
//
//public class MemberDAO0 extends DAO0 {
//    public MemberDAO0() { super(); }
//
//    /** Kiem tra dang nhap. Thanh cong: dien id, fullName... va tra ve vai tro (MANAGER/WAREHOUSE/SALES/CUSTOMER); that bai: null. */
//    public String checkLogin(Member0 m) {
//        try {
//            CallableStatement cs = con.prepareCall("{call sp_check_login0(?,?)}");
//            cs.setString(1, m.getUsername());
//            cs.setString(2, sha256(m.getPassword()));
//            ResultSet rs = cs.executeQuery();
//            if (rs.next()) {
//                m.setId(rs.getInt("id"));
//                m.setFullName(rs.getString("fullName"));
//                m.setDob(rs.getDate("dob"));
//                m.setAddress(rs.getString("address"));
//                m.setEmail(rs.getString("email"));
//                m.setPhone(rs.getString("phone"));
//                m.setPassword(null);
//                return rs.getString("role");
//            }
//        } catch (Exception e) { e.printStackTrace(); }
//        return null;
//    }
//}





package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import model.Member0;

public class MemberDAO0 extends DAO0 {

    public MemberDAO0() {
        super();
    }

    public String checkLogin(Member0 m) {
        try {
            System.out.println("===== LOGIN DEBUG =====");
            System.out.println("Username: " + m.getUsername());
            System.out.println("Password SHA256: " + sha256(m.getPassword()));

            if (con == null || con.isClosed()) {
                System.out.println("ERROR: Database connection is null or closed!");
                return null;
            }

            System.out.println("Database connected: " + con.getCatalog());

            try (CallableStatement cs =
                    con.prepareCall("{call sp_check_login0(?,?)}")) {

                cs.setString(1, m.getUsername());
                cs.setString(2, sha256(m.getPassword()));

                try (ResultSet rs = cs.executeQuery()) {
                    if (rs.next()) {
                        m.setId(rs.getInt("id"));
                        m.setFullName(rs.getString("fullName"));
                        m.setDob(rs.getDate("dob"));
                        m.setAddress(rs.getString("address"));
                        m.setEmail(rs.getString("email"));
                        m.setPhone(rs.getString("phone"));
                        m.setPassword(null);

                        String role = rs.getString("role");

                        System.out.println("LOGIN SUCCESS!");
                        System.out.println("ID: " + m.getId());
                        System.out.println("Role: " + role);

                        return role;
                    }
                }
            }

            System.out.println("LOGIN FAILED: No matching account!");

        } catch (Exception e) {
            System.out.println("LOGIN ERROR:");
            e.printStackTrace();
        }

        return null;
    }
}

