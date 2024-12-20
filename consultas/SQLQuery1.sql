use dsrp_cliente_crm
go

--Uniones
--Encuentra las órdenes junto con el nombre del cliente y el código del empleado que las gestionó.

SELECT
CONCAT( nt.nombres, ' ', nt.apellido_paterno,' ', nt.apellido_materno) as 'Nombre completo',
c.tipo_persona,
e.codigo_empleado,
o.id,
o.fecha_compra,
o.precio_total
FROM ordenes o
INNER JOIN clientes c ON c.id = o.cliente_id AND c.tipo_persona= 'Persona Natural' 
INNER JOIN personas_naturales nt ON nt.id= c.persona_id 
INNER JOIN empleados e ON  e.id = o.empleado_id  
--INNER JOIN personas_naturales pn ON pn.id =e.persona_id
UNION
SELECT
pj.razon_social as 'Nombre completo',
c.tipo_persona,
e.codigo_empleado,
o.id,
o.fecha_compra,
o.precio_total
FROM ordenes o
INNER JOIN clientes c ON c.id = o.cliente_id AND c.tipo_persona= 'Persona Jurídica' 
INNER JOIN personas_juridicas pj ON pj.id= c.persona_id 
INNER JOIN empleados e ON  e.id = o.empleado_id


--Agrupaciones
--Muestra la cantidad de productos vendidos (detalle_orden) por cada orden (ordenes_id).

SELECT 
ordenes_id AS 'Orden ID',
SUM(cantidad)AS 'Total de Productos',
FROM detalle_orden 
GROUP BY ordenes_id


--Filtros combinados
--Muestra todas las interacciones realizadas entre hace 10 y 2 dias que hayan sido por Correo.


SELECT *
FROM interaccion
WHERE tipo_interaccion = 'Correo' AND fecha > GETDATE()-10 AND fecha < GETDATE() -2


--Actualización con condiciones
--Incrementa el precio de todos los productos cuyo precio sea menor a 50 en un 10%.




--Joins y filtros avanzados
--Encuentra todas las órdenes cuyo precio_total sea mayor al promedio de todas las órdenes.

SELECT 
	id AS 'Orden ID',
	precio_total AS 'Precio Total',
	fecha_compra  AS 'Fecha Compra'
FROM  ordenes
WHERE precio_total > (SELECT AVG(precio_total) FROM ordenes);


--Triggers simulados con consultas
--Encuentra productos cuyo stock sea menor a 10 y crea una consulta para simular una alerta o recomendación.

SELECT *
FROM productos
WHERE stock < 10


CREATE TRIGGER trg_fr_stock_menor
ON productos
AFTER INSERT, UPDATE 
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (
		SELECT *
		FROM productos
		WHERE stock < 10
		)
	BEGIN
		PRINT 'AlERTA: Hay productos con bajo stock. Verifique el inventario.';
	END
END;

UPDATE productos 
SET stock = 15
WHERE id = 16