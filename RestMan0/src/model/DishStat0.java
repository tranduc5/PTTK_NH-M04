package model;

/** DishStat0 - lop thuc the (theo thiet ke D1/D4) */
public class DishStat0 {
    private int id;
    private String name;
    private int totalQuantity;
    private double totalRevenue;

    public DishStat0() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public int getTotalQuantity() { return totalQuantity; }
    public void setTotalQuantity(int totalQuantity) { this.totalQuantity = totalQuantity; }
    public double getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(double totalRevenue) { this.totalRevenue = totalRevenue; }
}
