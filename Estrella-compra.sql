
CREATE SCHEMA compra_dm DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci;

USE compra_dm;


CREATE TABLE DTIENDA (
                id_tienda INT AUTO_INCREMENT NOT NULL,
                tienda_nombre VARCHAR(50) NOT NULL,
                departamento VARCHAR(20) NOT NULL,
                distrito VARCHAR(20) NOT NULL,
                provincia VARCHAR(20) NOT NULL,
                PRIMARY KEY (id_tienda)
);

ALTER TABLE DTIENDA MODIFY COLUMN tienda_nombre VARCHAR(50) COMMENT 'Nombre de la tienda.';

ALTER TABLE DTIENDA MODIFY COLUMN departamento VARCHAR(20) COMMENT 'Nombre del departamento donde se encuentra la tienda.';

ALTER TABLE DTIENDA MODIFY COLUMN distrito VARCHAR(20) COMMENT 'Nombre del distrito donde se encuentra la tienda.';

ALTER TABLE DTIENDA MODIFY COLUMN provincia VARCHAR(20) COMMENT 'Nombre de la provincia donde se encuentra la tienda.';


CREATE TABLE DTIEMPO (
                id_tiempo INT AUTO_INCREMENT NOT NULL,
                fecha DATE NOT NULL,
                mes VARCHAR(10) NOT NULL,
                num_mes NUMERIC(2) NOT NULL,
                trimestre VARCHAR(20) NOT NULL,
                num_trimestre NUMERIC(1) NOT NULL,
                num_anio NUMERIC(4) NOT NULL,
                PRIMARY KEY (id_tiempo)
);

ALTER TABLE DTIEMPO MODIFY COLUMN fecha DATE COMMENT 'Fecha en formato internacional.';

ALTER TABLE DTIEMPO MODIFY COLUMN mes VARCHAR(10) COMMENT 'Nombre del mes del año.';

ALTER TABLE DTIEMPO MODIFY COLUMN num_anio NUMERIC(4) COMMENT 'año';


CREATE TABLE DPROVEEDOR (
                id_proveedor INT AUTO_INCREMENT NOT NULL,
                proveedor_nombre VARCHAR(60) NOT NULL,
                PRIMARY KEY (id_proveedor)
);

ALTER TABLE DPROVEEDOR MODIFY COLUMN proveedor_nombre VARCHAR(60) COMMENT 'Nombre del proveedor';


CREATE TABLE DARTICULO (
                id_articulo INT AUTO_INCREMENT NOT NULL,
                codigo_articulo VARCHAR(10) NOT NULL,
                talla VARCHAR(20) NOT NULL,
                material VARCHAR(20) NOT NULL,
                marca VARCHAR(20) NOT NULL,
                categoria_nombre VARCHAR(25) NOT NULL,
                PRIMARY KEY (id_articulo)
);

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
                cantidad_unidades_compradas NUMERIC(10) NOT NULL,
                PRIMARY KEY (id_tiempo, id_proveedor, id_articulo, id_tienda)
);

ALTER TABLE H_COMPRA MODIFY COLUMN compra_soles NUMERIC(10, 2) COMMENT 'Monto total de la transacción.';

ALTER TABLE H_COMPRA MODIFY COLUMN cantidad_unidades_compradas NUMERIC(10) COMMENT 'Número de unidades del producto de la transacción.';


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