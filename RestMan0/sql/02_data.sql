
-- ============================================================
-- RESTMAN0 - SCRIPT 2/3
-- DU LIEU MAU DAY DU
-- Bao gom du lieu goc + du lieu kiem thu dat mon truc tuyen
--
-- Database: restman0
-- Mat khau tat ca tai khoan: 123456
--
-- Yeu cau:
-- 1. Da chay Script 1/3 tao database va cac bang
-- 2. Cac bang chua co du lieu mau
-- ============================================================

USE restman0;

SET @pw = '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92';

-- ============================================================
-- 1. THANH VIEN
-- ============================================================

INSERT INTO tblMember0
(id, username, password, fullName, dob, address, email, phone)
VALUES
(1,'manager0',@pw,'Trần Quản Lý','1985-03-12',
 'Hà Nội','manager0@restman.vn','0900000001'),

(2,'warehouse0',@pw,'Lê Thủ Kho','1990-07-21',
 'Hà Nội','kho0@restman.vn','0900000002'),

(3,'sales0',@pw,'Phạm Thu Ngân','1996-11-05',
 'Hà Nội','sales0@restman.vn','0900000003'),

(4,'customer0',@pw,'Nguyễn Văn An','1998-05-20',
 'Hà Đông, Hà Nội','an@mail.com','0901234567'),

(5,'customer1',@pw,'Trần Thị Bình','2000-01-15',
 'Cầu Giấy, Hà Nội','binh@mail.com','0907654321');

-- Khach hang
INSERT INTO tblCustomer0 VALUES
(4),
(5);

-- Nhan vien
INSERT INTO tblStaff0 VALUES
(1,'Quản lý nhà hàng'),
(2,'Nhân viên kho'),
(3,'Nhân viên bán hàng');

INSERT INTO tblManagerStaff0 VALUES (1);
INSERT INTO tblWarehouseStaff0 VALUES (2);
INSERT INTO tblSalesStaff0 VALUES (3);

-- The thanh vien
INSERT INTO tblMembershipCard0
(cardCode, issueDate, point, level, status,
 tblCustomer0id, tblSalesStaff0id)
VALUES
('MB0001','2025-01-10',120,'SILVER','ACTIVE',4,3);


-- ============================================================
-- 2. DANH MUC MON AN
-- ============================================================

INSERT INTO tblDishCategory0
(id, name, description)
VALUES
(1,'Khai vị','Món khai vị'),
(2,'Món chính','Món chính'),
(3,'Đồ uống','Nước uống'),
(4,'Tráng miệng','Món tráng miệng');


-- ============================================================
-- 3. THUC DON
-- ============================================================

INSERT INTO tblMenuItem0
(id, name, price, description, image, status, updatedTime)
VALUES

(1,'Gỏi cuốn tôm thịt',45000,
 'Gỏi cuốn tươi, nước chấm đậu phộng',
 'goicuon.jpg','ACTIVE',NOW(3)),

(2,'Bò lúc lắc',165000,
 'Bò Úc xào tiêu đen',
 'boluclac.jpg','ACTIVE',NOW(3)),

(3,'Cá hồi nướng',220000,
 'Cá hồi Na Uy nướng bơ tỏi',
 'cahoi.jpg','ACTIVE',NOW(3)),

(4,'Lẩu Thái hải sản',350000,
 'Lẩu Thái chua cay (2-3 người)',
 'lauthai.jpg','ACTIVE',NOW(3)),

(5,'Trà đào cam sả',35000,
 'Trà đào cam sả mát lạnh',
 'tradao.jpg','ACTIVE',NOW(3)),

(6,'Chè khúc bạch',40000,
 'Chè khúc bạch trái cây',
 'chekhucbach.jpg','ACTIVE',NOW(3)),

(7,'Bún chả Hà Nội',70000,
 'Món theo mùa, tạm ngừng',
 'buncha.jpg','INACTIVE',NOW(3)),

(8,'Combo gia đình',599000,
 'Lẩu Thái + Bò lúc lắc + 4 trà đào',
 'combo1.jpg','ACTIVE',NOW(3));

-- Mon an thuong
INSERT INTO tblDish0 VALUES
(1,1),
(2,2),
(3,2),
(4,2),
(5,3),
(6,4),
(7,2);

-- Combo
INSERT INTO tblCombo0 VALUES (8);

INSERT INTO tblComboDish0
(quantity, tblCombo0id, tblDish0id)
VALUES
(1,8,4),
(1,8,2),
(4,8,5);


-- ============================================================
-- 4. NGUYEN LIEU
-- ============================================================

