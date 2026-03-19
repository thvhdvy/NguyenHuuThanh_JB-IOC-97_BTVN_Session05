-- 5. (Inner Join): Hiển thị 10 đơn hàng gần nhất gồm: Mã đơn, Tên khách hàng, Email và Tổng giá trị đơn hàng.
SELECT o.order_id AS "Mã đơn hàng", c.customer_name AS "Tên khách hàng", c.email AS "Email", o.total_amount AS "Tổng giá trị"
FROM orders o JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC
LIMIT 10
-- 6. (Left Join): Liệt kê tất cả danh mục (Categories) và số lượng sản phẩm thuộc danh mục đó (Kể cả danh mục chưa có sản phẩm).
SELECT ca.category_name AS "Tên danh mục", COUNT(*) AS "Số lượng"
FROM categories ca LEFT JOIN products p ON ca.category_id = p.category_id
GROUP BY ca.category_name
-- 7. (Group By & Having): Tìm các khách hàng đã đặt từ 3 đơn hàng trở lên và có tổng chi tiêu (total_amount) > 5.000.000 VNĐ.
SELECT c.customer_id AS "Mã khách hàng", c.customer_name AS "Tên khách hàng" 
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(*) >= 3 AND SUM(total_amount) > 5000000
-- 8. Thống kê tổng doanh thu theo từng tên danh mục sản phẩm (Nối 4 bảng: Categories, Products, Order_Items, Orders).
SELECT ca.category_name AS "Tên danh mục", SUM(o.total_amount) AS "Tổng doanh thu"
FROM categories ca LEFT JOIN products p ON p.category_id = ca.category_id
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
GROUP BY ca.category_name
