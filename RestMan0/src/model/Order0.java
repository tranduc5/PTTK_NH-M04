package model;

/** Order0 - lop thuc the (theo thiet ke D1/D4) */
public class Order0 {
    private int id;
    private java.sql.Timestamp orderTime;
    private String channel;
    private String status;
    private String note;
    private int reservationId;
    private int confirmedById;
    private double totalAmount;

    public Order0() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public java.sql.Timestamp getOrderTime() { return orderTime; }
    public void setOrderTime(java.sql.Timestamp orderTime) { this.orderTime = orderTime; }
    public String getChannel() { return channel; }
    public void setChannel(String channel) { this.channel = channel; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public int getReservationId() { return reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }
    public int getConfirmedById() { return confirmedById; }
    public void setConfirmedById(int confirmedById) { this.confirmedById = confirmedById; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    private java.util.ArrayList<OrderItem0> items = new java.util.ArrayList<OrderItem0>();
    public java.util.ArrayList<OrderItem0> getItems() { return items; }
    public void setItems(java.util.ArrayList<OrderItem0> items) { this.items = items; }

    /** Them mon vao don; neu mon da co thi cong don so luong. */
    public void addItem(OrderItem0 item) {
        for (OrderItem0 it : items) {
            if (it.getMenuItemId() == item.getMenuItemId()) { it.setQuantity(it.getQuantity() + item.getQuantity()); return; }
        }
        items.add(item);
    }
    public void removeItem(int menuItemId) {
        for (int i = 0; i < items.size(); i++) if (items.get(i).getMenuItemId() == menuItemId) { items.remove(i); return; }
    }
    /** Tong tien = tong (so luong x don gia) cac mon trong gio. */
    public double calcTotal() {
        double s = 0; for (OrderItem0 it : items) s += it.getAmount(); return s;
    }
}
