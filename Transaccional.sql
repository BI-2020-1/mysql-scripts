CREATE SCHEMA tienda_db DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci;

USE tienda_db;


CREATE TABLE t_sistema (
                id_sistema INT NOT NULL,
                local VARCHAR(200) NOT NULL,
                departamento VARCHAR(50) NOT NULL,
                provincia VARCHAR(100) NOT NULL,
                distrito VARCHAR(100) NOT NULL,
                PRIMARY KEY (id_sistema)
);


CREATE TABLE t_almacen (
                id_almacen INT AUTO_INCREMENT NOT NULL,
                nombre VARCHAR(100) NOT NULL,
                encargado VARCHAR(200) NOT NULL,
                estado CHAR(1) NOT NULL,
                PRIMARY KEY (id_almacen)
);

ALTER TABLE t_almacen MODIFY COLUMN estado CHAR(1) COMMENT 'A,I';


CREATE TABLE t_marca (
                id_marca INT AUTO_INCREMENT NOT NULL,
                nombre VARCHAR(100) NOT NULL,
                estado CHAR(1) NOT NULL,
                PRIMARY KEY (id_marca)
);


CREATE TABLE t_promocion (
                id_promocion INT AUTO_INCREMENT NOT NULL,
                nombre VARCHAR(100) NOT NULL,
                estado CHAR(1) NOT NULL,
                PRIMARY KEY (id_promocion)
);


CREATE TABLE t_proveedor (
                id_proveedor INT AUTO_INCREMENT NOT NULL,
                razon_social VARCHAR(100) NOT NULL,
                tipo_documento VARCHAR(50) NOT NULL,
                numero_documento VARCHAR(50) NOT NULL,
                telefono VARCHAR(10) NOT NULL,
                estado CHAR(1) NOT NULL,
                PRIMARY KEY (id_proveedor)
);

ALTER TABLE t_proveedor MODIFY COLUMN estado CHAR(1) COMMENT 'A,I';


CREATE TABLE t_categoria (
                id_categoria INT AUTO_INCREMENT NOT NULL,
                nombre VARCHAR(50) NOT NULL,
                estado CHAR(1) NOT NULL,
                PRIMARY KEY (id_categoria)
);


CREATE TABLE t_articulo (
                id_articulo INT AUTO_INCREMENT NOT NULL,
                codigo VARCHAR(50) NOT NULL,
                nombre VARCHAR(100) NOT NULL,
                material VARCHAR(100) NOT NULL,
                id_categoria INT NOT NULL,
                id_marca INT NOT NULL,
                talla VARCHAR(10) NOT NULL,
                precio_compra NUMERIC(6,2) NOT NULL,
                precio_venta NUMERIC(6,2) NOT NULL,
                estado CHAR(1) NOT NULL,
                PRIMARY KEY (id_articulo)
);

ALTER TABLE t_articulo MODIFY COLUMN material VARCHAR(100) COMMENT 'Material';


CREATE TABLE t_almacen_detalle (
                id_almacen_detalle INT AUTO_INCREMENT NOT NULL,
                cantidad_actual INT NOT NULL,
                id_almacen INT NOT NULL,
                estado CHAR(1) NOT NULL,
                id_articulo INT NOT NULL,
                PRIMARY KEY (id_almacen_detalle)
);

ALTER TABLE t_almacen_detalle MODIFY COLUMN estado CHAR(1) COMMENT 'A,I';


CREATE TABLE t_promotor (
                id_promotor INT AUTO_INCREMENT NOT NULL,
                codigo VARCHAR(10) NOT NULL,
                nombres VARCHAR(100) NOT NULL,
                apellidos VARCHAR(200) NOT NULL,
                genero CHAR(1) NOT NULL,
                estado CHAR(1) NOT NULL,
                PRIMARY KEY (id_promotor)
);

ALTER TABLE t_promotor MODIFY COLUMN genero CHAR(1) COMMENT 'M,F';


CREATE TABLE t_usuario (
                id_usuario INT AUTO_INCREMENT NOT NULL,
                codigo VARCHAR(10) NOT NULL,
                usuario VARCHAR(50) NOT NULL,
                password VARCHAR(200) NOT NULL,
                nombres VARCHAR(100) NOT NULL,
                apellidos VARCHAR(200) NOT NULL,
                rol VARCHAR(20) NOT NULL,
                estado CHAR(1) NOT NULL,
                PRIMARY KEY (id_usuario)
);

ALTER TABLE t_usuario MODIFY COLUMN estado CHAR(1) COMMENT 'A,I';


