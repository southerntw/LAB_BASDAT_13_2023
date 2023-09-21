CREATE DATABASE library;
USE library;

CREATE TABLE books(
	id INT PRIMARY KEY,
	isbn VARCHAR(50) UNIQUE,
	title VARCHAR(50) NOT NULL,
	pages INT,
	summary TEXT,
	genre VARCHAR(50) NOT NULL
);

SHOW TABLES;
DESCRIBE books;

ALTER TABLE books
MODIFY isbn CHAR(13);

ALTER TABLE books
DROP summary;

CREATE DATABASE db_praktikum;
USE db_praktikum;

CREATE TABLE students(
	nama VARCHAR(50),
	email VARCHAR(225),
	gender CHAR(1),
	students_id INT(11) PRIMARY KEY
);

CREATE TABLE classes(
	class_name VARCHAR(50),
	class_id INT(11) PRIMARY KEY AUTO_INCREMENT
);
 
CREATE TABLE class_student(
	grade CHAR(1) DEFAULT "E",
	students_id INT(11),
	class_id INT(11),
	enrollment_id INT(11) PRIMARY KEY AUTO_INCREMENT,
	FOREIGN KEY(class_id) REFERENCES classes(class_id),
	FOREIGN KEY(students_id) REFERENCES students(students_id)
);

DESCRIBE students;
DESCRIBE classes;
DESCRIBE class_student;




