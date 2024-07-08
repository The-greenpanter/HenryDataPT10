-- Clear cualquier record anterior
DROP DATABASE IF EXISTS henry;

-- INNODB
CREATE DATABASE Henry;

-- Accede a la DB
USE Henry;

-- Creo las tablas
-- Primer componente de la BD

CREATE TABLE carrera (
	idCarrera INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR (50) NOT NULL
    );

CREATE TABLE instructor (
	idInstructor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	cedulaIdentidad INT NOT NULL UNIQUE,
	nombre VARCHAR(40) NOT NULL,
	apellido VARCHAR(40) NOT NULL,
	fechaNacimiento DATE NOT NULL,
	fechaIncorporacion DATE
);

CREATE TABLE cohorte(
	idCohorte INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	codigo INT NOT NULL,
	idCarrera INT NOT NULL,
	idInstructor INT NOT NULL,
	fechaInicio DATE,
	fechaFinalizacion DATE,
	FOREIGN KEY (idCarrera) REFERENCES carrera(idCarrera),
	FOREIGN KEY (idInstructor) REFERENCES instructor(idInstructor)
);

CREATE TABLE alumno (
	idAlumno INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cedulaIdentidad INT NOT NULL,
    nombre VARCHAR (40) NOT NULL,
    apellido VARCHAR (40) NOT NULL,
   	fechaNacimiento DATE NOT NULL,
	fechaIngreso DATE,
    idCohorte INT,
    FOREIGN KEY (idCohorte) REFERENCES cohorte(idCohorte)
);
