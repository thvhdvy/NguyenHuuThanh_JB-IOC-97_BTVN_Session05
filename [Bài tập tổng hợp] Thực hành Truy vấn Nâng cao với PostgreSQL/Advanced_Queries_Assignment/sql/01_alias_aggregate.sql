-- 1. Liệt kê danh sách sản phẩm với tên sản phẩm được đặt ALIAS là "Tên SP", giá được đặt ALIAS là "Đơn giá"
SELECT p.product_name AS Ten_SP, p.price AS Don_gia
FROM products p 
-- 2. Tính tổng số khách hàng theo từng thành phố
SELECT c.city AS Thanh_pho, COUNT(c.customer_id) AS So_khach_hang
FROM customers c
GROUP BY c.city
-- 3. Tìm giá cao nhất, thấp nhất và trung bình của sản phẩm theo từng danh mục
SELECT ca.category_name AS Danh_muc, MAX(p.price) AS gia_cao_nhat, MIN(p.price) AS gia_thap_nhat, AVG(p.price) AS gia_trung_binh 
FROM categories ca JOIN products p ON p.category_id = ca.category_id
GROUP BY ca.category_name
-- 4. Đếm số đơn hàng theo từng trạng thái
SELECT o.status AS Trang_thai, COUNT(*) AS So_luong
FROM orders o 
GROUP BY o.status

