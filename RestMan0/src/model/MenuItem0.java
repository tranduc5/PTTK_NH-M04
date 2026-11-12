package model;

/** MenuItem0 - lop thuc the (theo thiet ke D1/D4) */
public abstract class MenuItem0 {
    private int id;
    private String name;
    private double price;
    private String description;
    private String image;
    private String status;
    private java.sql.Timestamp updatedTime;

    public MenuItem0() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public java.sql.Timestamp getUpdatedTime() { return updatedTime; }
    public void setUpdatedTime(java.sql.Timestamp updatedTime) { this.updatedTime = updatedTime; }
}
