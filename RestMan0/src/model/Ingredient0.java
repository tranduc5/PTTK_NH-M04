package model;

/** Ingredient0 - lop thuc the (theo thiet ke D1/D4) */
public class Ingredient0 {
    private int id;
    private String name;
    private String unit;
    private double stockQuantity;
    private double minStock;
    private String description;

    public Ingredient0() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    public double getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(double stockQuantity) { this.stockQuantity = stockQuantity; }
    public double getMinStock() { return minStock; }
    public void setMinStock(double minStock) { this.minStock = minStock; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
