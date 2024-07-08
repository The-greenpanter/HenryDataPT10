```

SELECT 
    -- No seleccionamos toda la tabla para evitar ambiguedad 
    DISTINCT CONCAT (c.firstName, '', LastName) AS c.nameContact, c.ContactID, c.phone

FROM
    contact c
INNER JOIN
    salesorderheader soh
ON c.ContactID = soh.ContactID

WHERE YEAR (soh.OrderDate) BETWEEN 200 AND 2003

INNER JOIN 
    salesorderdetail sod
ON sod.SalesOrderID = soh.SalesOrderID
INNER JOIN
    product P
ON  p.produc = sod.ProductID

INNER JOIN
    productsubcategory psc
ON p.ProductSubcategoryID =  psc.ProductCategoryID

WHERE YEAR (soh.OrderDate) BETWEEN 2000 AND 2003
AND psc.Name = "Mountain Bike"
AND sm.Name = "CARGO TRANSPORTE 5"

```

Los caracteres no legibles en grandes masas de datos en problema de encoding

```

SELECT 
   DISTINCT CONCAT ()
FROM
    contact c
INNER JOIN
    salesorderheader soh
ON c.ContactID = soh.ContactID

WHERE YEAR (soh.OrderDate) BETWEEN 200 AND 2003

INNER JOIN 
    salesorderdetail sod
ON sod.SalesOrderID = soh.SalesOrderID
INNER JOIN
    product P
ON  p.produc = sod.ProductID

INNER JOIN
    productsubcategory psc
ON p.ProductSubcategoryID =  psc.ProductCategoryID

WHERE YEAR (soh.OrderDate) BETWEEN 2000 AND 2003
AND psc.Name = "Mountain Bike"


```

