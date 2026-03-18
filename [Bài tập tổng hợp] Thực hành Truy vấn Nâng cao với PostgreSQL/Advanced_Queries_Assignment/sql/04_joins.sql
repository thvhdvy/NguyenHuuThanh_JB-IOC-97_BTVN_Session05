-- 13. Hiển thị thông tin đơn hàng kèm tên khách hàng và email (INNER JOIN)
SELECT o.order_id as ma_don_hang, c.customer_name as ten_khach_hang, c.email, o.order_date as ngay_dat, o.status as trang_thai
FROM orders o 
LEFT JOIN customers c ON c.customer_id = o.customer_id

-- 14. Liệt kê tất cả khách hàng và số đơn hàng của họ (LEFT JOIN)
SELECT c.customer_name as ten_khach_hang, COUNT(o.order_id) as so_don_hang
FROM orders o
LEFT JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.customer_name

-- 15. Hiển thị tất cả sản phẩm và số lượng đã bán (LEFT JOIN)
SELECT p.product_name as ten_san_pham, SUM(oi.quantity) as so_da_ban
FROM products p 
JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY p.product_name

-- 16. Liệt kê tất cả danh mục và số sản phẩm trong mỗi danh mục (LEFT JOIN)