CREATE TABLE t_compra (
                id_compra INT AUTO_INCREMENT NOT NULL,
                fecha DATE NOT NULL,
                tipo_comprobante VARCHAR(100) NOT NULL,
                numero_comprobante VARCHAR(100) NOT NULL,
                importe NUMERIC(10,2) NOT NULL,
                id_usuario INT NOT NULL,
                id_proveedor INT NOT NULL,
                id_almacen INT NOT NULL,
                PRIMARY KEY (id_compra)
);


CREATE TABLE t_compra_detalle (
                id_compra_detalle INT AUTO_INCREMENT NOT NULL,
                id_articulo INT NOT NULL,
                cantidad INT NOT NULL,
                precio_unid NUMERIC(6,2) NOT NULL,
                id_compra INT NOT NULL,
                PRIMARY KEY (id_compra_detalle)
);


CREATE TABLE t_cliente (
                id_cliente INT AUTO_INCREMENT NOT NULL,
                nombres VARCHAR(100) NOT NULL,
                genero CHAR(1) NOT NULL,
                PRIMARY KEY (id_cliente)
);

ALTER TABLE t_cliente MODIFY COLUMN genero CHAR(1) COMMENT 'm,f';


CREATE TABLE t_venta (
                id_venta INT AUTO_INCREMENT NOT NULL,
                fecha DATETIME NOT NULL,
                tipo_pago VARCHAR(10) NOT NULL,
                monto_total NUMERIC(10,2) NOT NULL,
                id_cliente INT NOT NULL,
                id_usuario INT NOT NULL,
                id_promotor INT NOT NULL,
                PRIMARY KEY (id_venta)
);

ALTER TABLE t_venta MODIFY COLUMN tipo_pago VARCHAR(10) COMMENT 'efectivo,credito,debito';


CREATE TABLE t_venta_detalle (
                id_venta_detalle INT AUTO_INCREMENT NOT NULL,
                id_articulo INT NOT NULL,
                cantidad INT NOT NULL,
                precio_venta_unid NUMERIC(6,2) NOT NULL,
                precio_compra_unid NUMERIC(6,2) NOT NULL,
                descuento NUMERIC(6,2) NOT NULL,
                id_venta INT NOT NULL,
                id_promocion INT NOT NULL,
                PRIMARY KEY (id_venta_detalle)
);

ALTER TABLE t_venta_detalle MODIFY COLUMN descuento NUMERIC(6, 2) COMMENT 'Por unidad';


ALTER TABLE t_almacen_detalle ADD CONSTRAINT almacen_almacen_detalle_fk
FOREIGN KEY (id_almacen)
REFERENCES t_almacen (id_almacen)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_compra ADD CONSTRAINT almacen_compra_fk
FOREIGN KEY (id_almacen)
REFERENCES t_almacen (id_almacen)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_articulo ADD CONSTRAINT marca_articulo_fk
FOREIGN KEY (id_marca)
REFERENCES t_marca (id_marca)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_venta_detalle ADD CONSTRAINT promocion_venta_detalle_fk
FOREIGN KEY (id_promocion)
REFERENCES t_promocion (id_promocion)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_compra ADD CONSTRAINT proveedor_compra_fk
FOREIGN KEY (id_proveedor)
REFERENCES t_proveedor (id_proveedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_articulo ADD CONSTRAINT categoria_articulo_fk
FOREIGN KEY (id_categoria)
REFERENCES t_categoria (id_categoria)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_almacen_detalle ADD CONSTRAINT t_articulo_t_almacen_detalle_fk
FOREIGN KEY (id_articulo)
REFERENCES t_articulo (id_articulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_venta_detalle ADD CONSTRAINT t_articulo_t_venta_detalle_fk
FOREIGN KEY (id_articulo)
REFERENCES t_articulo (id_articulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_compra_detalle ADD CONSTRAINT t_articulo_t_compra_detalle_fk
FOREIGN KEY (id_articulo)
REFERENCES t_articulo (id_articulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_venta ADD CONSTRAINT promotor_venta_fk
FOREIGN KEY (id_promotor)
REFERENCES t_promotor (id_promotor)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_venta ADD CONSTRAINT usuario_venta_fk
FOREIGN KEY (id_usuario)
REFERENCES t_usuario (id_usuario)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_compra ADD CONSTRAINT usuario_compra_fk
FOREIGN KEY (id_usuario)
REFERENCES t_usuario (id_usuario)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_compra_detalle ADD CONSTRAINT compra_compra_detalle_fk
FOREIGN KEY (id_compra)
REFERENCES t_compra (id_compra)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_venta ADD CONSTRAINT cliente_venta_fk
FOREIGN KEY (id_cliente)
REFERENCES t_cliente (id_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE t_venta_detalle ADD CONSTRAINT venta_venta_detalle_fk
FOREIGN KEY (id_venta)
REFERENCES t_venta (id_venta)
ON DELETE NO ACTION
ON UPDATE NO ACTION;