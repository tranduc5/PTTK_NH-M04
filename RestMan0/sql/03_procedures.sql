-- ============================================================
-- RestMan0 - Script 3/3: stored procedure (moi procedure 1 cau lenh SQL)
-- Chay trong MySQL Workbench hoac: mysql -u root -p restman0 < 03_procedures.sql
-- ============================================================
USE restman0;
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_check_login0$$
CREATE PROCEDURE sp_check_login0(IN p_username VARCHAR(50), IN p_password VARCHAR(100))
BEGIN
  SELECT m.id, m.username, m.fullName, m.dob, m.address, m.email, m.phone, m.note,
  CASE WHEN mg.tblStaff0id IS NOT NULL THEN 'MANAGER'
       WHEN w.tblStaff0id  IS NOT NULL THEN 'WAREHOUSE'
       WHEN sl.tblStaff0id IS NOT NULL THEN 'SALES'
       WHEN c.tblMember0id IS NOT NULL THEN 'CUSTOMER' END AS role
FROM tblMember0 m
LEFT JOIN tblManagerStaff0 mg ON mg.tblStaff0id = m.id
LEFT JOIN tblWarehouseStaff0 w ON w.tblStaff0id = m.id
LEFT JOIN tblSalesStaff0 sl ON sl.tblStaff0id = m.id
LEFT JOIN tblCustomer0 c ON c.tblMember0id = m.id
WHERE m.username = p_username AND m.password = p_password;
END$$

DROP PROCEDURE IF EXISTS sp_search_dish0$$
CREATE PROCEDURE sp_search_dish0(IN p_keyword VARCHAR(150))
BEGIN
  SELECT mi.id, mi.name, mi.price, mi.description, mi.image, mi.status, mi.updatedTime,
  d.tblDishCategory0id AS categoryId, dc.name AS categoryName,
  CASE WHEN EXISTS (SELECT 1 FROM tblDishIngredient0 di JOIN tblIngredient0 ig ON ig.id = di.tblIngredient0id
                    WHERE di.tblDish0id = mi.id AND ig.stockQuantity < di.quantity)
       THEN 0 ELSE 1 END AS available
FROM tblMenuItem0 mi JOIN tblDish0 d ON d.tblMenuItem0id = mi.id
JOIN tblDishCategory0 dc ON dc.id = d.tblDishCategory0id
WHERE mi.name LIKE CONCAT('%', p_keyword, '%')
ORDER BY mi.name;
END$$

DROP PROCEDURE IF EXISTS sp_get_dish0$$
CREATE PROCEDURE sp_get_dish0(IN p_id INT)
BEGIN
  SELECT mi.id, mi.name, mi.price, mi.description, mi.image, mi.status, mi.updatedTime,
  d.tblDishCategory0id AS categoryId, dc.name AS categoryName,
  CASE WHEN EXISTS (SELECT 1 FROM tblDishIngredient0 di JOIN tblIngredient0 ig ON ig.id = di.tblIngredient0id
                    WHERE di.tblDish0id = mi.id AND ig.stockQuantity < di.quantity)
       THEN 0 ELSE 1 END AS available
FROM tblMenuItem0 mi JOIN tblDish0 d ON d.tblMenuItem0id = mi.id
JOIN tblDishCategory0 dc ON dc.id = d.tblDishCategory0id
WHERE mi.id = p_id;
END$$

DROP PROCEDURE IF EXISTS sp_count_dish_name0$$
CREATE PROCEDURE sp_count_dish_name0(IN p_name VARCHAR(150), IN p_excludeId INT)
BEGIN
  SELECT COUNT(*) AS cnt FROM tblMenuItem0 WHERE LOWER(name) = LOWER(p_name) AND id <> p_excludeId;
END$$

DROP PROCEDURE IF EXISTS sp_update_menuitem0$$
CREATE PROCEDURE sp_update_menuitem0(IN p_id INT, IN p_name VARCHAR(150), IN p_price DOUBLE, IN p_description VARCHAR(500), IN p_image VARCHAR(255), IN p_status VARCHAR(20), IN p_oldUpdatedTime DATETIME(3))
BEGIN
  UPDATE tblMenuItem0 SET name = p_name, price = p_price, description = p_description, image = p_image,
  status = p_status, updatedTime = NOW(3)