INSERT INTO tblIngredient0
(id, name, unit, stockQuantity, minStock, description)
VALUES
(1,'Tôm sú','kg',20,5,'Tôm tươi'),
(2,'Thịt bò Úc','kg',15,4,'Thăn bò'),
(3,'Cá hồi Na Uy','kg',0.1,2,'Sắp hết hàng'),
(4,'Đào ngâm','kg',10,2,'Đào'),
(5,'Bánh tráng','kg',9,1,'Bánh tráng');

-- Dinh luong nguyen lieu cho mon an
INSERT INTO tblDishIngredient0
(quantity, tblDish0id, tblIngredient0id)
VALUES
(0.05,1,1),
(0.05,1,5),
(0.20,2,2),
(0.25,3,3),
(0.30,4,1),
(0.10,5,4);


-- ============================================================
-- 5. NHA CUNG CAP
-- ============================================================

INSERT INTO tblSupplier0
(id, name, address, phone, email)
VALUES

(1,'Công ty Thực phẩm Sạch Việt',
 'Hà Nội','0241111111','sach@viet.vn'),

(2,'Hải sản Biển Đông',
 'Hải Phòng','0225222222','biendong@mail.vn');


-- ============================================================
-- 6. PHIEU NHAP NGUYEN LIEU
-- ============================================================

INSERT INTO tblImportReceipt0
(id, importDate, note, tblSupplier0id, tblWarehouseStaff0id)
VALUES
(1,TIMESTAMPADD(DAY,-3,NOW()),
 'Nhập hàng định kỳ',1,2);

INSERT INTO tblImportDetail0
(quantity, unitPrice, tblImportReceipt0id, tblIngredient0id)
VALUES
(10,250000,1,1),
(8,280000,1,2);


-- ============================================================
-- 7. BAN AN
-- ============================================================

INSERT INTO tblDiningTable0
(id, code, capacity, area, status)
VALUES

(1,'T01',4,'Tầng 1','EMPTY'),
(2,'T02',4,'Tầng 1','EMPTY'),
(3,'T03',6,'Tầng 1','EMPTY'),
(4,'V01',8,'Phòng VIP','EMPTY'),
(5,'T04',2,'Sân vườn','EMPTY');


-- ============================================================
-- 8. DAT BAN - DU LIEU GOC
-- ============================================================

INSERT INTO tblReservation0
(
 id,
 reservationTime,
 guestCount,
 guestName,
 guestPhone,
 channel,
 deposit,
 status,
 note,
 createdTime,
 tblCustomer0id,
 confirmedById
)
VALUES

-- Dat ban da xac nhan, sap den
(1,TIMESTAMPADD(HOUR,3,NOW()),4,
 'Nguyễn Văn An','0901234567',
 'ONLINE',200000,'CONFIRMED','Sinh nhật',
 TIMESTAMPADD(DAY,-1,NOW()),4,3),

-- Dat ban da hoan thanh
(2,TIMESTAMPADD(DAY,-2,NOW()),2,
 'Nguyễn Văn An','0901234567',
 'ONLINE',0,'COMPLETED',NULL,
 TIMESTAMPADD(DAY,-3,NOW()),4,3),

-- Khach den muon
(3,TIMESTAMPADD(MINUTE,-10,NOW()),3,
 'Nguyễn Văn An','0901234567',
 'ONLINE',100000,'CONFIRMED','Khách đến muộn',
 TIMESTAMPADD(DAY,-1,NOW()),4,3),

-- Dat ban cho xac nhan
(4,TIMESTAMPADD(DAY,1,NOW()),6,
 'Trần Thị Bình','0907654321',
 'ONLINE',0,'PENDING',NULL,
 NOW(),5,NULL),

-- Dat ban da huy
(5,TIMESTAMPADD(DAY,2,NOW()),2,
 'Nguyễn Văn An','0901234567',
 'ONLINE',0,'CANCELLED','Khách hủy',
 NOW(),4,NULL),

-- Khach da ngoi ban
(6,TIMESTAMPADD(HOUR,-3,NOW()),4,
 'Nguyễn Văn An','0901234567',
 'ONLINE',0,'SEATED',NULL,
 TIMESTAMPADD(DAY,-1,NOW()),4,3);


-- ============================================================
-- 9. DAT BAN - BO SUNG DE TEST ORDER DISH ONLINE
-- ============================================================

INSERT INTO tblReservation0
(
 id,
 reservationTime,
 guestCount,
 guestName,
 guestPhone,
 channel,
 deposit,
 status,
 note,
 createdTime,
 tblCustomer0id,
 confirmedById
)
VALUES

