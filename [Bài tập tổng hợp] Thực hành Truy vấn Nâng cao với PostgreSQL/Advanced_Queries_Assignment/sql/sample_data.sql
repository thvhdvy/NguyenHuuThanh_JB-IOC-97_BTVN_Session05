-- Categories
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255),
    category_id INT REFERENCES categories(category_id),
    price NUMERIC(12,2),
    stock_quantity INT
);

-- Customers
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    city VARCHAR(100),
    join_date DATE
);

-- Orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(12,2),
    status VARCHAR(50)
);

-- Order Items
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    unit_price NUMERIC(12,2)
);

-- Suppliers
CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(255),
    email VARCHAR(255)
);

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Books'),
('Clothing'),
('Home'),
('Sports');

INSERT INTO products (product_name, category_id, price, stock_quantity) VALUES
('Laptop Dell', 1, 20000000, 10),
('iPhone 13', 1, 25000000, 5),
('Samsung TV', 1, 15000000, 8),
('Harry Potter', 2, 200000, 50),
('Clean Code', 2, 350000, 30),
('T-shirt', 3, 150000, 100),
('Jeans', 3, 500000, 60),
('Sofa', 4, 7000000, 3),
('Dining Table', 4, 5000000, 2),
('Football', 5, 300000, 40),
('Basketball', 5, 400000, 35);

INSERT INTO customers (customer_name, email, city, join_date) VALUES
('Nguyen Van A', 'a@gmail.com', 'Hanoi', '2024-01-10'),
('Tran Thi B', 'b@gmail.com', 'HCM', '2024-02-15'),
('Le Van C', 'c@gmail.com', 'Danang', '2024-03-20'),
('Pham Thi D', 'd@gmail.com', 'Hanoi', '2024-04-25'),
('Hoang Van E', 'e@gmail.com', 'HCM', '2024-05-05'),
('Do Thi F', 'f@gmail.com', 'HCM', '2024-06-01'),
('Nguyen Van G', 'g@gmail.com', 'Danang', '2024-07-10');

INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(1, '2026-01-10', 0, 'Completed'),
(1, '2026-02-10', 0, 'Pending'),
(2, '2026-01-12', 0, 'Completed'),
(2, '2026-03-01', 0, 'Cancelled'),
(3, '2026-01-15', 0, 'Completed'),
(3, '2026-02-20', 0, 'Completed'),
(3, '2026-03-10', 0, 'Completed'),
(4, '2026-01-18', 0, 'Pending'),
(5, '2026-02-25', 0, 'Completed'),
(6, '2026-03-05', 0, 'Completed');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 20000000),
(1, 4, 2, 200000),

(2, 2, 1, 25000000),

(3, 3, 1, 15000000),
(3, 5, 1, 350000),

(4, 6, 3, 150000),

(5, 4, 1, 200000),
(5, 10, 2, 300000),

(6, 2, 1, 25000000),

(7, 1, 1, 20000000),
(7, 5, 2, 350000),

(8, 7, 1, 500000),

(9, 8, 1, 7000000),

(10, 11, 2, 400000);

INSERT INTO suppliers (supplier_name, email) VALUES
('Supplier A', 'supA@gmail.com'),
('Supplier B', 'supB@gmail.com'),
('Supplier C', 'supC@gmail.com');