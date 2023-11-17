USE praktikum3;

CREATE TABLE mahasiswa{
	NIM VARCHAR(10) PRIMARY KEY NOT NULL,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	staatus VARCHAR(50) NOT NULL,
	Nilai INT(11)
};

INSERT INTO mahasiswa 
VALUES (H071241056, 'Kotlina','A', 'Hadir', 100), 
(H071241060, 'Pitonia', 'A', 'Alfa', 85),
(H071241063, 'Javano', 'A', 'Hadir', 50),
(H071241065, ' Ciplus Kuadra', 'B', 'Hadir', 65),
(H071241066, 'Pihap E', 'B', 'Hadir', 85),
(H071241079, 'Ruby', 'B', 'Alfa', 90);

UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE staatus = 'Alfa';

DELETE FROM mahasiswa
WHERE Kelas = 'A', Nilai > 90;

INSERT INTO mahasiswa(NIM, Nama, Kelas, staatus)
VALUES(H071221043, 'Mezaluna', 'A', 'Pindahan', NULL );

UPDATE mahasiswa
SET Nilai = 50
WHERE staatus = 'Alfa';

UPDATE mahasiswa
SET Kelas = 'A'
WHERE Kelas = 'B' AND Kelas = 'C';
