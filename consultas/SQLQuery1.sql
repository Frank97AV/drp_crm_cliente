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