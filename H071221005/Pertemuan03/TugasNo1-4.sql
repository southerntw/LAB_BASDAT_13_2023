-- Pertemuan 03
-- Nomor 1
CREATE DATABASE  praktikum3;
USE praktikum3;
CREATE TABLE mahasiswa(
	NIM VARCHAR(10) NOT NULL PRIMARY KEY,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	status VARCHAR(50) NOT NULL,
	Nilai INT(11)
);
DESCRIBE mahasiswa;


INSERT INTO mahasiswa
VALUES('H071241056','Kotlina','A','Hadir',100),
		('H071241060','Pitonia','A','Alfa',85),
		('H071241063','Javano','A','Hadir',50),
		('H071241065','Ciplus Kuadra','B','Hadir',65),
		('H071241066','Pihap E','B','Hadir',85),
		('H071241079','Ruby','B','Alfa',90);
SELECT * FROM mahasiswa;
-- ------------------

-- Nomor 2
UPDATE mahasiswa
SET Kelas = 'C',Nilai = 0 
WHERE status = 'Alfa';	
SELECT * FROM mahasiswa;
-- ------------------

-- Nomor 3
DELETE FROM mahasiswa
WHERE Kelas = 'A' AND  Nilai > 90;
SELECT * FROM mahasiswa;
-- ------------------

-- Nomor 4
INSERT INTO mahasiswa
VALUES ('H071221005','Raehan','C','Pindahan',NULL);
SELECT * FROM mahasiswa;


UPDATE mahasiswa
SET Nilai = 50
WHERE status = 'Alfa';
SELECT * FROM mahasiswa;

UPDATE mahasiswa
SET Kelas = 'A';
SELECT * FROM mahasiswa;
-- ------------------

DROP DATABASE praktikum3;
	