WHERE id = p_id AND updatedTime = p_oldUpdatedTime;
END$$

DROP PROCEDURE IF EXISTS sp_update_dish_category0$$
CREATE PROCEDURE sp_update_dish_category0(IN p_id INT, IN p_categoryId INT)
BEGIN
  UPDATE tblDish0 SET tblDishCategory0id = p_categoryId WHERE tblMenuItem0id = p_id;
END$$

DROP PROCEDURE IF EXISTS sp_get_all_categories0$$
CREATE PROCEDURE sp_get_all_categories0()
BEGIN
  SELECT id, name, description FROM tblDishCategory0 ORDER BY name;
END$$

DROP PROCEDURE IF EXISTS sp_get_reservations_of_customer0$$
CREATE PROCEDURE sp_get_reservations_of_customer0(IN p_customerId INT, IN p_name VARCHAR(100), IN p_phone VARCHAR(15))
BEGIN
  SELECT r.id, r.reservationTime, r.guestCount, r.guestName, r.guestPhone, r.channel, r.deposit, r.status, r.note, r.createdTime,
  r.tblCustomer0id AS customerId,
  (SELECT GROUP_CONCAT(t.code) FROM tblReservationTable0 rt JOIN tblDiningTable0 t ON t.id = rt.tblDiningTable0id
   WHERE rt.tblReservation0id = r.id) AS tableCodes
FROM tblReservation0 r
WHERE r.tblCustomer0id = p_customerId
  AND r.guestName LIKE CONCAT('%', p_name, '%')
  AND r.guestPhone LIKE CONCAT('%', p_phone, '%')
ORDER BY r.reservationTime DESC;
END$$

DROP PROCEDURE IF EXISTS sp_get_reservation0$$
CREATE PROCEDURE sp_get_reservation0(IN p_id INT)
BEGIN
  SELECT r.id, r.reservationTime, r.guestCount, r.guestName, r.guestPhone, r.channel, r.deposit, r.status, r.note, r.createdTime,
  r.tblCustomer0id AS customerId,
  (SELECT GROUP_CONCAT(t.code) FROM tblReservationTable0 rt JOIN tblDiningTable0 t ON t.id = rt.tblDiningTable0id
   WHERE rt.tblReservation0id = r.id) AS tableCodes
FROM tblReservation0 r WHERE r.id = p_id;
END$$

DROP PROCEDURE IF EXISTS sp_check_orderable0$$
CREATE PROCEDURE sp_check_orderable0(IN p_reservationId INT)
BEGIN
  SELECT COUNT(*) AS cnt FROM tblReservation0
WHERE id = p_reservationId AND status IN ('PENDING','CONFIRMED')
  AND reservationTime >= TIMESTAMPADD(MINUTE, -30, NOW());
END$$

DROP PROCEDURE IF EXISTS sp_search_dish_for_order0$$
CREATE PROCEDURE sp_search_dish_for_order0(IN p_keyword VARCHAR(150), IN p_categoryId INT)
BEGIN
  SELECT mi.id, mi.name, mi.price, mi.description, mi.image, mi.status, mi.updatedTime,
  d.tblDishCategory0id AS categoryId, dc.name AS categoryName,
  CASE WHEN EXISTS (SELECT 1 FROM tblDishIngredient0 di JOIN tblIngredient0 ig ON ig.id = di.tblIngredient0id
                    WHERE di.tblDish0id = mi.id AND ig.stockQuantity < di.quantity)
       THEN 0 ELSE 1 END AS available
FROM tblMenuItem0 mi JOIN tblDish0 d ON d.tblMenuItem0id = mi.id
JOIN tblDishCategory0 dc ON dc.id = d.tblDishCategory0id
WHERE mi.status = 'ACTIVE' AND mi.name LIKE CONCAT('%', p_keyword, '%')
  AND (p_categoryId = 0 OR d.tblDishCategory0id = p_categoryId)
ORDER BY dc.name, mi.name;
END$$

