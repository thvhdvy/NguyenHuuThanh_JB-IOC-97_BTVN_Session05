CREATE TABLE students (
	student_id SERIAL PRIMARY KEY,
	full_name VARCHAR(100),
	major VARCHAR(50)
);
CREATE TABLE courses (
	course_id SERIAL PRIMARY KEY,
	course_name VARCHAR(100),
	credit INT
);
CREATE TABLE enrollments (
	students_id INT references students(student_id),
	course_id INT references courses(course_id),
	score NUMERIC(5,2)
);

INSERT INTO students (full_name, major) VALUES
('Nguyễn Văn A', 'CNTT'),
('Trần Thị B', 'Kinh tế'),
('Lê Văn C', 'CNTT'),
('Phạm Thị D', 'Ngôn ngữ Anh'),
('Hoàng Văn E', 'CNTT');

INSERT INTO courses (course_name, credit) VALUES
('Cơ sở dữ liệu', 3),
('Lập trình Python', 4),
('Kinh tế vi mô', 3),
('Tiếng Anh giao tiếp', 2),
('Cấu trúc dữ liệu', 4);

INSERT INTO enrollments (students_id, course_id, score) VALUES
(1, 1, 8.5),
(1, 2, 9.0),
(1, 5, 7.5),

(2, 3, 8.0),
(2, 4, 7.0),

(3, 1, 6.5),
(3, 2, 7.5),
(3, 5, 8.0),

(4, 4, 9.0),

(5, 1, 7.0),
(5, 2, 8.5),
(5, 5, 9.0);


-- 1. ALIAS:
-- 	a. Liệt kê danh sách sinh viên cùng tên môn học và điểm
-- 	b. dùng bí danh bảng ngắn (vd. s, c, e)
-- 	c. và bí danh cột như Tên sinh viên, Môn học, Điểm
SELECT s.full_name, c.course_name, e.score
FROM students s JOIN enrollments e ON s.student_id = e.students_id 
JOIN courses c ON c.course_id = e.course_id

-- 2. Aggregate Functions:
-- 	a. Tính cho từng sinh viên:
-- 		i. Điểm trung bình
-- 		ii. Điểm cao nhất
-- 		iii. Điểm thấp nhất
SELECT s.full_name, AVG(e.score) AS diem_tb, MAX(e.score) AS diem_cao_nhat, MIN(e.score) AS diem_thap_nhat 
FROM students s JOIN enrollments e ON s.student_id = e.students_id 
GROUP BY s.full_name

-- 3. GROUP BY / HAVING:
-- 	a. Tìm ngành học (major) có điểm trung bình cao hơn 7.5
SELECT s.major, AVG(e.score) AS diem_tb
FROM students s JOIN enrollments e ON s.student_id = e.students_id 
GROUP BY s.major 
HAVING AVG(e.score) > 7.5

-- 4. JOIN:
-- 	a. Liệt kê tất cả sinh viên, môn học, số tín chỉ và điểm (JOIN 3 bảng)
SELECT s.full_name, c.course_name, c.credit ,e.score
FROM students s JOIN enrollments e ON s.student_id = e.students_id 
JOIN courses c ON c.course_id = e.course_id

-- 5. Subquery:
-- 	a. Tìm sinh viên có điểm trung bình cao hơn điểm trung bình toàn trường
-- 	b. Gợi ý: dùng AVG(score) trong subquery
SELECT s.full_name, AVG(e.score) AS diem_tb
FROM students s JOIN enrollments e ON s.student_id = e.students_id 
GROUP BY s.full_name 
HAVING AVG(e.score) > (
	SELECT AVG(score) FROM enrollments 	
)

-- 6.  UNION và INTERSECT:
-- 	a. UNION: Danh sách sinh viên có điểm >= 9
-- 	 hoặc đã học ít nhất một môn
SELECT s.full_name
FROM students s JOIN enrollments e ON s.student_id = e.students_id
WHERE e.score >= 9
UNION
SELECT s.full_name 
FROM students s
WHERE s.student_id IN (SELECT DISTINCT student_id FROM enrollments)

-- 	b. INTERSECT: Danh sách sinh viên thỏa cả hai điều kiện trên
SELECT s.full_name
FROM students s JOIN enrollments e ON s.student_id = e.students_id
WHERE e.score >= 9
INTERSECT
SELECT s.full_name 
FROM students s
WHERE s.student_id IN (SELECT DISTINCT student_id FROM enrollments)
