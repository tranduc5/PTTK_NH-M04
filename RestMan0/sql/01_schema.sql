-- ============================================================
-- RestMan0 - Script 1/3: tao CSDL + cac bang (theo bieu do CSDL D2)
-- MySQL 8.x  |  chay: mysql -u root -p < 01_schema.sql
-- ============================================================
DROP DATABASE IF EXISTS restman0;
CREATE DATABASE restman0 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE restman0;

CREATE TABLE tblMember0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL,            -- SHA-256 (hex)
  fullName VARCHAR(100) NOT NULL,
  dob DATE,
  address VARCHAR(200),
  email VARCHAR(100),
  phone VARCHAR(15),
  note VARCHAR(255)
);
CREATE TABLE tblCustomer0 (
  tblMember0id INT PRIMARY KEY,
  FOREIGN KEY (tblMember0id) REFERENCES tblMember0(id)
);
CREATE TABLE tblStaff0 (
  tblMember0id INT PRIMARY KEY,
  position VARCHAR(50),
  FOREIGN KEY (tblMember0id) REFERENCES tblMember0(id)
);
CREATE TABLE tblManagerStaff0 (
  tblStaff0id INT PRIMARY KEY,
  FOREIGN KEY (tblStaff0id) REFERENCES tblStaff0(tblMember0id)
);
CREATE TABLE tblWarehouseStaff0 (
  tblStaff0id INT PRIMARY KEY,
  FOREIGN KEY (tblStaff0id) REFERENCES tblStaff0(tblMember0id)
);
CREATE TABLE tblSalesStaff0 (
  tblStaff0id INT PRIMARY KEY,
  FOREIGN KEY (tblStaff0id) REFERENCES tblStaff0(tblMember0id)
);
CREATE TABLE tblMembershipCard0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cardCode VARCHAR(20) NOT NULL,
  issueDate DATE,
  point INT DEFAULT 0,
  level VARCHAR(20),
  status VARCHAR(20),
  tblCustomer0id INT NOT NULL,
  tblSalesStaff0id INT,
  FOREIGN KEY (tblCustomer0id) REFERENCES tblCustomer0(tblMember0id),
  FOREIGN KEY (tblSalesStaff0id) REFERENCES tblSalesStaff0(tblStaff0id)
);
CREATE TABLE tblSupplier0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  address VARCHAR(200),
  phone VARCHAR(15),
  email VARCHAR(100),
  note VARCHAR(255)
);
CREATE TABLE tblIngredient0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  unit VARCHAR(20),
  stockQuantity DOUBLE NOT NULL DEFAULT 0,
  minStock DOUBLE NOT NULL DEFAULT 0,
  description VARCHAR(255)
);
CREATE TABLE tblImportReceipt0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  importDate DATETIME NOT NULL,
  note VARCHAR(255),
  tblSupplier0id INT NOT NULL,
  tblWarehouseStaff0id INT NOT NULL,
  FOREIGN KEY (tblSupplier0id) REFERENCES tblSupplier0(id),
  FOREIGN KEY (tblWarehouseStaff0id) REFERENCES tblWarehouseStaff0(tblStaff0id)
);
CREATE TABLE tblImportDetail0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  quantity DOUBLE NOT NULL,
  unitPrice DOUBLE NOT NULL,
  tblImportReceipt0id INT NOT NULL,
  tblIngredient0id INT NOT NULL,
  FOREIGN KEY (tblImportReceipt0id) REFERENCES tblImportReceipt0(id),
  FOREIGN KEY (tblIngredient0id) REFERENCES tblIngredient0(id)
);
CREATE TABLE tblDishCategory0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(255)
);
CREATE TABLE tblMenuItem0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  price DOUBLE NOT NULL,
  description VARCHAR(500),
  image VARCHAR(255),
  status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',     -- ACTIVE / INACTIVE
  updatedTime DATETIME(3) NOT NULL                  -- khoa lac quan (optimistic locking)
);
CREATE TABLE tblDish0 (
  tblMenuItem0id INT PRIMARY KEY,
  tblDishCategory0id INT NOT NULL,
  FOREIGN KEY (tblMenuItem0id) REFERENCES tblMenuItem0(id),
  FOREIGN KEY (tblDishCategory0id) REFERENCES tblDishCategory0(id)
);
CREATE TABLE tblCombo0 (
  tblMenuItem0id INT PRIMARY KEY,
  FOREIGN KEY (tblMenuItem0id) REFERENCES tblMenuItem0(id)
);
CREATE TABLE tblComboDish0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  quantity INT NOT NULL,
  tblCombo0id INT NOT NULL,
  tblDish0id INT NOT NULL,
  FOREIGN KEY (tblCombo0id) REFERENCES tblCombo0(tblMenuItem0id),
  FOREIGN KEY (tblDish0id) REFERENCES tblDish0(tblMenuItem0id)
);
CREATE TABLE tblDishIngredient0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  quantity DOUBLE NOT NULL,
  tblDish0id INT NOT NULL,
  tblIngredient0id INT NOT NULL,
  FOREIGN KEY (tblDish0id) REFERENCES tblDish0(tblMenuItem0id),
  FOREIGN KEY (tblIngredient0id) REFERENCES tblIngredient0(id)
);
CREATE TABLE tblDiningTable0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(10) NOT NULL,
  capacity INT NOT NULL,
  area VARCHAR(50),
  status VARCHAR(20)
);
CREATE TABLE tblReservation0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  reservationTime DATETIME NOT NULL,
  guestCount INT NOT NULL,
  guestName VARCHAR(100),
  guestPhone VARCHAR(15),
  channel VARCHAR(20),                 -- ONLINE / COUNTER
  deposit DOUBLE DEFAULT 0,
  status VARCHAR(20) NOT NULL,         -- PENDING, CONFIRMED, SEATED, COMPLETED, CANCELLED, NO_SHOW
  note VARCHAR(255),
  createdTime DATETIME NOT NULL,
  tblCustomer0id INT,
  confirmedById INT,
  FOREIGN KEY (tblCustomer0id) REFERENCES tblCustomer0(tblMember0id),
  FOREIGN KEY (confirmedById) REFERENCES tblSalesStaff0(tblStaff0id)
);
CREATE TABLE tblReservationTable0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tblReservation0id INT NOT NULL,
  tblDiningTable0id INT NOT NULL,
  FOREIGN KEY (tblReservation0id) REFERENCES tblReservation0(id),
  FOREIGN KEY (tblDiningTable0id) REFERENCES tblDiningTable0(id)
);
CREATE TABLE tblOrder0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  orderTime DATETIME NOT NULL,
  channel VARCHAR(20),                 -- ONLINE / COUNTER
  status VARCHAR(20) NOT NULL,         -- PENDING, CONFIRMED, SERVING, CANCELLED
  note VARCHAR(255),
  tblReservation0id INT NOT NULL,
  confirmedById INT,
  FOREIGN KEY (tblReservation0id) REFERENCES tblReservation0(id),
  FOREIGN KEY (confirmedById) REFERENCES tblSalesStaff0(tblStaff0id)
);
CREATE TABLE tblOrderItem0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  quantity INT NOT NULL,
  unitPrice DOUBLE NOT NULL,           -- gia chot tai thoi diem dat
  status VARCHAR(20),
  note VARCHAR(255),
  tblOrder0id INT NOT NULL,
  tblMenuItem0id INT NOT NULL,
  FOREIGN KEY (tblOrder0id) REFERENCES tblOrder0(id),
  FOREIGN KEY (tblMenuItem0id) REFERENCES tblMenuItem0(id)
);
CREATE TABLE tblInvoice0 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  paidTime DATETIME,
  discount DOUBLE DEFAULT 0,
  totalAmount DOUBLE,
  paymentMethod VARCHAR(20),
  status VARCHAR(20),
  tblReservation0id INT NOT NULL,
  tblSalesStaff0id INT,
  FOREIGN KEY (tblReservation0id) REFERENCES tblReservation0(id),
  FOREIGN KEY (tblSalesStaff0id) REFERENCES tblSalesStaff0(tblStaff0id)
);