DROP PROCEDURE IF EXISTS sp_insert_order0$$
CREATE PROCEDURE sp_insert_order0(IN p_reservationId INT, IN p_note VARCHAR(255))
BEGIN
  INSERT INTO tblOrder0 (orderTime, channel, status, note, tblReservation0id)
VALUES (NOW(), 'ONLINE', 'PENDING', p_note, p_reservationId);
END$$

DROP PROCEDURE IF EXISTS sp_last_insert_id0$$
CREATE PROCEDURE sp_last_insert_id0()
BEGIN
  SELECT LAST_INSERT_ID() AS id;
END$$

DROP PROCEDURE IF EXISTS sp_insert_order_item0$$
CREATE PROCEDURE sp_insert_order_item0(IN p_orderId INT, IN p_menuItemId INT, IN p_quantity INT, IN p_note VARCHAR(255))
BEGIN
  INSERT INTO tblOrderItem0 (quantity, unitPrice, status, note, tblOrder0id, tblMenuItem0id)
SELECT p_quantity, mi.price, 'ORDERED', p_note, p_orderId, mi.id
FROM tblMenuItem0 mi
WHERE mi.id = p_menuItemId AND mi.status = 'ACTIVE'
  AND NOT EXISTS (SELECT 1 FROM tblDishIngredient0 di JOIN tblIngredient0 ig ON ig.id = di.tblIngredient0id
                  WHERE di.tblDish0id = mi.id AND ig.stockQuantity < di.quantity * p_quantity);
END$$

DROP PROCEDURE IF EXISTS sp_get_orders_of_reservation0$$
CREATE PROCEDURE sp_get_orders_of_reservation0(IN p_reservationId INT)
BEGIN
  SELECT o.id, o.orderTime, o.channel, o.status, o.note, o.tblReservation0id AS reservationId, o.confirmedById,
  (SELECT COALESCE(SUM(oi.quantity * oi.unitPrice),0) FROM tblOrderItem0 oi WHERE oi.tblOrder0id = o.id) AS totalAmount
FROM tblOrder0 o WHERE o.tblReservation0id = p_reservationId
ORDER BY o.orderTime DESC;
END$$

DROP PROCEDURE IF EXISTS sp_get_order_items0$$
CREATE PROCEDURE sp_get_order_items0(IN p_orderId INT)
BEGIN
  SELECT oi.id, oi.quantity, oi.unitPrice, oi.status, oi.note, oi.tblMenuItem0id AS menuItemId, mi.name AS menuItemName
FROM tblOrderItem0 oi JOIN tblMenuItem0 mi ON mi.id = oi.tblMenuItem0id
WHERE oi.tblOrder0id = p_orderId ORDER BY oi.id;
END$$

DROP PROCEDURE IF EXISTS sp_get_reservations_by_date0$$
CREATE PROCEDURE sp_get_reservations_by_date0(IN p_date DATE)
BEGIN
  SELECT r.id, r.reservationTime, r.guestCount, r.guestName, r.guestPhone, r.channel, r.deposit, r.status, r.note, r.createdTime,
  r.tblCustomer0id AS customerId,
  (SELECT GROUP_CONCAT(t.code) FROM tblReservationTable0 rt JOIN tblDiningTable0 t ON t.id = rt.tblDiningTable0id
   WHERE rt.tblReservation0id = r.id) AS tableCodes
FROM tblReservation0 r
WHERE CAST(r.reservationTime AS DATE) = p_date
ORDER BY r.reservationTime;
END$$

DROP PROCEDURE IF EXISTS sp_confirm_order0$$
CREATE PROCEDURE sp_confirm_order0(IN p_orderId INT, IN p_staffId INT)
BEGIN
  UPDATE tblOrder0 SET status = 'CONFIRMED', confirmedById = p_staffId
WHERE id = p_orderId AND status = 'PENDING';
END$$

DROP PROCEDURE IF EXISTS sp_cancel_order0$$
CREATE PROCEDURE sp_cancel_order0(IN p_orderId INT)
BEGIN
  UPDATE tblOrder0 SET status = 'CANCELLED' WHERE id = p_orderId AND status = 'PENDING';
END$$

