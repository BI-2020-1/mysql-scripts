CREATE SCHEMA venta_dm DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci;

USE venta_dm;



CREATE TABLE DPROMOCION (
                id_promocion INT AUTO_INCREMENT NOT NULL,
                promocion_nombre VARCHAR(50) NOT NULL,
                PRIMARY KEY (id_promocion)
);


CREATE TABLE DTIENDA (
                id_tienda INT AUTO_INCREMENT NOT NULL,
                tienda_nombre VARCHAR(50) NOT NULL,
                departamento VARCHAR(20) NOT NULL,
                distrito VARCHAR(20) NOT NULL,
                provincia VARCHAR(20) NOT NULL,
                PRIMARY KEY (id_tienda)
);


CREATE TABLE DTIEMPO (
                id_tiempo INT AUTO_INCREMENT NOT NULL,
                fecha DATE NOT NULL,
                turno_dia VARCHAR(20) NOT NULL,
                dia_semana VARCHAR(20) NOT NULL,
                num_dia_semana NUMERIC(1) NOT NULL,
                mes VARCHAR(10) NOT NULL,
                num_mes NUMERIC(2) NOT NULL,
                trimestre VARCHAR(20) NOT NULL,
                num_trimestre NUMERIC(1) NOT NULL,
                num_anio NUMERIC(4) NOT NULL,
                PRIMARY KEY (id_tiempo)
);


CREATE TABLE DPROMOTOR (
                id_promotor INT AUTO_INCREMENT NOT NULL,
                promotor_nombre VARCHAR(20) NOT NULL,
                genero CHAR(1) NOT NULL,
                PRIMARY KEY (id_promotor)
);


CREATE TABLE DCLIENTE (
                id_cliente INT AUTO_INCREMENT NOT NULL,
                genero_cliente CHAR(1) NOT NULL,
                PRIMARY KEY (id_cliente)
);


CREATE TABLE DARTICULO (
                id_articulo INT AUTO_INCREMENT NOT NULL,
                codigo_articulo VARCHAR(10) NOT NULL,
                articulo_nombre VARCHAR(50) NOT NULL,
                categoria_nombre VARCHAR(25) NOT NULL,
                talla VARCHAR(10) NOT NULL,
                marca VARCHAR(20) NOT NULL,
                material VARCHAR(20) NOT NULL,
                PRIMARY KEY (id_articulo)
);


CREATE TABLE H_VENTA (
                id_articulo INT NOT NULL,
                id_promotor INT NOT NULL,
                id_cliente INT NOT NULL,
                id_tienda INT NOT NULL,
                id_tiempo INT NOT NULL,
                id_promocion INT NOT NULL,
                transaccion_id INT NOT NULL,
                venta_monto NUMERIC(10,2) NOT NULL,
                compra_soles NUMERIC(10,2) NOT NULL,
                cantidad_unidades_vendidas NUMERIC(10) NOT NULL,
                descuento NUMERIC(10,2) NOT NULL,
                PRIMARY KEY (id_articulo, id_promotor, id_cliente, id_tienda, id_tiempo, id_promocion, transaccion_id)
);


ALTER TABLE H_VENTA ADD CONSTRAINT promocion_venta_fk
FOREIGN KEY (id_promocion)
REFERENCES DPROMOCION (id_promocion)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE H_VENTA ADD CONSTRAINT tienda_venta_fk
FOREIGN KEY (id_tienda)
REFERENCES DTIENDA (id_tienda)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE H_VENTA ADD CONSTRAINT fecha_venta_fk
FOREIGN KEY (id_tiempo)
REFERENCES DTIEMPO (id_tiempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE H_VENTA ADD CONSTRAINT atendedor_venta_fk
FOREIGN KEY (id_promotor)
REFERENCES DPROMOTOR (id_promotor)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE H_VENTA ADD CONSTRAINT cliente_venta_fk
FOREIGN KEY (id_cliente)
REFERENCES DCLIENTE (id_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE H_VENTA ADD CONSTRAINT producto_venta_fk
FOREIGN KEY (id_articulo)
REFERENCES DARTICULO (id_articulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;