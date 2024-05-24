-- 1. Obtener un listado contactos que hayan ordenado productos 
-- de la subcategoría "Mountain Bikes", entre los años 2000 y 2003, cuyo método de 
-- envío sea "CARGO TRANSPORT 5"

SELECT 
	DISTINCT CONCAT(c.firstName, ' ', LastName)  AS nameContact,
    c.ContactID,
    c.phone,
    c.EmailAddress
FROM
	contact c 
INNER JOIN 
	salesorderheader soh
ON c.ContactID = soh.ContactID
INNER JOIN
	salesorderdetail sod
ON	sod.SalesOrderID = soh.SalesOrderID
INNER JOIN
	product p
ON (p.ProductID = sod.ProductID)
INNER JOIN
	productsubcategory psc
ON	p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN
	shipmethod sm
ON sm.ShipMethodID = soh.ShipMethodID
WHERE  YEAR(soh.OrderDate) BETWEEN 2000 AND 2003
AND psc.Name = "Mountain Bikes"
AND sm.Name = "CARGO TRANSPORT 5";



-- 2. Obtener un listado contactos que hayan ordenado productos de la subcategoría "Mountain Bikes", 
-- entre los años 2000 y 2003 con la cantidad de productos adquiridos y 
-- ordenado por este valor, de forma descendente.<br>


SELECT 
	DISTINCT CONCAT(c.firstName, ' ', LastName)  AS nameContact,
    c.ContactID,
    SUM(sod.OrderQty) AS productosAdquiridos
FROM
	contact c 
INNER JOIN 
	salesorderheader soh
ON c.ContactID = soh.ContactID
INNER JOIN
	salesorderdetail sod
ON	sod.SalesOrderID = soh.SalesOrderID
INNER JOIN
	product p
ON (p.ProductID = sod.ProductID)
INNER JOIN
	productsubcategory psc
ON	p.ProductSubcategoryID = psc.ProductSubcategoryID

WHERE  YEAR(soh.OrderDate) BETWEEN 2000 AND 2003
AND psc.Name = "Mountain Bikes"
GROUP BY c.ContactID
ORDER BY productosAdquiridos DESC;



