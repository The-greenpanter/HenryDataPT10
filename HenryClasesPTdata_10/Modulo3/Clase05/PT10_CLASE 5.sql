-- Normalización de nombres de tablas y columnas  
-- canal_venta
-- CanalVenta
ALTER TABLE cliente CHANGE ID IdCliente INT NOT NULL;
ALTER TABLE cliente CHANGE Nombre_y_Apellido NombreApellido VARCHAR(80);
ALTER TABLE cliente CHANGE Fecha_Alta FechaAlta DATE;
ALTER TABLE cliente CHANGE Usuario_Alta UsuarioAlta VARCHAR(20);
ALTER TABLE cliente CHANGE Fecha_Ultima_Modificacion FechaUltimaModificacion DATE;
ALTER TABLE cliente CHANGE Usuario_Ultima_Modificacion UsuarioUltimaModificacion VARCHAR(20);
ALTER TABLE cliente CHANGE Marca_Baja MarcaBaja TINYINT;


ALTER TABLE empleado CHANGE IDEmpleado IdEmpleado INT NOT NULL;
ALTER TABLE empleado CHANGE Salario2 Salario DECIMAL(10,2) NOT NULL;

ALTER TABLE producto CHANGE IDProducto IdProducto INT NOT NULL;
ALTER TABLE producto CHANGE Concepto Producto varchar(100);


ALTER TABLE proveedor CHANGE IDProveedor IdProveedor INT NOT NULL;

ALTER TABLE sucursal CHANGE ID IdSucursal INT NOT NULL;

ALTER TABLE tipo_gasto CHANGE Monto_Aproximado MontoAproximado  DECIMAL(10,2);

-- NORMALIZACION DE TIPO DE DATOS EN COLUMNAS
ALTER TABLE cliente ADD Latitud DECIMAL(13,10) NOT NULL DEFAULT 0 AFTER Y,
					ADD Longitud DECIMAL(13,10) NOT NULL DEFAULT 0 AFTER Latitud;
-- SELECT * FROM cliente WHERE X ='';
UPDATE cliente SET Y = '0' WHERE Y = '';
UPDATE cliente SET X = '0' WHERE X = '';

UPDATE cliente SET Latitud = replace(Y, ',', '.');
UPDATE cliente SET Longitud = replace(X, ',', '.');

ALTER TABLE cliente DROP Y;
ALTER TABLE cliente DROP X;
ALTER TABLE cliente DROP col10;

ALTER TABLE sucursal ADD Latitud DECIMAL(13,10) NOT NULL DEFAULT 0 AFTER Latitud2, -- SE RECOMIENDA EL USO DE 6 DECIMALES
					ADD Longitud DECIMAL(13,10) NOT NULL DEFAULT 0 AFTER Latitud;

UPDATE sucursal SET Latitud = replace(Latitud2, ',', '.');
UPDATE sucursal SET Longitud = replace(Longitud2, ',', '.');

ALTER TABLE `sucursal` DROP `Latitud2`;
ALTER TABLE `sucursal` DROP `Longitud2`;

ALTER TABLE producto ADD Precio DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER Precio2;

UPDATE producto SET Precio = replace(Precio2, ',','.');
ALTER TABLE `producto` DROP `Precio2`;

-- UPDATE `venta` set `Precio` = 0 WHERE `Precio` = '';

-- IMPUTAR VALORES FALTANTES
UPDATE `cliente` SET Domicilio = 'Sin Dato' WHERE TRIM(Domicilio) = "" OR ISNULL(Domicilio);
UPDATE `cliente` SET Localidad = 'Sin Dato' WHERE TRIM(Localidad) = "" OR ISNULL(Localidad);
UPDATE `cliente` SET NombreApellido = 'Sin Dato' WHERE TRIM(NombreApellido) = "" OR ISNULL(NombreApellido);
UPDATE `cliente` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);

UPDATE `empleado` SET Apellido = 'Sin Dato' WHERE TRIM(Apellido) = "" OR ISNULL(Apellido);
UPDATE `empleado` SET Nombre = 'Sin Dato' WHERE TRIM(Nombre) = "" OR ISNULL(Nombre);
UPDATE `empleado` SET Sucursal = 'Sin Dato' WHERE TRIM(Sucursal) = "" OR ISNULL(Sucursal);
UPDATE `empleado` SET Sector = 'Sin Dato' WHERE TRIM(Sector) = "" OR ISNULL(Sector);
UPDATE `empleado` SET Cargo = 'Sin Dato' WHERE TRIM(Cargo) = "" OR ISNULL(Cargo);

