/* Creando una variable */

SET @nombreVariable = 'Este seria un string';

-- Ahora si quiero una variable tipo fecha:

DECLARE miFecha DATE;
SET miFecha = '2024-05-15';

-- Para realizar una funcion

DELIMITER $$

CREATE PROCEDURE MiProcedimientoEjemplo(IN param1 INT, OUT param2 INT)
BEGIN
    DECLARE var1 INT;
    SET var1 = param1 * 2;
    SET param2 = var1;
END $$

DELIMITER ;


/*

Entonces para realizar un procedimiento que recibe como parámetro una fecha y muestre la cantidad de órdenes ingresadas en esa fecha.

*/
USE adventureworks;

DROP PROCEDURE IF EXISTS ordenesPorFecha;

DELIMITER $$

CREATE PROCEDURE ordenesPorFecha (IN fecha DATE, OUT totalOrdenes INT)

BEGIN 
    SELECT COUNT(*)
    INTO totalOrdenes
    FROM purchaseorderdetail
    WHERE DueDate = fecha;
END $$

DELIMITER ;

-- Llamada al procedimiento con un ejemplo de fecha y una variable de salida
SET @totalOrdenes = 0;
CALL ordenesPorFecha('2001-05-31', @totalOrdenes);
SELECT @totalOrdenes;