-- Reservation 7
-- Nguyen Van An: da xac nhan, chua co don mon
(7,TIMESTAMPADD(HOUR,5,NOW()),2,
 'Nguyễn Văn An','0901234567',
 'ONLINE',0,'CONFIRMED',
 'Đặt bàn ăn tối - kiểm thử tạo đơn mới',
 NOW(),4,3),

-- Reservation 8
-- Nguyen Van An: da xac nhan, co don cho xac nhan
(8,TIMESTAMPADD(DAY,1,NOW()),6,
 'Nguyễn Văn An','0901234567',
 'ONLINE',200000,'CONFIRMED',
 'Liên hoan gia đình',
 NOW(),4,3),

-- Reservation 9
-- Nguyen Van An: dang cho xac nhan
(9,TIMESTAMPADD(DAY,2,NOW()),4,
 'Nguyễn Văn An','0901234567',
 'ONLINE',0,'PENDING',
 'Kiểm thử bàn chưa xác nhận',
 NOW(),4,NULL),

-- Reservation 10
-- Tran Thi Binh: da xac nhan
(10,TIMESTAMPADD(HOUR,6,NOW()),2,
 'Trần Thị Bình','0907654321',
 'ONLINE',0,'CONFIRMED',
 'Đặt bàn ăn tối',
 NOW(),5,3),

-- Reservation 11
-- Tran Thi Binh: ban VIP
(11,TIMESTAMPADD(DAY,3,NOW()),8,
 'Trần Thị Bình','0907654321',
 'ONLINE',500000,'CONFIRMED',
 'Sinh nhật tại phòng VIP',
 NOW(),5,3),

-- Reservation 12
-- Nguyen Van An: da huy
(12,TIMESTAMPADD(DAY,4,NOW()),4,
 'Nguyễn Văn An','0901234567',
 'ONLINE',0,'CANCELLED',
 'Kiểm thử không cho đặt món',
 NOW(),4,NULL),

-- Reservation 13
-- Tran Thi Binh: da hoan thanh
(13,TIMESTAMPADD(DAY,-1,NOW()),2,
 'Trần Thị Bình','0907654321',
 'ONLINE',0,'COMPLETED',
 'Lịch sử đặt bàn',
 TIMESTAMPADD(DAY,-2,NOW()),5,3),

-- Reservation 14
-- Nguyen Van An: da xac nhan, co don mon
(14,TIMESTAMPADD(DAY,5,NOW()),4,
 'Nguyễn Văn An','0901234567',
 'ONLINE',0,'CONFIRMED',
 'Kiểm thử xem đơn đã đặt',
 NOW(),4,3);


-- ============================================================
-- 10. GAN BAN CHO CAC DAT BAN
-- ============================================================

INSERT INTO tblReservationTable0
(tblReservation0id, tblDiningTable0id)
VALUES

-- Du lieu goc
(1,1),
(1,2),
(2,5),
(3,3),
(4,4),
(5,5),
(6,1),

-- Du lieu bo sung
(7,5),
(8,1),
(8,2),
(9,1),
(10,5),
(11,4),
(12,2),
(13,5),
(14,1);


-- ============================================================
-- 11. DON GOI MON - DU LIEU GOC
-- ============================================================

INSERT INTO tblOrder0
(
 id,
 orderTime,
 channel,
 status,
 note,
 tblReservation0id,
 confirmedById
)
VALUES

-- Don lich su
(1,TIMESTAMPADD(DAY,-2,NOW()),
 'ONLINE','SERVING',NULL,2,3),

-- Don dang cho xac nhan
(2,TIMESTAMPADD(HOUR,-1,NOW()),
 'ONLINE','PENDING','Ít cay',1,NULL);


-- ============================================================
-- 12. DON GOI MON - DU LIEU BO SUNG
-- ============================================================

INSERT INTO tblOrder0
(
 id,
 orderTime,
 channel,
 status,
 note,
 tblReservation0id,
 confirmedById
)
VALUES

-- Reservation 8: don cho xac nhan
(3,NOW(),
 'ONLINE','PENDING',
 'Không cay',8,NULL),

-- Reservation 14: don da xac nhan
(4,NOW(),
 'ONLINE','CONFIRMED',
 'Phục vụ đúng giờ',14,3);


-- ============================================================
-- 13. CHI TIET DON GOI MON
-- ============================================================

INSERT INTO tblOrderItem0
(
 quantity,
 unitPrice,
 status,
 note,
 tblOrder0id,
 tblMenuItem0id
)
VALUES

-- Order 1
(2,165000,'ORDERED',NULL,1,2),
(1,35000,'ORDERED',NULL,1,5),

