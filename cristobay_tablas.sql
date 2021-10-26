-- DROP DATABASE cristobay_db; 
CREATE DATABASE IF NOT EXISTS cristobay_DB;

USE cristobay_DB;

-- ----------------------
-- Creación tabla USUARIO
-- ----------------------
DROP TABLE IF EXISTS usuario;
CREATE TABLE IF NOT EXISTS usuario (
ID_usuario INT NOT NULL AUTO_INCREMENT,
correo VARCHAR(50) NOT NULL UNIQUE,
nombre_usuario VARCHAR(50) NOT NULL,
apellidos_usuario VARCHAR (50) NOT NULL,
nick_usuario VARCHAR(20) NOT NULL UNIQUE,
clave VARCHAR (20) NOT NULL,
monedero FLOAT(3,2) DEFAULT 0,
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
fecha DATETIME NOT NULL, 
ID_usuario INT,
ID_articulo INT,
precio_salida FLOAT (3,2) NOT NULL,
estado BOOLEAN,
FOREIGN KEY (ID_usuario) REFERENCES usuario(ID_usuario),
FOREIGN KEY (ID_articulo) REFERENCES articulo(ID_articulo),
PRIMARY KEY (fecha, ID_usuario, ID_articulo)
);

-- --------------------
-- Creación tabla PUJAR
-- --------------------
DROP TABLE IF EXISTS pujar;
CREATE TABLE IF NOT EXISTS pujar (
fecha DATETIME NOT NULL, 
ID_usuario INT,
ID_articulo INT,
fecha_subasta DATETIME,
cantidad FLOAT (3,2) NOT NULL,
FOREIGN KEY (ID_usuario) REFERENCES usuario(ID_usuario),
FOREIGN KEY (ID_articulo) REFERENCES articulo(ID_articulo),
FOREIGN KEY (fecha_subasta) REFERENCES subastar(fecha),
PRIMARY KEY (fecha)
);