UPDATE `producto` SET Producto = 'Sin Dato' WHERE TRIM(Producto) = "" OR ISNULL(Producto);
UPDATE `producto` SET Tipo = 'Sin Dato' WHERE TRIM(Tipo) = "" OR ISNULL(Tipo);

UPDATE `proveedor` SET Nombre = 'Sin Dato' WHERE TRIM(Nombre) = "" OR ISNULL(Nombre);
UPDATE `proveedor` SET Domicilio = 'Sin Dato' WHERE TRIM(Domicilio) = "" OR ISNULL(Domicilio);
UPDATE `proveedor` SET Ciudad = 'Sin Dato' WHERE TRIM(Ciudad) = "" OR ISNULL(Ciudad);
UPDATE `proveedor` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);
UPDATE `proveedor` SET Pais = 'Sin Dato' WHERE TRIM(Pais) = "" OR ISNULL(Pais);
UPDATE `proveedor` SET Departamento = 'Sin Dato' WHERE TRIM(Departamento) = "" OR ISNULL(Departamento);

UPDATE `sucursal` SET Domicilio = 'Sin Dato' WHERE TRIM(Domicilio) = "" OR ISNULL(Domicilio);
UPDATE `sucursal` SET Sucursal = 'Sin Dato' WHERE TRIM(Sucursal) = "" OR ISNULL(Sucursal);
UPDATE `sucursal` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);
UPDATE `sucursal` SET Localidad = 'Sin Dato' WHERE TRIM(Localidad) = "" OR ISNULL(Localidad);

-- NORMALIZACION DE LA LETRA CAPITAL
UPDATE cliente SET NombreApellido = UC_Words(TRIM(NombreApellido)),
					Domicilio = UC_Words(TRIM(Domicilio));

UPDATE sucursal SET Domicilio = UC_Words(TRIM(Domicilio)),
                    Sucursal = UC_Words(TRIM(Sucursal));
					
UPDATE proveedor SET Nombre = UC_Words(TRIM(Nombre)),
                    Domicilio = UC_Words(TRIM(Domicilio));

UPDATE producto SET Producto = UC_Words(TRIM(Producto));

UPDATE producto SET Tipo = UC_Words(TRIM(Tipo));
					
UPDATE empleado SET Nombre = UC_Words(TRIM(Nombre)),
                    Apellido = UC_Words(TRIM(Apellido));

