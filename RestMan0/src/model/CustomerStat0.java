package model;

/** CustomerStat0 - lop thuc the (theo thiet ke D1/D4) */
public class CustomerStat0 {
    private int id;
    private String fullName;
    private int reservationCount;
    private double totalSpent;

    public CustomerStat0() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public int getReservationCount() { return reservationCount; }
    public void setReservationCount(int reservationCount) { this.reservationCount = reservationCount; }
    public double getTotalSpent() { return totalSpent; }
    public void setTotalSpent(double totalSpent) { this.totalSpent = totalSpent; }
}
