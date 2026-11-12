package model;

/** Reservation0 - lop thuc the (theo thiet ke D1/D4) */
public class Reservation0 {
    private int id;
    private java.sql.Timestamp reservationTime;
    private int guestCount;
    private String guestName;
    private String guestPhone;
    private String channel;
    private double deposit;
    private String status;
    private String note;
    private java.sql.Timestamp createdTime;
    private int customerId;
    private String tableCodes;

    public Reservation0() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public java.sql.Timestamp getReservationTime() { return reservationTime; }
    public void setReservationTime(java.sql.Timestamp reservationTime) { this.reservationTime = reservationTime; }
    public int getGuestCount() { return guestCount; }
    public void setGuestCount(int guestCount) { this.guestCount = guestCount; }
    public String getGuestName() { return guestName; }
    public void setGuestName(String guestName) { this.guestName = guestName; }
    public String getGuestPhone() { return guestPhone; }
    public void setGuestPhone(String guestPhone) { this.guestPhone = guestPhone; }
    public String getChannel() { return channel; }
    public void setChannel(String channel) { this.channel = channel; }
    public double getDeposit() { return deposit; }
    public void setDeposit(double deposit) { this.deposit = deposit; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public java.sql.Timestamp getCreatedTime() { return createdTime; }
    public void setCreatedTime(java.sql.Timestamp createdTime) { this.createdTime = createdTime; }
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    public String getTableCodes() { return tableCodes; }
    public void setTableCodes(String tableCodes) { this.tableCodes = tableCodes; }
}
