/* CREACIÓN DE BASE DE DATOS */
DROP DATABASE IF EXISTS dbGamarraMarket;
CREATE DATABASE dbGamarraMarket
DEFAULT CHARACTER SET utf8;

/*PONER EN USO LA BASE DE DATOS CREADA*/
USE dbGamarraMarket;

/*CREACIÓN DE TABLA CLIENTE*/
CREATE TABLE CLIENTE(
id int,
tipo_documento char(3),
numero_documento char(9),
nombres varchar(60),  
apellidos varchar(90),  
email varchar(80),  
celular char(9),  
fecha_nacimiento date,  
activo bool,  
CONSTRAINT cliente_pk PRIMARY KEY (id)
);
SHOW COLUMNS IN CLIENTE;
ALTER TABLE CLIENTE
ADD COLUMN estado_civil char(1);
ALTER TABLE CLIENTE
DROP COLUMN fecha_nacimiento;
ALTER TABLE CLIENTE
DROP COLUMN estado_civil;
ALTER TABLE CLIENTE
ADD COLUMN fecha_nacimiento date;

/*CREACIÓN DE TABLA VENTA*/
CREATE TABLE VENTA (  
    id int,  
    fecha_hora timestamp,  
    activo bool,  
    cliente_id int,  
    vendedor_id int, 
    CONSTRAINT venta_pk PRIMARY KEY (id)
);
SHOW COLUMNS IN VENTA;

/*CREACIÓN DE TABLA VENDEDOR*/
CREATE TABLE VENDEDOR (  
    id int,  
    tipo_documento char(3),  
    numero_documento char(15),  
    nombres varchar(60),  
    apellidos varchar(90),  
    salario decimal(8, 2),  
    celular char(9),  
    email varchar(80),  
    activo bool,  
    CONSTRAINT vendedor_pk PRIMARY KEY (id)
);
SHOW COLUMNS IN VENDEDOR;

/*CREACIÓN DE TABLA PRENDA*/
CREATE TABLE PRENDA (  
    id int,  
    descripcion varchar(90),  
    marca varchar(60),  
    cantidad int,  
    talla varchar(10),  
    precio decimal(8, 2),  
    activo bool,
    CONSTRAINT prenda_pk PRIMARY KEY (id)
);
SHOW COLUMNS IN PRENDA;

/*CREACIÓN DE TABLA VENTA_DETALLE*/
CREATE TABLE VENTA_DETALLE (  
    id int,  
    cantidad int,  
    venta_id int,  
    prenda_id int,  
    CONSTRAINT venta_detalle_pk PRIMARY KEY (id)
);
SHOW COLUMNS IN VENTA_DETALLE;

/*LISTAR TABLAS*/
SHOW TABLES;

/*CREACIÓN DE LAS RELACIONES*/
#RELACION VENTA_CLIENTE
ALTER TABLE VENTA  
    ADD CONSTRAINT VENTA_CLIENTE FOREIGN KEY (cliente_id)  
    REFERENCES CLIENTE (id)  
    ON UPDATE CASCADE  
    ON DELETE CASCADE  
;

#RELACION VENTADETALLE_VENTA
ALTER TABLE VENTA_DETALLE  
    ADD CONSTRAINT VENTA_DETALLE_VENTA FOREIGN KEY (venta_id)  
    REFERENCES VENTA (id)  
    ON UPDATE CASCADE  
    ON DELETE CASCADE  
;

#RELACION VENTA_VENDEDOR
ALTER TABLE VENTA  
    ADD CONSTRAINT VENTA_VENDEDOR FOREIGN KEY (vendedor_id)  
    REFERENCES VENDEDOR (id)  
    ON UPDATE CASCADE  
    ON DELETE CASCADE  
;

#RELACION VENTADETALLE_PRENDA
ALTER TABLE VENTA_DETALLE  
    ADD CONSTRAINT VENTA_DETALLE_PRENDA FOREIGN KEY (prenda_id)  
    REFERENCES PRENDA (id)  
    ON UPDATE CASCADE  
    ON DELETE CASCADE  
;

/*LISTAR RELACIONES*/
SELECT  
    i.constraint_name, k.table_name, k.column_name,  
    k.referenced_table_name, k.referenced_column_name  
FROM  
    information_schema.TABLE_CONSTRAINTS i  
LEFT JOIN information_schema.KEY_COLUMN_USAGE k  
ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME  
WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY'  
AND i.TABLE_SCHEMA = DATABASE(); 