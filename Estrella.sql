CREATE SCHEMA venta_dm DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci;

USE venta_dm;


CREATE TABLE DPROMOCION (
                id_promocion INT AUTO_INCREMENT NOT NULL,
                promocion_nombre VARCHAR(50) NOT NULL,
                PRIMARY KEY (id_promocion)
);

ALTER TABLE DPROMOCION MODIFY COLUMN id_promocion INTEGER COMMENT 'ID único de la promoción.';

ALTER TABLE DPROMOCION MODIFY COLUMN promocion_nombre VARCHAR(50) COMMENT 'Nombre de la promoción.';


CREATE TABLE DTIENDA (
                id_tienda INT AUTO_INCREMENT NOT NULL,
                tienda_nombre VARCHAR(50) NOT NULL,
                departamento VARCHAR(20) NOT NULL,
                distrito VARCHAR(20) NOT NULL,
                provincia VARCHAR(20) NOT NULL,
                PRIMARY KEY (id_tienda)
);

ALTER TABLE DTIENDA MODIFY COLUMN id_tienda INTEGER COMMENT 'ID único de la tienda.';

ALTER TABLE DTIENDA MODIFY COLUMN tienda_nombre VARCHAR(50) COMMENT 'Nombre de la tienda.';

ALTER TABLE DTIENDA MODIFY COLUMN departamento VARCHAR(20) COMMENT 'Nombre del departamento donde se encuentra la tienda.';

ALTER TABLE DTIENDA MODIFY COLUMN distrito VARCHAR(20) COMMENT 'Nombre del distrito donde se encuentra la tienda.';

ALTER TABLE DTIENDA MODIFY COLUMN provincia VARCHAR(20) COMMENT 'Nombre de la provincia donde se encuentra la tienda.';


CREATE TABLE DTIEMPO (
                id_tiempo INT AUTO_INCREMENT NOT NULL,
                fecha DATE NOT NULL,
                turno_dia VARCHAR(20) NOT NULL,
                dia_semana VARCHAR(20) NOT NULL,
                mes VARCHAR(10) NOT NULL,
                estacion_anio VARCHAR(20) NOT NULL,
                anio VARCHAR(10) NOT NULL,
                PRIMARY KEY (id_tiempo)
);

ALTER TABLE DTIEMPO MODIFY COLUMN id_tiempo INTEGER COMMENT 'ID único de la fecha.';

ALTER TABLE DTIEMPO MODIFY COLUMN fecha DATE COMMENT 'Fecha en formato internacional.';

ALTER TABLE DTIEMPO MODIFY COLUMN turno_dia VARCHAR(20) COMMENT 'Turno del día.';

ALTER TABLE DTIEMPO MODIFY COLUMN dia_semana VARCHAR(20) COMMENT 'Nombre del día de la semana.';

ALTER TABLE DTIEMPO MODIFY COLUMN mes VARCHAR(10) COMMENT 'Nombre del mes del año.';

ALTER TABLE DTIEMPO MODIFY COLUMN estacion_anio VARCHAR(20) COMMENT 'Año numérico.';


CREATE TABLE DATENDEDOR (
                id_atendedor INT AUTO_INCREMENT NOT NULL,
                atendedor_nombre VARCHAR(20) NOT NULL,
                genero CHAR(1) NOT NULL,
                PRIMARY KEY (id_atendedor)
);

ALTER TABLE DATENDEDOR MODIFY COLUMN id_atendedor INTEGER COMMENT 'ID único del atendedor.';

ALTER TABLE DATENDEDOR MODIFY COLUMN atendedor_nombre VARCHAR(20) COMMENT 'Nombre del atendedor.';

ALTER TABLE DATENDEDOR MODIFY COLUMN genero CHAR(1) COMMENT 'Género del atendedor.';


CREATE TABLE DCLIENTE (
                id_cliente INT AUTO_INCREMENT NOT NULL,
                genero_cliente CHAR(1) NOT NULL,
                PRIMARY KEY (id_cliente)
);

ALTER TABLE DCLIENTE MODIFY COLUMN id_cliente INTEGER COMMENT 'ID único del cliente.';

ALTER TABLE DCLIENTE MODIFY COLUMN genero_cliente CHAR(1) COMMENT 'Género del cliente.';


