-- 9. Tìm khách hàng có tổng giá trị đơn hàng cao nhất
SELECT c.customer_id, c.customer_name, SUM(total_amount) AS tong_gia_tri
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(total_amount) = (
	SELECT MAX(tong)
	FROM (
		SELECT SUM(total_amount) AS tong
		FROM orders
		GROUP BY customer_id
	)
)
-- 10. Liệt kê sản phẩm chưa từng được bán
SELECT p.product_id, p.product_name
FROM products p 
WHERE p.product_id NOT IN (
	SELECT DISTINCT oi.product_id
	FROM order_items oi
)

-- 11. Tìm khách hàng có đơn hàng đầu tiên trong tháng hiện tại
SELECT c.customer_id, c.customer_name, MIN(o.order_date) as don_hang_dau_tien
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
WHERE EXTRACT(MONTH FROM o.order_date) = (SELECT EXTRACT(MONTH FROM CURRENT_DATE)) 
AND EXTRACT(YEAR FROM o.order_date) = (SELECT EXTRACT(YEAR FROM CURRENT_DATE)) 
GROUP BY c.customer_id

-- 12. Liệt kê sản phẩm có giá cao hơn giá trung bình của danh mục đó
SELECT p.product_id, p.product_name, p.price
FROM products p
WHERE p.price > (
	SELECT AVG(p2.price) as Trung_binh
	FROM products p2
	WHERE p2.category_id = p.category_id
)

