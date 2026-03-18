-- 1. Viết truy vấn con (Subquery) để tìm sản phẩm có doanh thu cao nhất trong bảng orders
-- a. Hiển thị: product_name, total_revenue
SELECT product_name, SUM(total_price) AS total_revenue
FROM products p JOIN orders o ON p.product_id = o.product_id
WHERE p.product_id = (
	SELECT p.product_id
	FROM products p JOIN orders o ON p.product_id = o.product_id
	GROUP BY p.product_id
	ORDER BY SUM(total_price) DESC
	LIMIT 1
	)
GROUP BY product_name

-- 2. Viết truy vấn hiển thị tổng doanh thu theo từng nhóm category (dùng JOIN + GROUP BY)
SELECT category, SUM(total_price) as total_revenue
FROM products p JOIN orders o ON p.product_id = o.product_id
GROUP BY category

-- 3. Dùng INTERSECT để tìm ra nhóm category có sản phẩm bán chạy nhất (ở câu 1) 
-- cũng nằm trong danh sách nhóm có tổng doanh thu lớn hơn 3000
SELECT category
FROM products p JOIN orders o ON p.product_id = o.product_id
WHERE p.product_id = (
	SELECT p.product_id
	FROM products p JOIN orders o ON p.product_id = o.product_id
	GROUP BY p.product_id
	ORDER BY SUM(total_price) DESC
	LIMIT 1
	)
GROUP BY category
INTERSECT
SELECT category FROM products p JOIN orders o ON p.product_id = o.product_id
GROUP BY category
HAVING SUM(total_price) > 3000
