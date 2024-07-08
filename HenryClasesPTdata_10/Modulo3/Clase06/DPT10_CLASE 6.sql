SELECT DISTINCT Localidad, Provincia, Localidad, Provincia, 0 
FROM cliente WHERE Localidad = 'Avellaneda' 
UNION
SELECT DISTINCT Localidad, Provincia, Localidad, Provincia, 0 
FROM sucursal WHERE Localidad = 'Avellaneda' 
UNION
SELECT DISTINCT Ciudad, Provincia, Ciudad, Provincia, 0 
FROM proveedor WHERE Ciudad = 'Avellaneda'
ORDER BY 2, 1;

SELECT DISTINCT Localidad, Provincia, Localidad, Provincia, 0 
FROM cliente WHERE Localidad = 'Avellaneda' 
UNION ALL
SELECT DISTINCT Localidad, Provincia, Localidad, Provincia, 0 
FROM sucursal WHERE Localidad = 'Avellaneda' 
UNION ALL 
SELECT DISTINCT Ciudad, Provincia, Ciudad, Provincia, 0 
FROM proveedor WHERE Ciudad = 'Avellaneda'
ORDER BY 2, 1;



CREATE TABLE IF NOT EXISTS auxiliar_localidad(
	LocalidadOriginal VARCHAR(60),
    ProvinciaOriginal VARCHAR(60),
    LocalidadNormalizada VARCHAR(60),
    ProvinciaNormalizada VARCHAR(60),
    IdLocalidad 		INTEGER 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO auxiliar_localidad(LocalidadOriginal, ProvinciaOriginal, LocalidadNormalizada, ProvinciaNormalizada, IdLocalidad)
SELECT DISTINCT Localidad, Provincia, Localidad, Provincia, 0 
FROM cliente 
UNION
SELECT DISTINCT Localidad, Provincia, Localidad, Provincia, 0 
FROM sucursal 
UNION
SELECT DISTINCT Ciudad, Provincia, Ciudad, Provincia, 0 
FROM proveedor
ORDER BY 2, 1;

SELECT DISTINCT LocalidadOriginal FROM auxiliar_localidad
WHERE ProvinciaNormalizada like '%Bs%';


UPDATE auxiliar_localidad SET ProvinciaNormalizada = 'Buenos Aires'
WHERE ProvinciaOriginal IN ('B. Aires',
                            'B.Aires',
                            'Bs As',
                            'Bs.As.',
                            'Buenos Aires',
                            'C Debuenos Aires',
                            'Caba',
                            'Ciudad De Buenos Aires',
                            'Pcia Bs As',
                            'Prov De Bs As.',
                            'Provincia De Buenos Aires');


UPDATE auxiliar_localidad SET LocalidadNormalizada = 'Capital Federal'
WHERE LocalidadOriginal IN ('Cap.   Federal', 'Cap. Fed.', 'CapFed');

CREATE TABLE IF NOT EXISTS `localidad` (
  `IdLocalidad` int(11) NOT NULL AUTO_INCREMENT,
  `Localidad` varchar(80) NOT NULL,
  `Provincia` varchar(80) NOT NULL,
  `IdProvincia` int(11) NOT NULL,
  PRIMARY KEY (`IdLocalidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

DROP TABLE IF EXISTS `provincia`;
CREATE TABLE IF NOT EXISTS `provincia` (
  `IdProvincia` int NOT NULL AUTO_INCREMENT,
  `Provincia` varchar(50) NOT NULL,
  PRIMARY KEY (`IdProvincia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO localidad (Localidad, Provincia, IdProvincia)
SELECT DISTINCT LocalidadNormalizada, ProvinciaNormalizada, 0
FROM auxiliar_localidad
ORDER BY ProvinciaNormalizada;

INSERT INTO provincia( Provincia)
SELECT DISTINCT  ProvinciaNormalizada
FROM auxiliar_localidad
ORDER BY ProvinciaNormalizada;

SELECT * FROM localidad l
INNER JOIN provincia p ON 
l.provincia = p.Provincia;

UPDATE localidad l JOIN provincia p ON l.provincia = p.Provincia 
SET l.IdProvincia = p.IdProvincia;


update auxiliar_localidad aux 
-- SELECT * FROM auxiliar_localidad aux 
JOIN localidad l ON  l.localidad = aux.LocalidadNormalizada 
				AND aux.provincianormalizada = l.provincia
SET aux.idlocalidad = l.idlocalidad;


ALTER TABLE `cliente` ADD `IdLocalidad` INT NOT NULL DEFAULT '0' AFTER `Localidad`;
ALTER TABLE `proveedor` ADD `IdLocalidad` INT NOT NULL DEFAULT '0' AFTER `Departamento`;
ALTER TABLE `sucursal` ADD `IdLocalidad` INT NOT NULL DEFAULT '0' AFTER `Provincia`;


UPDATE  cliente c JOIN auxiliar_localidad ax ON  
c.provincia = ax.provinciaoriginal  AND c.localidad =  ax.localidadoriginal
SET c.idlocalidad = ax.idlocalidad;


UPDATE sucursal s JOIN auxiliar_localidad a
	ON (s.Provincia = a.provinciaoriginal AND s.Localidad = a.localidadoriginal)
SET s.IdLocalidad = a.IdLocalidad;

UPDATE proveedor p JOIN auxiliar_localidad a
	ON (p.Provincia = a.provinciaoriginal AND p.Ciudad = a.localidadoriginal)
SET p.IdLocalidad = a.IdLocalidad;


ALTER TABLE `cliente`
  DROP `Provincia`,
  DROP `Localidad`;
  
ALTER TABLE `proveedor`
  DROP `Ciudad`,
  DROP `Provincia`,
  DROP `Pais`,
  DROP `Departamento`;
  
ALTER TABLE `sucursal`
  DROP `Localidad`,
  DROP `Provincia`;
  
ALTER TABLE `localidad`
  DROP `Provincia`;


ALTER TABLE cliente ADD RangoEtario VARCHAR(30) NOT NULL DEFAULT 's/d'  AFTER Edad;

UPDATE cliente SET RangoEtario = '1_Hasta 30 años' WHERE Edad <= 30;
UPDATE cliente SET RangoEtario = '2_De 31 a 40 años' WHERE Edad <= 40 AND RangoEtario = 's/d';
UPDATE cliente SET RangoEtario = '3_De 41 a 50 años' WHERE Edad <= 50 AND RangoEtario = 's/d';
UPDATE cliente SET RangoEtario = '4_De 51 a 60 años' WHERE Edad <= 60 AND RangoEtario = 's/d';
UPDATE cliente SET RangoEtario = '5_Desde 60 años' WHERE Edad > 60 AND RangoEtario = 's/d';

-- Detección de OUTLIERS
SELECT * FROM venta v 
JOIN (
SELECT IdProducto, 
		AVG(Precio) as Media, 
		(AVG(Precio) + (3* STDDEV(Precio))) as Maximo, 
        STDDEV(Precio) as DSTD,
		(AVG(Precio) - (3* STDDEV(Precio))) as Minimo
FROM
	venta
GROUP BY IdProducto) t1
ON v.IdProducto = t1.IdProducto
WHERE v.Precio > t1.Maximo OR v.Precio < Minimo;



SELECT v.*, o.promedio, o.maximo, o.minimo
from venta v
JOIN (SELECT IdProducto, avg(Cantidad) as promedio, avg(Cantidad) + (3 * stddev(Cantidad)) as maximo,
						avg(Cantidad) - (3 * stddev(Cantidad)) as minimo
	from venta
	GROUP BY IdProducto) o
ON (v.IdProducto = o.IdProducto)
WHERE v.Cantidad > o.maximo OR v.Cantidad < o.minimo;




-- Introducimos los outliers de cantidad en la tabla aux_venta
-- MOTIVO 2 SIGNIFICA OUTLIER EN LA COLUMNA CANTIDAD
INSERT into aux_venta
select v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal, v.IdEmpleado,
v.IdProducto, v.Precio, v.Cantidad, 2
from venta v
JOIN (SELECT IdProducto, avg(Cantidad) as promedio, stddev(Cantidad) as Desv
	from venta
	GROUP BY IdProducto) v2
ON (v.IdProducto = v2.IdProducto)
WHERE v.Cantidad > (v2.Promedio + (3*v2.Desv)) OR v.Cantidad < (v2.Promedio - (3*v2.Desv)) OR v.Cantidad < 0;
-- Introducimos los outliers de precio en la tabla aux_venta
INSERT into aux_venta
select v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal,
v.IdEmpleado, v.IdProducto, v.Precio, v.Cantidad, 3
from venta v
JOIN (SELECT IdProducto, avg(Precio) as promedio, stddev(Precio) as Desv
	from venta
	GROUP BY IdProducto) v2
ON (v.IdProducto = v2.IdProducto)
WHERE v.Precio > (v2.Promedio + (3*v2.Desv)) OR v.Precio < (v2.Promedio - (3*v2.Desv)) OR v.Precio < 0;


ALTER TABLE `venta` ADD `Outlier` TINYINT NOT NULL DEFAULT '1' AFTER `Cantidad`;
UPDATE venta v JOIN aux_venta a
	ON (v.IdVenta = a.IdVenta AND a.Motivo IN (2,3))
SET v.Outlier = 0;




-- KPI: Margen de Ganancia por producto superior a 20%
SELECT 	venta.Producto, 
		venta.SumaVentas, 
        venta.CantidadVentas, 
        venta.SumaVentasOutliers,
        compra.SumaCompras, 
        compra.CantidadCompras,
        ((venta.SumaVentas / compra.SumaCompras - 1) * 100) as margen
FROM
	(SELECT 	p.Producto,
			SUM(v.Precio * v.Cantidad * v.Outlier) 	as 	SumaVentas,
			SUM(v.Outlier) 							as	CantidadVentas,
			SUM(v.Precio * v.Cantidad) 				as 	SumaVentasOutliers,
			COUNT(*) 								as	CantidadVentasOutliers
	FROM venta v JOIN producto p
		ON (v.IdProducto = p.IdProducto
			AND YEAR(v.Fecha) = 2019)
	GROUP BY p.Producto) AS venta
JOIN
	(SELECT 	p.Producto,
			SUM(c.Precio * c.Cantidad) 				as SumaCompras,
			COUNT(*)								as CantidadCompras
	FROM compra c JOIN producto p
		ON (c.IdProducto = p.IdProducto
			AND YEAR(c.Fecha) = 2019)
	GROUP BY p.Producto) as compra
ON (venta.Producto = compra.Producto);



SELECT 	co.TipoProducto,
		co.PromedioVentaConOutliers,
        so.PromedioVentaSinOutliers,
        (co.PromedioVentaConOutliers - so.PromedioVentaSinOutliers ) as diferencia
FROM
	(SELECT 	tp.TipoProducto,
			AVG(v.Precio * v.Cantidad) as PromedioVentaConOutliers
	FROM 	venta v JOIN producto p
		ON (v.IdProducto = p.IdProducto)
			JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
	GROUP BY tp.TipoProducto) co
JOIN
	(SELECT 	tp.TipoProducto,
			AVG(v.Precio * v.Cantidad) as PromedioVentaSinOutliers
	FROM 	venta v JOIN producto p
		ON (v.IdProducto = p.IdProducto and v.Outlier = 1)
			JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
	GROUP BY tp.TipoProducto) so
ON co.TipoProducto = so.TipoProducto;


