CREATE DATABASE dsrp_cliente_crm
GO

USE dsrp_cliente_crm
GO

-- Personas naturales
CREATE TABLE personas_naturales(
	id INT PRIMARY KEY IDENTITY(1,1),
	numero_documento VARCHAR(25) UNIQUE NOT NULL,
	nombres VARCHAR(255) NOT NULL,
	apellido_paterno VARCHAR(255) NOT NULL,
	apellido_materno VARCHAR(255) NOT NULL,
	email VARCHAR(100) NOT NULL,
	celular VARCHAR (20) NOT NULL,
	direccion VARCHAR (255) NOT NULL,
	
); 
GO


--Personas Juridicas 
CREATE TABLE personas_juridicas(
	id INT PRIMARY KEY IDENTITY(1,1),
	numero_documento VARCHAR(20) UNIQUE NOT NULL,
	razon_social VARCHAR(255) NOT NULL,
	email VARCHAR(100) NOT NULL,
	telefono VARCHAR (20) NOT NULL,
	direccion VARCHAR (255) NOT NULL
); 
GO

--Clientes

CREATE TABLE clientes(
id INT PRIMARY KEY IDENTITY(1,1),
tipo_persona VARCHAR(55) NOT NULL,
persona_id INT NOT NULL);
Go

ALTER TABLE clientes
ADD CONSTRAINT check_tipo_persona CHECK (tipo_persona IN ('Persona Natural','Persona Jurídica'));

--Productos

CREATE TABLE productos(
id INT PRIMARY KEY IDENTITY(1,1),
nombre VARCHAR (255) NOT NULL,
descripcion VARCHAR(500) NOT NULL,
precio MONEY NOT NULL,
stock INT NOT NULL)
GO


--Empleado 
CREATE TABLE empleados(
id INT PRIMARY KEY IDENTITY (1,1) ,
persona_id INT NOT NULL,
codigo_empleado VARCHAR(20) NOT NULL,
CONSTRAINT FK_persona_natural_empleados FOREIGN KEY (persona_id) REFERENCES personas_naturales(id)
);
GO

--Interaccion
CREATE TABLE interaccion(
id INT PRIMARY KEY IDENTITY (1,1),
empleado_id INT NOT NULL,
cliente_id INT NOT NULL,
tipo_interaccion VARCHAR(255) NOT NULL,
fecha DATE NOT NULL,
resumen VARCHAR(500) NULL,
CONSTRAINT FK_cliente_interaccion FOREIGN KEY (cliente_id) REFERENCES clientes(id),
CONSTRAINT FK_empleado_interaccion FOREIGN KEY (empleado_id) REFERENCES empleados(id),
CONSTRAINT check_tipo_interaccion CHECK (tipo_interaccion IN ('WEB','WSP','Llamada','Presencial','Correo'))
);
GO

--SOPORTE
CREATE TABLE soporte (
id INT PRIMARY KEY IDENTITY (1,1),
empleado_id INT NOT NULL,
cliente_id INT NOT NULL,
tipo_problema VARCHAR(255) NOT NULL,
fecha DATE NOT NULL,
estado VARCHAR(500) NOT NULL,
CONSTRAINT FK_cliente_soporte FOREIGN KEY (cliente_id) REFERENCES clientes(id),
CONSTRAINT FK_empleado_soporte FOREIGN KEY (empleado_id) REFERENCES empleados(id),
CONSTRAINT check_tipo_problema CHECK (estado IN ('pendiente','resuelto'))
);
GO

--ORDENES
CREATE TABLE ordenes (
id INT PRIMARY KEY IDENTITY (1,1),
cliente_id INT NOT NULL,
empleado_id INT NOT NULL,
fecha_compra DATETIME NOT NULL,
precio_total MONEY NULL,
created_at DATETIME NOT NULL,
updated_at  DATETIME NULL,
deleted_at DATETIME NULL,
created_by INT NOT NULL,
updated_by INT NULL,
deleted_by INT NULL,
CONSTRAINT FK_cliente_ordenes FOREIGN KEY (cliente_id) REFERENCES clientes(id),
CONSTRAINT FK_empleado_ordenes FOREIGN KEY (empleado_id) REFERENCES empleados(id),

);
GO

-- DETALLE ORDEN
CREATE TABLE detalle_orden(
id INT PRIMARY KEY IDENTITY (1,1),
productos_id INT NOT NULL,
ordenes_id INT NOT NULL,
cantidad INT NOT NULL,
CONSTRAINT FK_productos_detalle_orden FOREIGN KEY (productos_id) REFERENCES productos(id),
CONSTRAINT FK_ordenes_detalle_orden FOREIGN KEY (ordenes_id) REFERENCES ordenes(id)
);