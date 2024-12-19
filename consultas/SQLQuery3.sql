--- Listar los productos que han sido vendidos más de una vez junto con la cantidad total vendida

USE dsrp_cliente_crm;

SELECT 
    p.id AS producto_id,
    p.nombre AS producto_nombre,
    SUM(do.cantidad) AS cantidad_total_vendida
FROM 
    productos p
INNER JOIN 
    detalle_orden do ON p.id = do.productos_id
GROUP BY 
    p.id, p.nombre
HAVING 
    SUM(do.cantidad) > 1
ORDER BY 
    cantidad_total_vendida DESC;


--- Clientes con mayores gastos totales

USE dsrp_cliente_crm;

SELECT 
    c.id AS cliente_id,
    CASE 
        WHEN c.tipo_persona = 'Persona Natural' THEN CONCAT(pn.nombres, ' ', pn.apellido_paterno, ' ', pn.apellido_materno)
        WHEN c.tipo_persona = 'Persona Jurídica' THEN pj.razon_social
        ELSE 'Desconocido'
    END AS nombre_o_razon_social,
    SUM(o.precio_total) AS total_gastado
FROM 
    clientes c
LEFT JOIN 
    personas_naturales pn ON c.persona_id = pn.id AND c.tipo_persona = 'Persona Natural'
LEFT JOIN 
    personas_juridicas pj ON c.persona_id = pj.id AND c.tipo_persona = 'Persona Jurídica'
INNER JOIN 
    ordenes o ON c.id = o.cliente_id
GROUP BY 
    c.id, c.tipo_persona, pn.nombres, pn.apellido_paterno, pn.apellido_materno, pj.razon_social
ORDER BY 
    total_gastado DESC;

--- Interacción por empleado

USE dsrp_cliente_crm;

SELECT 
    e.id AS empleado_id,
    e.codigo_empleado,
    COUNT(i.id) AS total_interacciones
FROM 
    empleados e
INNER JOIN 
    interaccion i ON e.id = i.empleado_id
GROUP BY 
    e.id, e.codigo_empleado
ORDER BY 
    total_interacciones DESC;


--- Productos con menos stock disponible (menor igual a 10)

USE dsrp_cliente_crm;

SELECT 
    p.id AS producto_id,
    p.nombre AS producto_nombre,
    p.stock AS stock_disponible
FROM 
    productos p
WHERE 
    p.stock <= 10
ORDER BY 
    p.stock ASC;


--- Clientes con problemas pendientes de soporte

USE dsrp_cliente_crm;

SELECT 
    c.id AS cliente_id,
    CASE 
        WHEN c.tipo_persona = 'Persona Natural' THEN CONCAT(pn.nombres, ' ', pn.apellido_paterno, ' ', pn.apellido_materno)
        WHEN c.tipo_persona = 'Persona Jurídica' THEN pj.razon_social
        ELSE 'Desconocido'
    END AS nombre_o_razon_social,
    COUNT(s.id) AS problemas_pendientes
FROM 
    clientes c
LEFT JOIN 
    personas_naturales pn ON c.persona_id = pn.id AND c.tipo_persona = 'Persona Natural'
LEFT JOIN 
    personas_juridicas pj ON c.persona_id = pj.id AND c.tipo_persona = 'Persona Jurídica'
INNER JOIN 
    soporte s ON c.id = s.cliente_id
WHERE 
    s.estado = 'pendiente'
GROUP BY 
    c.id, c.tipo_persona, pn.nombres, pn.apellido_paterno, pn.apellido_materno, pj.razon_social
ORDER BY 
    problemas_pendientes DESC;
