package model;

/** ImportDetail0 - lop thuc the (theo thiet ke D1/D4) */
public class ImportDetail0 {
    private int id;
    private double quantity;
    private double unitPrice;
    private int ingredientId;

    public ImportDetail0() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }
    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }
    public int getIngredientId() { return ingredientId; }
    public void setIngredientId(int ingredientId) { this.ingredientId = ingredientId; }
}
