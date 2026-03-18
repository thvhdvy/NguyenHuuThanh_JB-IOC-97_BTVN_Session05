-- Tạo bảng products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100)
);
-- Tạo bảng orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    total_price NUMERIC,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_id, product_name, category) VALUES
(1, 'Laptop Dell', 'Electronics'),
(2, 'IPhone 15', 'Electronics'),
(3, 'Bàn học gỗ', 'Furniture'),
(4, 'Ghế xoay', 'Furniture');

INSERT INTO orders (order_id, product_id, quantity, total_price) VALUES
(101, 1, 2, 2200),
(102, 2, 3, 3300),
(103, 3, 5, 2500),
(104, 4, 4, 1600),
(105, 1, 1, 1100);

-- 1. Viết truy vấn hiển thị tổng doanh thu (SUM(total_price)) và số lượng sản phẩm bán được (SUM(quantity)) cho từng nhóm danh mục (category)
-- a. Đặt bí danh cột như sau:
-- i. total_sales cho tổng doanh thu
-- ii. total_quantity cho tổng số lượng
-- 2. Chỉ hiển thị những nhóm có tổng doanh thu lớn hơn 2000
-- 3. Sắp xếp kết quả theo tổng doanh thu giảm dần
SELECT category, SUM(total_price) as total_sales, SUM(quantity) as total_quantity 
FROM products p JOIN orders o ON p.product_id = o.product_id
GROUP BY category
HAVING SUM(total_price) > 2000
ORDER BY SUM(total_price) DESC