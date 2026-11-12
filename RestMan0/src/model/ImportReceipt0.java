package model;

/** ImportReceipt0 - lop thuc the (theo thiet ke D1/D4) */
public class ImportReceipt0 {
    private int id;
    private java.sql.Timestamp importDate;
    private String note;
    private String supplierName;
    private double totalAmount;
    private int supplierId;
    private int staffId;

    public ImportReceipt0() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public java.sql.Timestamp getImportDate() { return importDate; }
    public void setImportDate(java.sql.Timestamp importDate) { this.importDate = importDate; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public int getSupplierId() { return supplierId; }
    public void setSupplierId(int supplierId) { this.supplierId = supplierId; }
    public int getStaffId() { return staffId; }
    public void setStaffId(int staffId) { this.staffId = staffId; }

    private java.util.ArrayList<ImportDetail0> details = new java.util.ArrayList<ImportDetail0>();
    public java.util.ArrayList<ImportDetail0> getDetails() { return details; }
    public void setDetails(java.util.ArrayList<ImportDetail0> details) { this.details = details; }
    public void addDetail(ImportDetail0 d) { details.add(d); }
}
