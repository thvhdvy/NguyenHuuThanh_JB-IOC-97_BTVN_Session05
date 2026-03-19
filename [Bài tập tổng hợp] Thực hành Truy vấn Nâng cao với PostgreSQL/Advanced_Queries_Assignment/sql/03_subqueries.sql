-- 9. Tìm thông tin sản phẩm có giá cao hơn giá trung bình của tất cả sản phẩm trong hệ thống.
SELECT * 
FROM products p 
WHERE p.price > (SELECT AVG(p.price) FROM products p)
-- 10. Tìm các khách hàng chưa từng phát sinh bất kỳ đơn hàng nào (Sử dụng NOT EXISTS).
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
-- 11. Liệt kê các sản phẩm có giá cao hơn giá trung bình của chính danh mục mà sản phẩm đó thuộc về (Correlated Subquery).
SELECT * 
FROM products p1 
WHERE p1.price > (
	SELECT AVG(p2.price)
	FROM products p2 
	WHERE p2.category_id = p1.category_id
) 
-- 12. Tìm khách hàng đã thực hiện đơn hàng có giá trị lớn nhất trong toàn bộ hệ thống.
SELECT c.customer_id AS "Mã khách hàng", c.customer_name AS "Tên khách hàng"
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id = (
	SELECT ma_don_lon_nhat 
	FROM (
		SELECT order_id AS ma_don_lon_nhat, MAX(total_amount)
		FROM orders
		GROUP BY order_id
		LIMIT 1
	)
)