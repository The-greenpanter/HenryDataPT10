SHOW VARIABLES LIKE "secure_file_priv";
SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET @@global.secure-file-priv = "/Users/the.greenpanter/Documents/Soyhenry/HenryClasesPTdata_10/Modulo3";
-- SELECT @@global.secure_file_priv; -- Para ver la ruta de origen donde poner los csv. 

USE PracticaCP;
LOAD DATA INFILE '/Users/the.greenpanter/Documents/Soyhenry/HenryClasesPTdata_10/Modulo3/PracticaCP/practica-m03/participantes-2.csv'
INTO TABLE participantes
FIELDS TERMINATED BY ',' -- El delimitador de campos en tu archivo CSV
LINES TERMINATED BY '\n' -- El delimitador de línea en tu archivo CSV
IGNORE 1 LINES; -- Para ignorar la primera línea si contiene encabezados de columna