-- Order 2
(2,45000,'ORDERED',NULL,2,1),

-- Order 3
(2,165000,'ORDERED',NULL,3,2),
(2,35000,'ORDERED','Ít đá',3,5),
(1,45000,'ORDERED',NULL,3,1),

-- Order 4
(1,599000,'ORDERED',NULL,4,8),
(2,40000,'ORDERED',NULL,4,6);


-- ============================================================
-- 14. HOA DON
-- ============================================================

INSERT INTO tblInvoice0
(
 paidTime,
 discount,
 totalAmount,
 paymentMethod,
 status,
 tblReservation0id,
 tblSalesStaff0id
)
VALUES
(
 TIMESTAMPADD(DAY,-2,NOW()),
 0,
 365000,
 'CASH',
 'PAID',
 2,
 3
);


-- ============================================================
-- 15. KIEM TRA SO LUONG BAN GHI
-- ============================================================

SELECT 'tblMember0' AS tableName, COUNT(*) AS total
FROM tblMember0

UNION ALL

SELECT 'tblCustomer0', COUNT(*)
FROM tblCustomer0

UNION ALL

SELECT 'tblMenuItem0', COUNT(*)
FROM tblMenuItem0

UNION ALL

SELECT 'tblIngredient0', COUNT(*)
FROM tblIngredient0

UNION ALL

SELECT 'tblDiningTable0', COUNT(*)
FROM tblDiningTable0

UNION ALL

SELECT 'tblReservation0', COUNT(*)
FROM tblReservation0

UNION ALL

SELECT 'tblReservationTable0', COUNT(*)
FROM tblReservationTable0

UNION ALL

SELECT 'tblOrder0', COUNT(*)
FROM tblOrder0

UNION ALL

SELECT 'tblOrderItem0', COUNT(*)
FROM tblOrderItem0

UNION ALL

SELECT 'tblInvoice0', COUNT(*)
FROM tblInvoice0;


-- ============================================================
-- 16. XEM TAT CA CAC LUOT DAT BAN
-- ============================================================

SELECT
    r.id AS reservationId,
    r.guestName,
    r.guestPhone,
    r.reservationTime,
    r.guestCount,
    r.status,

    GROUP_CONCAT(
        t.code
        ORDER BY t.code
        SEPARATOR ', '
    ) AS tableCodes

FROM tblReservation0 r

LEFT JOIN tblReservationTable0 rt
    ON r.id = rt.tblReservation0id

LEFT JOIN tblDiningTable0 t
    ON rt.tblDiningTable0id = t.id

GROUP BY
    r.id,
    r.guestName,
    r.guestPhone,
    r.reservationTime,
    r.guestCount,
    r.status

ORDER BY r.reservationTime DESC;


-- ============================================================
-- 17. KIEM TRA CAC DAT BAN CO THE DAT MON
-- Quy tac test: CONFIRMED va chua qua gio den 30 phut
-- ============================================================

SELECT
    r.id,
    r.guestName,
    r.reservationTime,
    r.guestCount,
    r.status

FROM tblReservation0 r

WHERE r.status = 'CONFIRMED'
  AND r.reservationTime >= TIMESTAMPADD(MINUTE,-30,NOW())

ORDER BY r.reservationTime;


-- ============================================================
-- 18. XEM CHI TIET CAC DON DA DAT
-- ============================================================

SELECT
    o.id AS orderId,
    o.tblReservation0id AS reservationId,
    r.guestName,
    o.status AS orderStatus,
    m.name AS dishName,
    oi.quantity,
    oi.unitPrice,
    oi.quantity * oi.unitPrice AS amount

FROM tblOrder0 o

JOIN tblReservation0 r
    ON o.tblReservation0id = r.id

JOIN tblOrderItem0 oi
    ON oi.tblOrder0id = o.id

JOIN tblMenuItem0 m
    ON oi.tblMenuItem0id = m.id

ORDER BY o.id, oi.id;


-- ============================================================
-- 19. XEM TONG TIEN TUNG DON
-- ============================================================

SELECT
    o.id AS orderId,
    r.guestName,
    o.status,
    COUNT(oi.id) AS numberOfItems,
    SUM(oi.quantity * oi.unitPrice) AS totalAmount

FROM tblOrder0 o

JOIN tblReservation0 r
    ON o.tblReservation0id = r.id

JOIN tblOrderItem0 oi
    ON oi.tblOrder0id = o.id

GROUP BY
    o.id,
    r.guestName,
    o.status

ORDER BY o.id;


-- ============================================================
-- HOAN THANH SCRIPT 2/3
-- ============================================================
