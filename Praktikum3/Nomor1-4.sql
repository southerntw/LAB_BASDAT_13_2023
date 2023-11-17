-- CREATE DATABASE praktikum3;

USE praktikum3;

-- No.1
CREATE TABLE mahasiswa (
	NIM VARCHAR(10) NOT NULL PRIMARY KEY,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	STATUS VARCHAR(50) NOT NULL,
	Nilai INT(11)
)

DESCRIBE mahasiswa;
SELECT * FROM mahasiswa;

INSERT INTO mahasiswa
VALUES ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
		('H071241060', 'Pitonia', 'A', 'Alfa', 85),
		('H071241063', 'Javano', 'A', 'Hadir', 50),
		('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		('H071241079', 'Ruby', 'B', 'Alfa', 90);
		
-- No.2
UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE STATUS = 'Alfa';

-- No.3
DELETE FROM mahasiswa
WHERE Kelas = 'A' AND Nilai > 90;

-- No.4
INSERT INTO mahasiswa (NIM, Nama, Kelas, STATUS)
VALUES ('H071221076', 'Elva Aprili Timang', 'B', 'Pindahan');

UPDATE mahasiswa
SET Nilai = 50
WHERE STATUS = 'Alfa';

UPDATE mahasiswa
SET Kelas = 'A';
