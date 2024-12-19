USE dsrp_cliente_crm

SELECT DISTINCT tipo_interaccion 
FROM interaccion;

SELECT tipo_interaccion, COUNT(*) AS cantidad_interacciones
FROM interaccion
GROUP BY tipo_interaccion;

SELECT empleado_id, COUNT(*) AS cantidad_soportes
FROM soporte
GROUP BY empleado_id
HAVING COUNT(*) > 5;

SELECT nombres, apellido_paterno, apellido_materno 
FROM personas_naturales 
WHERE id IN (
    SELECT persona_id 
    FROM empleados 
    WHERE id NOT IN (
        SELECT empleado_id 
        FROM interaccion
    )
);


SELECT nombre, descripcion, stock 
FROM productos 
WHERE stock > 0 AND descripcion IS NOT NULL;


SELECT numero_documento, razon_social, email 
FROM personas_juridicas 
WHERE email LIKE '%gmail%';


SELECT nombres, direccion 
FROM personas_naturales 
WHERE email NOT LIKE '%hotmail%';


SELECT p.nombre AS producto, d.cantidad 
FROM productos p
INNER JOIN detalle_orden d ON p.id = d.productos_id;



CREATE INDEX idx_numero_documento ON personas_naturales (numero_documento);




SELECT o.fecha_compra, c.tipo_persona, c.persona_id, e.codigo_empleado, o.precio_total 
FROM ordenes o
INNER JOIN clientes c ON o.cliente_id = c.id
INNER JOIN empleados e ON o.empleado_id = e.id;











