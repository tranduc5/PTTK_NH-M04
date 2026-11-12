package model;

/** Invoice0 - lop thuc the (theo thiet ke D1/D4) */
public class Invoice0 {
    private int id;
    private java.sql.Timestamp paidTime;
    private double discount;
    private double totalAmount;
    private String paymentMethod;
    private String status;
    private int reservationId;
    private int staffId;

    public Invoice0() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public java.sql.Timestamp getPaidTime() { return paidTime; }
    public void setPaidTime(java.sql.Timestamp paidTime) { this.paidTime = paidTime; }
    public double getDiscount() { return discount; }
    public void setDiscount(double discount) { this.discount = discount; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public int getReservationId() { return reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }
    public int getStaffId() { return staffId; }
    public void setStaffId(int staffId) { this.staffId = staffId; }
}
