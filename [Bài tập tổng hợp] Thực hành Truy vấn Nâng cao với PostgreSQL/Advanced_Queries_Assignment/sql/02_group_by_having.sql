-- 5. Tìm các khách hàng có từ 3 đơn hàng trở lên
SELECT c.customer_name AS Ten_KH
FROM customers c JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING COUNT(*) >= 3

-- 6. Liệt kê các danh mục có tổng số lượng sản phẩm tồn kho > 100
SELECT ca.category_name AS Danh_muc
FROM categories ca JOIN products p ON p.category_id = ca.category_id
GROUP BY ca.category_name
HAVING SUM(p.stock_quantity) > 100

-- 7. Tìm các thành phố có số khách hàng >= 5
SELECT c.city 
FROM customers c
GROUP BY c.city
HAVING COUNT(*) >= 5

-- 8. Liệt kê các sản phẩm có tổng số lượng bán ra > 50
SELECT p.product_id, p.product_name AS Ten_SP, SUM(oi.quantity) AS So_luong_ban
FROM products p 
JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) > 50;	