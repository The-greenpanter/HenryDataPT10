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

/*

Crear una función que calcule el valor nominal de un margen bruto determinado por el usuario a partir del precio de lista de los productos.

*/


SET GLOBAL log_bin_trust_function_creators = 1;
-- Esto es necesario para permitir la creación de funciones por parte de usuarios que no sean el administrador de la base de datos. 

DROP FUNCTION IF EXISTS margenBrutoPorUsuario;

DELIMITER $$

CREATE FUNCTION  margenBrutoPorUsuario(precioVenta DECIMAL(15,3), costoProducto DECIMAL(9,2)) RETURNS DECIMAL(15,3) 
-- Especifica el tipo de dato que devuelve la función

-- DECIMAL(15, 3): En MySQL, DECIMAL es un tipo de dato numérico que se utiliza para almacenar valores con una precisión fija, en este caso (15, 3) significa que el número puede tener hasta 15 dígitos en total, de los cuales hasta 3 pueden estar después del punto decimal. 

BEGIN

    DECLARE margenBruto DECIMAL (15,3);

    SET margenBruto = precioVenta * costoProducto;

    RETURN margenBruto;

END$$

DELIMITER ;

SELECT margenBrutoPorUsuario (100.50, 1.2);


