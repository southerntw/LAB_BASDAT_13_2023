CREATE DATABASE praktikum3;

USE praktikum3;


CREATE TABLE mahasiswa(
		NIM VARCHAR(10)PRIMARY KEY,
		Nama VARCHAR(50)NOT NULL,
		Kelas CHAR(1)NOT NULL,
		`Status` VARCHAR(50)NOT NULL,
		Nilai INT(11)NULL
);

DESC mahasiswa;


INSERT INTO mahasiswa(NIM, Nama, Kelas, `Status`, Nilai)
VALUE
		('H071241060', 'Pitonia', 'A', 'Alfa', 85),
		('H071241063', 'Javano', 'A', 'Hadir', 50),
		('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		('H071241079', 'Ruby', 'B', 'Alfa', 90);
SELECT* FROM mahasiswa

#NO2
UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE `Status` = 'Alfa';
SELECT*FROM mahasiswa

#NO3
DELETE FROM mahasiswa
WHERE kelas = 'A' AND Nilai >90;
SELECT * FROM mahasiswa

#NO4
INSERT INTO mahasiswa(NIM, Nama, Kelas, `Status`, Nilai)
VALUE ('H071221071', 'Rama', 'B', 'Pindahan', NULL);
SELECT*FROM mahasiswa

UPDATE mahasiswa
SET Nilai = 50
WHERE `Status` = 'Alfa';
SELECT*FROM mahasiswa

UPDATE mahasiswa
SET kelas = 'A';
SELECT*FROM mahasiswa

#NO5

DROP TABLE mahasiswa;

UPDATE mahasiswa
SET Nilai = 70
WHERE NIM = 'H071221071';