CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10,2)
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_name VARCHAR(100),
    quantity INT,
    price NUMERIC(10,2)
);

INSERT INTO customers (customer_name, city) VALUES
('Nguyễn Văn A', 'Hà Nội'),
('Trần Thị B', 'Đà Nẵng'),
('Lê Văn C', 'Hồ Chí Minh'),
('Phạm Thị D', 'Hà Nội'),
('Hoàng Văn E', 'Đà Nẵng');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-12-20', 3000),
(2, '2025-01-05', 1500),
(1, '2025-02-10', 2500),
(3, '2025-02-15', 4000),
(4, '2025-03-01', 800),
(5, '2025-03-10', 2200),
(2, '2025-03-12', 1800);

INSERT INTO order_items (order_id, product_name, quantity, price) VALUES
(1, 'Laptop Dell', 2, 1500),
(2, 'iPhone 15', 1, 1500),
(3, 'Bàn học gỗ', 5, 500),
(4, 'Tai nghe Sony', 4, 1000),
(5, 'Ghế xoay', 2, 400),
(6, 'Chuột Logitech', 2, 1100),
(7, 'Bàn phím cơ', 3, 600);

-- 1. ALIAS:
-- 	a.  Hiển thị danh sách tất cả các đơn hàng với các cột:
-- 		i. Tên khách (customer_name)
-- 		ii. Ngày đặt hàng (order_date)
-- 		iii. Tổng tiền (total_amount)
SELECT c.customer_name AS ten_khach_hang, o.order_date AS ngay_dat_hang, o.total_amount AS tong_tien
FROM customers c JOIN orders o ON c.customer_id = o.customer_id

-- 2. Aggregate Functions:
-- 	a. Tính các thông tin tổng hợp:
-- 		i. Tổng doanh thu (SUM(total_amount))
SELECT SUM(total_amount) AS tong_doanh_thu FROM orders
-- 		ii. Trung bình giá trị đơn hàng (AVG(total_amount))
SELECT AVG(total_amount) AS trung_binh_don_hang FROM orders
-- 		iii. Đơn hàng lớn nhất (MAX(total_amount))
SELECT MAX(total_amount) AS don_hang_lon_nhat FROM orders
-- 		iv. Đơn hàng nhỏ nhất (MIN(total_amount))
SELECT MIN(total_amount) AS don_hang_nho_nhat FROM orders
-- 		v. Số lượng đơn hàng (COUNT(order_id))
SELECT COUNT(order_id) AS so_luong_don_hang FROM orders

-- 3. GROUP BY / HAVING:
-- 	a. Tính tổng doanh thu theo từng thành phố
-- 	b. chỉ hiển thị những thành phố có tổng doanh thu lớn hơn 10.000
SELECT c.city, SUM(total_amount) as tong_doanh_thu 
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(total_amount) > 10.000

-- 4. JOIN:
-- 	a. Liệt kê tất cả các sản phẩm đã bán, kèm:
-- 		i. Tên khách hàng
-- 		ii. Ngày đặt hàng
-- 		iii. Số lượng và giá
-- 		iv. (JOIN 3 bảng customers, orders, order_items)
SELECT d.product_name, c.customer_name, o.order_date, d.quantity, d.price
FROM customers c 
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items d ON d.order_id = o.order_id

-- 5. Subquery:
-- 	i. Tìm tên khách hàng có tổng doanh thu cao nhất.
-- 	ii. Gợi ý: Dùng SUM(total_amount) trong subquery để tìm MAX
SELECT c.customer_name
FROM customers c
WHERE c.customer_id = (
	SELECT c.customer_id
	FROM customers c 
	JOIN orders o ON o.customer_id = c.customer_id
	GROUP BY c.customer_id 
	ORDER BY SUM(total_amount) DESC
	LIMIT 1
)

-- 6. UNION và INTERSECT:
-- 	a. Dùng UNION để hiển thị danh sách tất cả thành phố có khách hàng hoặc có đơn hàng
SELECT city FROM customers
UNION
SELECT DISTINCT c.city FROM customers c JOIN orders o ON c.customer_id = o.customer_id

-- 	b. Dùng INTERSECT để hiển thị các thành phố vừa có khách hàng vừa có đơn hàng
SELECT city FROM customers
INTERSECT
SELECT DISTINCT c.city FROM customers c JOIN orders o ON c.customer_id = o.customer_id