DROP TABLE IF EXISTS `aux_venta`;
CREATE TABLE IF NOT EXISTS `aux_venta` (
  `IdVenta`				INTEGER,
  `Fecha` 				DATE NOT NULL,
  `Fecha_Entrega` 		DATE NOT NULL,
  `IdCliente`			INTEGER, 
  `IdSucursal`			INTEGER,
  `IdEmpleado`			INTEGER,
  `IdProducto`			INTEGER,
  `Precio`				FLOAT,
  `Cantidad`			INTEGER,
  `Motivo`				INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

SELECT count(*) FROM venta WHERE precio IS NULL; -- 924 registros sin precio 

SELECT * FROM producto INNER JOIN 
venta ON producto.IdProducto = venta.IdProducto 
WHERE venta.Precio is null;

UPDATE venta INNER JOIN producto
ON producto.IdProducto = venta.IdProducto 
SET venta.Precio = producto.Precio
WHERE venta.Precio IS NULL;

SELECT * FROM producto INNER JOIN 
venta ON producto.IdProducto = venta.IdProducto 
WHERE venta.cantidad is null;

SELECT count(*) FROM venta WHERE cantidad IS NULL;


INSERT INTO aux_venta (IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, Motivo)
SELECT IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, 0, 1
FROM venta WHERE Cantidad is null;

-- RECORDATORIO LAS FILAS CON MOTIVO 1 SIGNIFICAN QUE LA CANTIDAD NO ESTABA REGISTRADA

UPDATE venta SET Cantidad = 1 WHERE Cantidad IS NULL;


/*Chequeo de claves duplicadas*/
SELECT IdCliente, COUNT(*) FROM cliente GROUP BY IdCliente HAVING COUNT(*) > 1;
SELECT IdSucursal, COUNT(*) FROM sucursal GROUP BY IdSucursal HAVING COUNT(*) > 1;
SELECT IdEmpleado, COUNT(*) FROM empleado GROUP BY IdEmpleado HAVING COUNT(*) > 1;
SELECT IdProveedor, COUNT(*) FROM proveedor GROUP BY IdProveedor HAVING COUNT(*) > 1;
SELECT IdProducto, COUNT(*) FROM producto GROUP BY IdProducto HAVING COUNT(*) > 1;


SELECT empleado.*, sucursal.IdSucursal ;

UPDATE empleado SET Sucursal = 'Mendoza1' WHERE Sucursal = 'Mendoza 1';
UPDATE empleado SET Sucursal = 'Mendoza2' WHERE Sucursal = 'Mendoza 2';

ALTER TABLE `empleado` ADD `IdSucursal` INT NULL DEFAULT '0' AFTER `Sucursal`;

UPDATE empleado JOIN sucursal
ON empleado.sucursal = sucursal.sucursal
SET empleado.IdSucursal = sucursal.IdSucursal;

ALTER TABLE `empleado` DROP `Sucursal`;

ALTER TABLE empleado ADD CodigoEmpleado  INT NOT NULL DEFAULT 9 AFTER IdEmpleado;
UPDATE empleado SET  CodigoEmpleado=IdEmpleado;

UPDATE empleado SET IdEmpleado = (IdSucursal * 1000000) + CodigoEmpleado;




/*Normalizacion tabla empleado*/
DROP TABLE IF EXISTS `cargo`;
CREATE TABLE IF NOT EXISTS `cargo` (
  `IdCargo` tinyint NOT NULL AUTO_INCREMENT,
  `Cargo` varchar(50) NOT NULL,
  PRIMARY KEY (`IdCargo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

DROP TABLE IF EXISTS `sector`;
CREATE TABLE IF NOT EXISTS `sector` (
  `IdSector` TINYINT NOT NULL AUTO_INCREMENT,
  `Sector` varchar(50) NOT NULL,
  PRIMARY KEY (`IdSector`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO cargo (Cargo) SELECT DISTINCT Cargo FROM empleado ORDER BY 1;
INSERT INTO sector (Sector) SELECT DISTINCT Sector FROM empleado ORDER BY 1;
                    
select * from cargo;
select * from sector;

ALTER TABLE `empleado` 	ADD `IdSector` INT NOT NULL DEFAULT '0' AFTER `IdSucursal`, 
						ADD `IdCargo` INT NOT NULL DEFAULT '0' AFTER `IdSector`;

UPDATE empleado e JOIN cargo c ON (c.Cargo = e.Cargo) SET e.IdCargo = c.IdCargo;
UPDATE empleado e JOIN sector s ON (s.Sector = e.Sector) SET e.IdSector = s.IdSector;

ALTER TABLE `empleado` DROP `Cargo`;
ALTER TABLE `empleado` DROP `Sector`;

SELECT * FROM `empleado`;

/*Normalización tabla producto*/
ALTER TABLE `producto` ADD `IdTipoProducto` INT NOT NULL DEFAULT '0' AFTER `Precio`;

DROP TABLE IF EXISTS `tipo_producto`;
CREATE TABLE IF NOT EXISTS `tipo_producto` (
  `IdTipoProducto` int(11) NOT NULL AUTO_INCREMENT,
  `TipoProducto` varchar(50) NOT NULL,
  PRIMARY KEY (`IdTipoProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tipo_producto (TipoProducto) SELECT DISTINCT Tipo FROM producto ORDER BY 1;

ALTER TABLE `producto` 	ADD `IdTipoProducto` INT NOT NULL DEFAULT '0' AFTER `Tipo`;


UPDATE producto p JOIN tipo_producto t ON (p.Tipo = t.TipoProducto) SET p.IdTipoProducto = t.IdTipoProducto;

SELECT * FROM `producto`;

ALTER TABLE `producto`
  DROP `Tipo`;

