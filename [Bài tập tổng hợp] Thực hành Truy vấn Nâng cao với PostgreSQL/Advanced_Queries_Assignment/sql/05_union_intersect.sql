-- 17. Gộp danh sách email từ bảng customers và một danh sách email marketing
SELECT email FROM customers
UNION
SELECT email FROM marketing_emails

-- 18. Tìm khách hàng vừa mua sản phẩm category 'Electronics' vừa mua 'Books'
SELECT c.customer_id, c.customer_name
FROM customers c 
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories ca ON ca.category_id = p.category_id
WHERE ca.category_name = 'Electronics'
GROUP BY c.customer_id, c.customer_name
INTERSECT
SELECT c.customer_id, c.customer_name
FROM customers c 
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories ca ON ca.category_id = p.category_id
WHERE ca.category_name = 'Books'
GROUP BY c.customer_id, c.customer_name

-- 19. So sánh danh sách sản phẩm bán chạy tháng này và tháng trước
SELECT p.product_id, p.product_name
FROM products p 
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE EXTRACT(YEAR FROM o.order_date) = EXTRACT(YEAR FROM CURRENT_DATE) 
AND EXTRACT(MONTH FROM o.order_date) = EXTRACT(MONTH FROM CURRENT_DATE) 
GROUP BY p.product_id, p.product_name
INTERSECT
SELECT p.product_id, p.product_name
FROM products p 
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE EXTRACT(YEAR FROM o.order_date) = EXTRACT(YEAR FROM CURRENT_DATE) 
AND EXTRACT(MONTH FROM o.order_date) = EXTRACT(MONTH FROM CURRENT_DATE - INTERVAL '1 month')
GROUP BY p.product_id, p.product_name

-- 20. Tìm khách hàng có ở cả hai thành phố Hà Nội và TP.HCM (giả sử có bảng customer_addresses)
SELECT c.customer_id, c.customer_name
FROM customer_addresses ca JOIN customers c ON ca.customer_id = c.customer_id
WHERE ca.city = 'Hà Nội'
INTERSECT
SELECT c.customer_id, c.customer_name
FROM customer_addresses ca JOIN customers c ON ca.customer_id = c.customer_id
WHERE ca.city = 'Hồ Chí Minh'
