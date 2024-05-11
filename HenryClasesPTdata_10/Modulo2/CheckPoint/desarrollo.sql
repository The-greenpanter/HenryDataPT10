USE checkpoint_m2

SELECT idCanal
FROM venta
GROUP BY idCanal
ORDER BY COUNT(*) DESC


SELECT AVG(precio) AS promedio_precios_JBL
FROM producto
WHERE concepto LIKE '%JBL%';


SELECT IdEmpleado, IdSucursal, COUNT(*) AS Cantidad
FROM venta
GROUP BY IdEmpleado, IdSucursal
ORDER BY COUNT(*) ASC;

SELECT IdProducto, SUM(Cantidad) AS total_ventas
FROM venta
WHERE YEAR(Fecha) = 2015
GROUP BY IdProducto
ORDER BY total_ventas DESC

SELECT COUNT(*) AS envios_con_demora
FROM venta
WHERE YEAR(Fecha) = 2019
AND TIMESTAMPDIFF(DAY, Fecha, Fecha_Entrega) =10;