package model;

/** OrderItem0 - lop thuc the (theo thiet ke D1/D4) */
public class OrderItem0 {
    private int id;
    private int quantity;
    private double unitPrice;
    private String status;
    private String note;
    private int menuItemId;
    private String menuItemName;

    public OrderItem0() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public int getMenuItemId() { return menuItemId; }
    public void setMenuItemId(int menuItemId) { this.menuItemId = menuItemId; }
    public String getMenuItemName() { return menuItemName; }
    public void setMenuItemName(String menuItemName) { this.menuItemName = menuItemName; }

    public double getAmount() { return quantity * unitPrice; }
}
