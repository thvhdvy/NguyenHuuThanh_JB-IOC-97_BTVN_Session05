CREATE TABLE departments (
	dept_id SERIAL PRIMARY KEY,
	dept_name VARCHAR(100)
);
CREATE TABLE employees (
	emp_id SERIAL PRIMARY KEY,
	emp_name VARCHAR(100),
	dept_id INT REFERENCES departments(dept_id),
	salary NUMERIC(10, 2),
	hire_date DATE	
);
CREATE TABLE projects (
	project_id SERIAL PRIMARY KEY,
	project_name VARCHAR(100),
	dept_id INT REFERENCES departments(dept_id)
);

INSERT INTO departments (dept_name) VALUES
('IT'),
('Nhân sự'),
('Kế toán'),
('Marketing');

INSERT INTO employees (emp_name, dept_id, salary, hire_date) VALUES
('Nguyễn Văn A', 1, 1500, '2022-01-10'),
('Trần Thị B', 2, 1200, '2021-03-15'),
('Lê Văn C', 1, 2000, '2020-07-20'),
('Phạm Thị D', 3, 1800, '2023-02-01'),
('Hoàng Văn E', 4, 1300, '2022-06-25'),
('Đỗ Văn F', 1, 2200, '2019-11-11'),
('Nguyễn Thị G', 2, 1400, '2023-05-05'),
('Trần Văn H', 3, 1700, '2021-09-09');

INSERT INTO projects (project_name, dept_id) VALUES
('Hệ thống quản lý nhân sự', 1),
('Website bán hàng', 1),
('Chiến dịch quảng cáo Tết', 4),
('Tối ưu chi phí', 3),
('Đào tạo nhân viên mới', 2);

-- 1. ALIAS:
-- 	a. Hiển thị danh sách nhân viên gồm: Tên nhân viên, Phòng ban, Lương
-- 	b. dùng bí danh bảng ngắn (employees as e,departments as d).
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e JOIN departments d ON e.dept_id = d.dept_id

-- 2. Aggregate Functions:
-- 	a. Tính:
-- 		i. Tổng quỹ lương toàn công ty
SELECT SUM(salary) FROM employees
-- 		ii. Mức lương trung bình
SELECT AVG(salary) FROM employees
-- 		iii. Lương cao nhất, thấp nhất
SELECT MAX(salary), MIN(salary) FROM employees
-- 		iv. Số nhân viên
SELECT COUNT(*) FROM employees

-- 3. GROUP BY / HAVING:
-- 	a. Tính mức lương trung bình của từng phòng ban
SELECT d.dept_name, AVG(e.salary)
FROM employees e JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name

-- 	b. chỉ hiển thị những phòng ban có lương trung bình > 15.000.000
SELECT d.dept_name, AVG(e.salary)
FROM employees e JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 1500.00

-- 4. JOIN:
-- 	a. Liệt kê danh sách dự án (project) cùng với phòng ban phụ trách và nhân viên thuộc phòng ban đó
SELECT p.project_name, d.dept_name, e.emp_name
FROM projects p JOIN departments d ON d.dept_id = p.dept_id
JOIN employees e ON e.dept_id = d.dept_id

-- 5. Subquery:
-- 	a. Tìm nhân viên có lương cao nhất trong mỗi phòng ban
-- 	b. Gợi ý: Subquery lồng trong WHERE salary = (SELECT MAX(...))
SELECT emp_name FROM employees 
WHERE salary = (SELECT MAX(salary) FROM employees)

-- 6. UNION và INTERSECT:
-- 	a. UNION: Liệt kê danh sách tất cả các phòng ban có nhân viên hoặc có dự án
SELECT dept_name FROM departments WHERE dept_id IN (SELECT DISTINCT dept_id FROM employees)
UNION
SELECT dept_name FROM departments WHERE dept_id IN (SELECT DISTINCT dept_id FROM projects)
-- 	b. INTERSECT: Liệt kê các phòng ban vừa có nhân viên vừa có dự án
SELECT dept_name FROM departments WHERE dept_id IN (SELECT DISTINCT dept_id FROM employees)
INTERSECT
SELECT dept_name FROM departments WHERE dept_id IN (SELECT DISTINCT dept_id FROM projects)