DROP PROCEDURE IF EXISTS sp_get_all_ingredients0$$
CREATE PROCEDURE sp_get_all_ingredients0()
BEGIN
  SELECT id, name, unit, stockQuantity, minStock, description FROM tblIngredient0 ORDER BY name;
END$$

DROP PROCEDURE IF EXISTS sp_get_all_suppliers0$$
CREATE PROCEDURE sp_get_all_suppliers0()
BEGIN
  SELECT id, name, address, phone, email, note FROM tblSupplier0 ORDER BY name;
END$$

DROP PROCEDURE IF EXISTS sp_insert_import_receipt0$$
CREATE PROCEDURE sp_insert_import_receipt0(IN p_supplierId INT, IN p_staffId INT, IN p_note VARCHAR(255))
BEGIN
  INSERT INTO tblImportReceipt0 (importDate, note, tblSupplier0id, tblWarehouseStaff0id)
VALUES (NOW(), p_note, p_supplierId, p_staffId);
END$$

DROP PROCEDURE IF EXISTS sp_insert_import_detail0$$
CREATE PROCEDURE sp_insert_import_detail0(IN p_receiptId INT, IN p_ingredientId INT, IN p_quantity DOUBLE, IN p_unitPrice DOUBLE)
BEGIN
  INSERT INTO tblImportDetail0 (quantity, unitPrice, tblImportReceipt0id, tblIngredient0id)
VALUES (p_quantity, p_unitPrice, p_receiptId, p_ingredientId);
END$$

DROP PROCEDURE IF EXISTS sp_add_stock0$$
CREATE PROCEDURE sp_add_stock0(IN p_ingredientId INT, IN p_quantity DOUBLE)
BEGIN
  UPDATE tblIngredient0 SET stockQuantity = stockQuantity + p_quantity WHERE id = p_ingredientId;
END$$

DROP PROCEDURE IF EXISTS sp_get_recent_receipts0$$
CREATE PROCEDURE sp_get_recent_receipts0(IN p_limit INT)
BEGIN
  SELECT r.id, r.importDate, r.note, s.name AS supplierName,
  (SELECT COALESCE(SUM(d.quantity * d.unitPrice),0) FROM tblImportDetail0 d WHERE d.tblImportReceipt0id = r.id) AS totalAmount
FROM tblImportReceipt0 r JOIN tblSupplier0 s ON s.id = r.tblSupplier0id
ORDER BY r.importDate DESC, r.id DESC LIMIT p_limit;
END$$

DROP PROCEDURE IF EXISTS sp_stat_dish_revenue0$$
CREATE PROCEDURE sp_stat_dish_revenue0(IN p_from DATE, IN p_to DATE)
BEGIN
  SELECT mi.id, mi.name, SUM(oi.quantity) AS totalQuantity, SUM(oi.quantity * oi.unitPrice) AS totalRevenue
FROM tblOrderItem0 oi JOIN tblOrder0 o ON o.id = oi.tblOrder0id
JOIN tblMenuItem0 mi ON mi.id = oi.tblMenuItem0id
WHERE o.status <> 'CANCELLED' AND CAST(o.orderTime AS DATE) BETWEEN p_from AND p_to
GROUP BY mi.id, mi.name
ORDER BY totalRevenue DESC;
END$$

DROP PROCEDURE IF EXISTS sp_stat_customer0$$
CREATE PROCEDURE sp_stat_customer0(IN p_from DATE, IN p_to DATE)
BEGIN
  SELECT m.id, m.fullName, COUNT(DISTINCT r.id) AS reservationCount, COALESCE(SUM(oi.quantity * oi.unitPrice),0) AS totalSpent
FROM tblMember0 m JOIN tblCustomer0 c ON c.tblMember0id = m.id
JOIN tblReservation0 r ON r.tblCustomer0id = c.tblMember0id
LEFT JOIN tblOrder0 o ON o.tblReservation0id = r.id AND o.status <> 'CANCELLED'
LEFT JOIN tblOrderItem0 oi ON oi.tblOrder0id = o.id
WHERE CAST(r.reservationTime AS DATE) BETWEEN p_from AND p_to
GROUP BY m.id, m.fullName
ORDER BY totalSpent DESC;
END$$

DELIMITER ;
