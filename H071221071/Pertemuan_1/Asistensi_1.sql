CREATE DATABASE Entertainment
USE Entertainment;

CREATE TABLE series(
id INT AUTO_INCREMENT PRIMARY KEY, 
series_nama VARCHAR(50) UNIQUE,
pembuat VARCHAR(50),
tanggal_rilis DATE,
gendre VARCHAR (50),
rating INT(10),
jumlah_episode INT,
streaming_platform INT,
platform_id INT,

FOREIGN KEY (platform_id) REFERENCES platform(platform_id)
);

CREATE TABLE platform(
	platform_id INT AUTO_INCREMENT PRIMARY KEY,
	nama_platform VARCHAR
		
	);
	
DESCRIBE series
