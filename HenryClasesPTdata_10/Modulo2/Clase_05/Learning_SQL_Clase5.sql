-- INNODB
CREATE DATABASE Henry;
-- Accede a la DB
USE Henry;
-- Creo las tablas
-- Primer componente de la BD
CREATE TABLE Alumnos(
	cedula_identindad INT NOT NULL Auto_increment,
    nombre varchar (20),
    apellido varchar (20),
    fechaInicio date,
    PRIMARY KEY (cedula_identindad)
);
