package model;

/** MembershipCard0 - lop thuc the (theo thiet ke D1/D4) */
public class MembershipCard0 {
    private int id;
    private String cardCode;
    private java.sql.Date issueDate;
    private int point;
    private String level;
    private String status;
    private int customerId;

    public MembershipCard0() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCardCode() { return cardCode; }
    public void setCardCode(String cardCode) { this.cardCode = cardCode; }
    public java.sql.Date getIssueDate() { return issueDate; }
    public void setIssueDate(java.sql.Date issueDate) { this.issueDate = issueDate; }
    public int getPoint() { return point; }
    public void setPoint(int point) { this.point = point; }
    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
}
