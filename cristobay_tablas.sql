DROP DATABASE cristobay_db; 
CREATE DATABASE IF NOT EXISTS cristobay_db;

USE cristobay_db;

-- ----------------------
-- Creación tabla USUARIO
-- ----------------------
DROP TABLE IF EXISTS usuario;
CREATE TABLE IF NOT EXISTS usuario (
id_usuario INT NOT NULL AUTO_INCREMENT,
login VARCHAR(20) NOT NULL UNIQUE,
clave VARCHAR (20) NOT NULL,
monedero INT DEFAULT 0,
nombre VARCHAR(50) NOT NULL,
apellido_1 VARCHAR (20) NOT NULL,
apellido_2 VARCHAR (20),
correo VARCHAR(50) NOT NULL UNIQUE,
PRIMARY KEY (id_usuario)
);

-- -----------------------
-- Creación tabla ARTÍCULO
-- -----------------------
DROP TABLE IF EXISTS articulo;
CREATE TABLE IF NOT EXISTS articulo (
id_articulo INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR (50) NOT NULL,
descripcion VARCHAR(160) NOT NULL,
imagen VARCHAR(50),
PRIMARY KEY (id_articulo)
);

-- -----------------------
-- Creación tabla SUBASTAR
-- -----------------------
DROP TABLE IF EXISTS subastar;
CREATE TABLE IF NOT EXISTS subastar (
id_usuario INT,
id_articulo INT,
fecha_inicio TIMESTAMP NOT NULL UNIQUE, 
fecha_fin TIMESTAMP NOT NULL UNIQUE, 
estado ENUM ("creada", "abierta", "cerrada por compra", "cerrada por eliminación",  "cerrada por tiempo") DEFAULT "creada",
precio_salida INT NOT NULL,
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
FOREIGN KEY (id_articulo) REFERENCES articulo(id_articulo),
PRIMARY KEY (id_articulo, fecha_inicio, fecha_fin)
);

-- --------------------
-- Creación tabla PUJAR
-- --------------------
DROP TABLE IF EXISTS pujar;
CREATE TABLE IF NOT EXISTS pujar (
fecha_y_hora TIMESTAMP, 
id_usuario INT,
id_articulo INT,
fecha_inicio TIMESTAMP,
fecha_fin TIMESTAMP,
cantidad_pujada INT NOT NULL CHECK (cantidad_pujada > 0),
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
FOREIGN KEY (id_articulo, fecha_inicio, fecha_fin) REFERENCES subastar(id_articulo, fecha_inicio, fecha_fin),
PRIMARY KEY (fecha_y_hora, id_usuario, id_articulo, fecha_inicio, fecha_fin)
);
