-- Clear cualquier record anterior
DROP DATABASE IF EXISTS henry;

-- INNODB
CREATE DATABASE Henry;

-- Accede a la DB
USE Henry;

-- Creo las tablas
-- Primer componente de la BD
CREATE TABLE Carrera (
    idCarrera INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_carrera VARCHAR(50)
);

CREATE TABLE Instructores (
    ID_instructor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cedula_identidad INT NOT NULL UNIQUE,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    fecha_nacimiento DATE,
    fecha_incorporacion DATE
);

CREATE TABLE Cohorte (
    ID_cohorte INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    codigo INT NOT NULL UNIQUE,
    fecha_Inicio DATE,
    fecha_Finalizacion DATE,
    idCarrera INT NOT NULL, -- Cambio aquí
    FOREIGN KEY (idCarrera) REFERENCES Carrera (idCarrera), -- Cambio aquí
    FOREIGN KEY (ID_instructor) REFERENCES Instructores (ID_instructor)
);

CREATE TABLE Alumnos(
    ID_alumnos INT NOT NULL AUTO_INCREMENT,
    cedula_identindad INT NOT NULL UNIQUE,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    fecha_nacimiento DATE,
    fecha_ingreso DATE,
    ID_cohorte INT NOT NULL,
    FOREIGN KEY (ID_cohorte) REFERENCES Cohorte (ID_cohorte),
    PRIMARY KEY (cedula_identindad)
);
