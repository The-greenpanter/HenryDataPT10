-- 1. Crear un procedimiento que recibe como parámetro una fecha y muestre la cantidad de órdenes ingresadas en esa fecha.<br>
-- Si no recuerdas el formato del procedimiento, repasa el ejemplo de la cápsula. El formato debe ser:<br>


DELIMITER $$
CREATE PROCEDURE ventasPorDia  (IN fecha DATE)
BEGIN
SELECT COUNT(DISTINCT SalesOrderID) 
FROM  salesorderheader
WHERE DATE(OrderDate) = fecha;
END $$

DELIMITER ;


SELECT COUNT(DISTINCT SalesOrderID) as VentasPorDia
FROM  salesorderheader
WHERE DATE(OrderDate) = '2001-06-30';
 -- 43
 
 CALL ventasPorDia('2001-06-30');
 
 
-- 2. Crear una función que calcule el valor nominal de un margen bruto determinado por el usuario a partir del precio de lista de los productos.<br>
-- ventasPorDiaSET GLOBAL log_bin_trust_function_creators 

SET GLOBAL log_bin_trust_function_creators = 1;


DROP FUNCTION calculoMargenBruto;

DELIMITER $$   
CREATE FUNCTION calculoMargenBruto (precio DECIMAL(15,3), margen DECIMAL(9,2)) RETURNS DECIMAL (15,3)
BEGIN
    DECLARE resultadoMargen DECIMAL (15,3);
    SET resultadoMargen = precio * margen;
    RETURN resultadoMargen;
END $$
DELIMITER ;

SELECT calculoMargenBruto(100, .3);

-- 3. Obtener un listado de productos en orden alfabético que muestre cuál debería ser el 
-- valor de precio de lista, si se quiere aplicar un margen bruto del 20%, utilizando la función 
-- creada en el punto 2, sobre el campo StandardCost. Mostrando tambien el campo ListPrice y la diferencia con 
-- el nuevo campo creado.

SELECT 
    Name,
    ListPrice,
    StandardCost,
    CALCULOMARGENBRUTO(StandardCost, 1.2) AS precioSugerido,
    ListPrice - (CALCULOMARGENBRUTO(StandardCost, 1.2)) AS diferenciaMargenSugerido
FROM
    product
WHERE
    ListPrice > 0 AND StandardCost > 0
-- HAVING margenNegativo < 10
ORDER BY Name;

-- 4. Crear un procedimiento que reciba como parámetro una fecha desde y una hasta, 
-- y muestre un listado con los Id de los diez Clientes que más costo de transporte 
-- tienen entre esas fechas (campo Freight).<br>
SELECT 
	customerId,
    SUM(Freight) AS CostoTotalTransporte
FROM 
	salesorderheader
WHERE DATE(OrderDate)  BETWEEN  '2001-06-01' AND'2001-06-30'
GROUP BY customerId
ORDER BY CostoTotalTransporte DESC
LIMIT 10;
    


DELIMITER //
CREATE PROCEDURE topClientesTransporte  (IN fechaInicio DATE, IN fechaFinal DATE)
BEGIN
	SELECT 
	customerId,
    SUM(Freight) AS CostoTotalTransporte
	FROM 
		salesorderheader
	WHERE DATE(OrderDate)  BETWEEN  fechaInicio AND fechaFinal
	GROUP BY customerId
	ORDER BY CostoTotalTransporte DESC
	LIMIT 10;
END //
DELIMITER ;

call adventureworks.topClientesTransporte('2001-06-01', '2001-06-30');

-- 5. Crear un procedimiento que permita realizar la insercción de datos en la tabla shipmethod.<br>

DELIMITER //
CREATE PROCEDURE cargarDatosShipMethod  (IN nombre VARCHAR(30), IN ShipBase DOUBLE, IN ShipRate DOUBLE)
BEGIN
	INSERT INTO shipmethod(Name, ShipBase, ShipRate, ModifiedDate)
    VALUES(nombre, ShipBase, ShipRate, NOW());
END //
DELIMITER ;

CALL cargarDatosShipMethod('TEST01', 1.1, 1.2)