DROP DATABASE cristobay_db; 
CREATE DATABASE IF NOT EXISTS cristobay_db;

USE cristobay_db;

-- ----------------------
-- Creación tabla USUARIO
-- ----------------------
DROP TABLE IF EXISTS usuario;
CREATE TABLE IF NOT EXISTS usuario (
ID_usuario INT NOT NULL AUTO_INCREMENT,
correo VARCHAR(50) NOT NULL UNIQUE,
nombre_usuario VARCHAR(50) NOT NULL,
apellido_1 VARCHAR (20) NOT NULL,
apellido_2 VARCHAR (20),
nick_usuario VARCHAR(20) NOT NULL UNIQUE,
clave VARCHAR (20) NOT NULL,
monedero FLOAT(5,2) DEFAULT 0,
PRIMARY KEY (ID_usuario)
);

-- -----------------------
-- Creación tabla ARTÍCULO
-- -----------------------
DROP TABLE IF EXISTS articulo;
CREATE TABLE IF NOT EXISTS articulo (
ID_articulo INT NOT NULL AUTO_INCREMENT,
nombre_articulo VARCHAR (50) NOT NULL,
descripcion VARCHAR(160) NOT NULL,
imagen VARCHAR(50),
PRIMARY KEY (ID_articulo)
);

-- -----------------------
-- Creación tabla SUBASTAR
-- -----------------------
DROP TABLE IF EXISTS subastar;
CREATE TABLE IF NOT EXISTS subastar (
fecha_inicio TIMESTAMP NOT NULL UNIQUE, 
fecha_fin TIMESTAMP NOT NULL UNIQUE, 
ID_usuario INT,
ID_articulo INT,
precio_salida FLOAT (5,2) NOT NULL,
estado ENUM ("abierta", "cerrada por tiempo", "cerrada por eliminación", "cerrada por compra") DEFAULT "cerrada por tiempo",
FOREIGN KEY (ID_usuario) REFERENCES usuario(ID_usuario),
FOREIGN KEY (ID_articulo) REFERENCES articulo(ID_articulo),
PRIMARY KEY (fecha_inicio, fecha_fin, ID_usuario, ID_articulo)
);

-- --------------------
-- Creación tabla PUJAR
-- --------------------
DROP TABLE IF EXISTS pujar;
CREATE TABLE IF NOT EXISTS pujar (
fecha_puja TIMESTAMP NOT NULL, 
ID_usuario INT,
ID_articulo INT,
fecha_inicio_subasta TIMESTAMP,
fecha_fin_subasta TIMESTAMP,
cantidad FLOAT (5,2) NOT NULL CHECK (cantidad > 0),
FOREIGN KEY (ID_usuario) REFERENCES subastar(ID_usuario),
FOREIGN KEY (ID_articulo) REFERENCES subastar(ID_articulo),
FOREIGN KEY (fecha_inicio_subasta) REFERENCES subastar(fecha_inicio),
FOREIGN KEY (fecha_fin_subasta) REFERENCES subastar(fecha_fin),
PRIMARY KEY (fecha_puja)
);