package model;

/** Dish0 - lop thuc the (theo thiet ke D1/D4) */
public class Dish0 extends MenuItem0 {
    private int categoryId;
    private String categoryName;
    private boolean available;

    public Dish0() { }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }
}
