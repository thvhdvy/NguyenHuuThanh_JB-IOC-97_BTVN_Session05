-- 13. (UNION): Gộp danh sách Email của khách hàng và Email của các nhà cung cấp (giả sử có bảng suppliers) 
-- để làm danh sách gửi tin NewsLetter.
SELECT c.email FROM customers c
UNION
SELECT s.email FROM suppliers s
-- 14. (INTERSECT): Tìm danh sách customer_id vừa mua sản phẩm thuộc danh mục 'Electronics' vừa mua sản phẩm thuộc danh mục 'Books'.
SELECT c.customer_id
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
JOIN categories ca ON ca.category_id = p.category_id
WHERE ca.category_name = 'Electronics'
INTERSECT
SELECT c.customer_id
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
JOIN categories ca ON ca.category_id = p.category_id
WHERE ca.category_name = 'Books'
-- 15. (EXCEPT): Tìm danh sách các sản phẩm có trong kho (products) nhưng chưa từng xuất hiện trong bất kỳ đơn hàng nào (order_items).
SELECT p.product_name AS "Tên SP"
FROM products p LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL