-- Bảng customers 
CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	customer_name VARCHAR(100),
	email VARCHAR(100) UNIQUE,
	city VARCHAR(100),
	join_date DATE
);

-- Bảng categories
CREATE TABLE categories (
	category_id SERIAL PRIMARY KEY,
	category_name VARCHAR(100),
	description VARCHAR(255)
);

-- Bảng products
CREATE TABLE products (
	product_id SERIAL PRIMARY KEY,
	product_name VARCHAR(100),
	category_id INT REFERENCES categories(category_id),
	price NUMERIC(10, 2),
	stock_quantity INT DEFAULT 1
);

-- Bảng orders 
CREATE TABLE orders (
	order_id SERIAL PRIMARY KEY,
	customer_id INT REFERENCES customers(customer_id),
	order_date DATE,
	total_amount NUMERIC(10, 2),
	status VARCHAR(100) CHECK (status IN ('pending', 'completed', 'cancelled'))
);

-- Bảng order_items 
CREATE TABLE order_items (
	order_id INT REFERENCES orders(order_id),
	product_id INT REFERENCES products(product_id),
	quantity INT CHECK (quantity > 0),
	unit_price NUMERIC(10, 2),
	PRIMARY KEY(order_id, product_id)
);

-- INSERT DỮ LIỆU
-- Insert Bảng categories
INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Thiết bị điện tử'),
('Furniture', 'Nội thất'),
('Clothing', 'Quần áo'),
('Books', 'Sách và tài liệu');

-- Insert Bảng products
INSERT INTO products (product_name, category_id, price, stock_quantity) VALUES
('Laptop Dell', 1, 1500, 10),
('iPhone 15', 1, 1200, 15),
('Bàn học gỗ', 2, 300, 20),
('Ghế xoay', 2, 200, 25),
('Áo thun nam', 3, 50, 50),
('Quần jean nữ', 3, 80, 40),
('Sách SQL cơ bản', 4, 25, 100),
('Sách Python nâng cao', 4, 30, 80);
INSERT INTO products (product_name, category_id, price, stock_quantity) VALUES
('Tablet Samsung', 1, 800, 60),
('Macbook Pro', 1, 2500, 50),
('Tủ quần áo', 2, 700, 70),
('Giường ngủ', 2, 900, 80),
('Áo khoác', 3, 120, 40),
('Giày thể thao', 3, 150, 60),
('Sách AI', 4, 45, 120),
('Sách Machine Learning', 4, 55, 130);

-- Insert Bảng customers
INSERT INTO customers (customer_name, email, city, join_date) VALUES
('Nguyễn Văn A', 'a@gmail.com', 'Hà Nội', '2024-01-10'),
('Trần Thị B', 'b@gmail.com', 'Đà Nẵng', '2024-02-15'),
('Lê Văn C', 'c@gmail.com', 'Hồ Chí Minh', '2024-03-20'),
('Phạm Thị D', 'd@gmail.com', 'Hà Nội', '2024-04-05'),
('Hoàng Văn E', 'e@gmail.com', 'Đà Nẵng', '2024-05-12');
INSERT INTO customers (customer_name, email, city, join_date) VALUES
('Nguyễn Văn F', 'f@gmail.com', 'Hà Nội', '2025-01-01'),
('Nguyễn Văn G', 'g@gmail.com', 'Hà Nội', '2025-01-02'),
('Nguyễn Văn H', 'h@gmail.com', 'Hà Nội', '2025-01-03'),
('Nguyễn Văn I', 'i@gmail.com', 'Hà Nội', '2025-01-04'),

('Trần Văn J', 'j@gmail.com', 'Hồ Chí Minh', '2025-01-05'),
('Trần Văn K', 'k@gmail.com', 'Hồ Chí Minh', '2025-01-06'),
('Trần Văn L', 'l@gmail.com', 'Hồ Chí Minh', '2025-01-07'),
('Trần Văn M', 'm@gmail.com', 'Hồ Chí Minh', '2025-01-08');

-- Insert Bảng orders 
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(1, '2024-12-20', 3000, 'completed'),
(2, '2025-01-05', 1500, 'completed'),
(1, '2025-02-10', 2500, 'pending'),
(3, '2025-02-15', 4000, 'completed'),
(4, '2025-03-01', 800, 'cancelled'),
(5, '2025-03-10', 2200, 'completed');
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
-- customer 1
(1, '2025-03-01', 1000, 'completed'),
(1, '2025-03-05', 1200, 'completed'),
(1, '2025-03-10', 900, 'completed'),

-- customer 2
(2, '2025-02-15', 1500, 'completed'),
(2, '2025-03-12', 1800, 'completed'),

-- customer 3
(3, '2025-02-20', 2000, 'completed'),

-- nhiều order tháng trước
(4, '2025-02-01', 700, 'completed'),
(5, '2025-02-10', 800, 'completed'),

-- tháng hiện tại
(6, CURRENT_DATE, 2200, 'completed'),
(7, CURRENT_DATE, 1300, 'completed');

-- Insert Bảng order_items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- Order 1
(1, 1, 2, 1500),

-- Order 2
(2, 2, 1, 1500),

-- Order 3
(3, 3, 5, 500),

-- Order 4
(4, 2, 2, 1200),
(4, 4, 4, 200),

-- Order 5
(5, 4, 2, 400),

-- Order 6
(6, 1, 1, 1500),
(6, 7, 2, 25);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- sản phẩm bán nhiều
(2, 1, 15, 1500),
(3, 1, 20, 1500),

-- Electronics + Books
(4, 7, 3, 25),

(5, 2, 5, 1200),
(5, 8, 4, 30),

-- sản phẩm khác
(6, 3, 10, 300),
(7, 4, 8, 200),
(8, 5, 6, 50),
(9, 6, 7, 80),
(10, 7, 5, 25);

CREATE TABLE marketing_emails (
    email VARCHAR(100) PRIMARY KEY
);

INSERT INTO marketing_emails (email) VALUES
('promo1@gmail.com'),
('promo2@gmail.com'),
('promo3@gmail.com'),
('a@gmail.com'),   -- trùng với customers để test UNION
('b@gmail.com');

CREATE TABLE customer_addresses (
    address_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    city VARCHAR(100)
);
INSERT INTO customer_addresses (customer_id, city) VALUES
-- khách có cả 2 thành phố (dùng để test câu 20)
(1, 'Hà Nội'),
(1, 'Hồ Chí Minh'),

(2, 'Hà Nội'),
(2, 'Đà Nẵng'),

(3, 'Hồ Chí Minh'),

(4, 'Hà Nội'),
(4, 'Hồ Chí Minh'),

(5, 'Đà Nẵng');
