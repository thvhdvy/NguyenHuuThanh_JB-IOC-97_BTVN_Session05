-- 16. Viết truy vấn cập nhật lại total_amount trong bảng orders dựa trên tổng tiền từ bảng order_items tương ứng.
UPDATE orders o
SET total_amount = sub.total
FROM (
    SELECT order_id, SUM(quantity * unit_price) AS total
    FROM order_items
    GROUP BY order_id
) sub
WHERE o.order_id = sub.order_id;
-- 17. Tạo một View tên là vw_customer_summary hiển thị: Tên khách hàng, Tổng số đơn đã mua, Tổng số tiền đã chi tiêu.
CREATE VIEW vw_customer_summary AS
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
-- 18. Viết truy vấn tìm thành phố có doanh thu cao nhất trong năm 2026.
SELECT c.city, SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2026
GROUP BY c.city
ORDER BY total_revenue DESC
LIMIT 1;