CREATE TABLE DPRODUCTO (
                id_producto INT AUTO_INCREMENT NOT NULL,
                codigo_producto VARCHAR(10) NOT NULL,
                producto_nombre VARCHAR(50) NOT NULL,
                precio_compra NUMERIC(10,2) NOT NULL,
                precio_venta NUMERIC(10,2) NOT NULL,
                categoria_nombre VARCHAR(25) NOT NULL,
                talla VARCHAR(20) NOT NULL,
                marca VARCHAR(20) NOT NULL,
                material VARCHAR(20) NOT NULL,
                PRIMARY KEY (id_producto)
);

ALTER TABLE DPRODUCTO MODIFY COLUMN id_producto INTEGER COMMENT 'ID único del producto.';

ALTER TABLE DPRODUCTO MODIFY COLUMN codigo_producto VARCHAR(10) COMMENT 'Código único del producto.';

ALTER TABLE DPRODUCTO MODIFY COLUMN producto_nombre VARCHAR(50) COMMENT 'Nombre del producto.';

ALTER TABLE DPRODUCTO MODIFY COLUMN precio_compra NUMERIC(10, 2) COMMENT 'Precio de compra del producto.';

ALTER TABLE DPRODUCTO MODIFY COLUMN precio_venta NUMERIC(10, 2) COMMENT 'Precio de venta del producto.';

ALTER TABLE DPRODUCTO MODIFY COLUMN categoria_nombre VARCHAR(25) COMMENT 'Nombre de categoría del producto.';

ALTER TABLE DPRODUCTO MODIFY COLUMN talla VARCHAR(20) COMMENT 'Talla del producto.';

ALTER TABLE DPRODUCTO MODIFY COLUMN marca VARCHAR(20) COMMENT 'Marca del producto.';

ALTER TABLE DPRODUCTO MODIFY COLUMN material VARCHAR(20) COMMENT 'Material predominante del producto.';


CREATE TABLE H_VENTA (
                id_producto INT NOT NULL,
                id_atendedor INT NOT NULL,
                id_cliente INT NOT NULL,
                id_tienda INT NOT NULL,
                id_tiempo INT NOT NULL,
                id_promocion INT NOT NULL,
                venta_monto NUMERIC(10,2) NOT NULL,
                compra_soles NUMERIC(10,2) NOT NULL,
                cantidad_unidades_vendidas NUMERIC(10) NOT NULL,
                descuento NUMERIC(10,2) NOT NULL,
                PRIMARY KEY (id_producto, id_atendedor, id_cliente, id_tienda, id_tiempo, id_promocion)
);

ALTER TABLE H_VENTA MODIFY COLUMN id_producto INTEGER COMMENT 'ID único del producto.';

ALTER TABLE H_VENTA MODIFY COLUMN id_atendedor INTEGER COMMENT 'ID único del atendedor.';

ALTER TABLE H_VENTA MODIFY COLUMN id_cliente INTEGER COMMENT 'ID único del cliente.';

ALTER TABLE H_VENTA MODIFY COLUMN id_tienda INTEGER COMMENT 'ID único de la tienda.';

ALTER TABLE H_VENTA MODIFY COLUMN id_tiempo INTEGER COMMENT 'ID único de la fecha.';

ALTER TABLE H_VENTA MODIFY COLUMN id_promocion INTEGER COMMENT 'ID único de la promoción.';

ALTER TABLE H_VENTA MODIFY COLUMN compra_soles NUMERIC(10, 2) COMMENT 'Monto total de la transacción.';

ALTER TABLE H_VENTA MODIFY COLUMN cantidad_unidades_vendidas NUMERIC(10) COMMENT 'Número de unidades del producto de la transacción.';

ALTER TABLE H_VENTA MODIFY COLUMN descuento NUMERIC(10, 2) COMMENT 'Descuento aplicado en la transacción.';


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
FOREIGN KEY (id_atendedor)
REFERENCES DATENDEDOR (id_atendedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE H_VENTA ADD CONSTRAINT cliente_venta_fk
FOREIGN KEY (id_cliente)
REFERENCES DCLIENTE (id_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE H_VENTA ADD CONSTRAINT producto_venta_fk
FOREIGN KEY (id_producto)
REFERENCES DPRODUCTO (id_producto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;