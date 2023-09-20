CREATE DATABASE db_praktikum;
USE db_praktikum;
CREATE TABLE student(
	name VARCHAR(50) NOT NULL,
	email VARCHAR(255) UNIQUE,
	gender CHAR(1),
	student_id INT(11) PRIMARY KEY
);

CREATE TABLE classes(
	class_name VARCHAR(50),
	class_id INT(11) PRIMARY KEY AUTO_INCREMENT 
);

CREATE TABLE class_student(
	grade CHAR(1) DEFAULT "E",
	student_id INT(11),
	class_id INT(11), 
	enrollment_id INT(11) PRIMARY KEY AUTO_INCREMENT,
	FOREIGN KEY (student_id) REFERENCES student(student_id),
	FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

DESCRIBE class_student;
DESCRIBE classes;
DESCRIBE student;
DROP TABLE class_student;