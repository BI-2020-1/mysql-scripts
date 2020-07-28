CREATE SCHEMA compra_dm DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci;

USE compra_dm;

CREATE TABLE DTIENDA (
                id_tienda INT NOT NULL,
                tienda_nombre VARCHAR(50) NOT NULL,
                departamento VARCHAR(20) NOT NULL,
                distrito VARCHAR(20) NOT NULL,
                provincia VARCHAR(20) NOT NULL,
                PRIMARY KEY (id_tienda)
);

ALTER TABLE DTIENDA MODIFY COLUMN id_tienda INTEGER COMMENT 'ID único de la tienda';

ALTER TABLE DTIENDA MODIFY COLUMN tienda_nombre VARCHAR(50) COMMENT 'Nombre de la tienda.';

ALTER TABLE DTIENDA MODIFY COLUMN departamento VARCHAR(20) COMMENT 'Nombre del departamento donde se encuentra la tienda.';

ALTER TABLE DTIENDA MODIFY COLUMN distrito VARCHAR(20) COMMENT 'Nombre del distrito donde se encuentra la tienda.';

ALTER TABLE DTIENDA MODIFY COLUMN provincia VARCHAR(20) COMMENT 'Nombre de la provincia donde se encuentra la tienda.';


CREATE TABLE DTIEMPO (
                id_tiempo INT NOT NULL,
                fecha DATE NOT NULL,
                mes VARCHAR(10) NOT NULL,
                estacion_anio VARCHAR(20) NOT NULL,
                anio VARCHAR(10) NOT NULL,
                PRIMARY KEY (id_tiempo)
);

ALTER TABLE DTIEMPO MODIFY COLUMN id_tiempo INTEGER COMMENT 'ID único del tiempo.';

ALTER TABLE DTIEMPO MODIFY COLUMN fecha DATE COMMENT 'Fecha en formato internacional.';

ALTER TABLE DTIEMPO MODIFY COLUMN mes VARCHAR(10) COMMENT 'Nombre del mes del año.';

ALTER TABLE DTIEMPO MODIFY COLUMN estacion_anio VARCHAR(20) COMMENT 'Año numerico.';

ALTER TABLE DTIEMPO MODIFY COLUMN anio VARCHAR(10) COMMENT 'año.';


CREATE TABLE DPROVEEDOR (
                id_proveedor INT NOT NULL,                
                proveedor_nombre VARCHAR(50) NOT NULL,
                PRIMARY KEY (id_proveedor)
);

ALTER TABLE DPROVEEDOR MODIFY COLUMN id_proveedor INTEGER COMMENT 'ID único del proveedor';

ALTER TABLE DPROVEEDOR MODIFY COLUMN proveedor_nombre VARCHAR(50) COMMENT 'Nombre del proveedor';


CREATE TABLE DARTICULO (
                id_articulo INT NOT NULL,
                talla VARCHAR(20) NOT NULL,
                material VARCHAR(20) NOT NULL,
                marca VARCHAR(20) NOT NULL,
                categoria_nombre VARCHAR(25) NOT NULL,
                PRIMARY KEY (id_articulo)
);

ALTER TABLE DARTICULO MODIFY COLUMN id_articulo INTEGER COMMENT 'ID único del articulo.';

ALTER TABLE DARTICULO MODIFY COLUMN talla VARCHAR(20) COMMENT 'Talla del producto.';

ALTER TABLE DARTICULO MODIFY COLUMN material VARCHAR(20) COMMENT 'Material predominante del producto.';

ALTER TABLE DARTICULO MODIFY COLUMN marca VARCHAR(20) COMMENT 'Marca del producto.';

ALTER TABLE DARTICULO MODIFY COLUMN categoria_nombre VARCHAR(25) COMMENT 'Nombre de la categoria del producto.';


CREATE TABLE H_COMPRA (
                id_tiempo INT NOT NULL,
                id_proveedor INT NOT NULL,
                id_articulo INT NOT NULL,
                id_tienda INT NOT NULL,
                compra_soles NUMERIC(10,2) NOT NULL,
                cantidad_unidades_vendidas NUMERIC(10) NOT NULL,
                descuento NUMERIC(10,2) NOT NULL,
                venta_monto NUMERIC(10,2) NOT NULL,
                PRIMARY KEY (id_tiempo, id_proveedor, id_articulo, id_tienda)
);

ALTER TABLE H_COMPRA MODIFY COLUMN id_tiempo INTEGER COMMENT 'id unico del tiempo';

ALTER TABLE H_COMPRA MODIFY COLUMN id_proveedor INTEGER COMMENT 'id unico del proveedor';

ALTER TABLE H_COMPRA MODIFY COLUMN id_articulo INTEGER COMMENT 'id unico del articulo';

ALTER TABLE H_COMPRA MODIFY COLUMN id_tienda INTEGER COMMENT 'id unico de la tienda';

ALTER TABLE H_COMPRA MODIFY COLUMN compra_soles NUMERIC(10, 2) COMMENT 'Monto total de la transacción.';

ALTER TABLE H_COMPRA MODIFY COLUMN cantidad_unidades_vendidas NUMERIC(10) COMMENT 'Número de unidades del producto de la transacción.';

ALTER TABLE H_COMPRA MODIFY COLUMN descuento NUMERIC(10, 2) COMMENT 'Descuento aplicado en la transacción.';

ALTER TABLE H_COMPRA MODIFY COLUMN venta_monto NUMERIC(10, 2) COMMENT 'Monto total de la transacción.';


ALTER TABLE H_COMPRA ADD CONSTRAINT dtienda_hcompra_fk
FOREIGN KEY (id_tienda)
REFERENCES DTIENDA (id_tienda)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE H_COMPRA ADD CONSTRAINT dtiempo_hcompra_fk
FOREIGN KEY (id_tiempo)
REFERENCES DTIEMPO (id_tiempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE H_COMPRA ADD CONSTRAINT dproveedor_hcompra_fk
FOREIGN KEY (id_proveedor)
REFERENCES DPROVEEDOR (id_proveedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE H_COMPRA ADD CONSTRAINT darticulo_hcompra_fk
FOREIGN KEY (id_articulo)
REFERENCES DARTICULO (id_articulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;