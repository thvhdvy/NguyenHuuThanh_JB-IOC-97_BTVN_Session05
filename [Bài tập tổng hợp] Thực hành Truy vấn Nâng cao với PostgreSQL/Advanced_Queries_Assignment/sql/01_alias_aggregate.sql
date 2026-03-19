-- 1. Liệt kê danh sách sản phẩm gồm: Tên sản phẩm (Alias: "Tên SP"), 
-- Giá niêm yết (Alias: "Đơn giá") và "Giá sau thuế" (Giá * 1.1, Alias: "Giá VAT").
SELECT p.product_name AS "Tên SP", p.price AS "Đơn giá", p.price*1.1 AS "Giá VAT" 
FROM products p
-- 2. Đếm tổng số khách hàng hiện có theo từng thành phố (Sắp xếp giảm dần theo số lượng).
SELECT c.city AS "Thành phố", COUNT(*) AS "Số lượng"
FROM customers c
GROUP BY c.city
ORDER BY COUNT(*) DESC
-- 3. Tính giá cao nhất, thấp nhất và trung bình của các sản phẩm có trong kho.
SELECT MAX(p.price) AS "Giá cao nhất", MIN(p.price) AS "Giá thấp nhất", AVG(p.price) AS "Giá trung bình"
FROM products p
-- 4. Thống kê số lượng đơn hàng theo từng trạng thái (Status).
SELECT o.status AS "Trạng thái", COUNT(*) AS "Số lượng"
FROM orders o 
GROUP BY o.status