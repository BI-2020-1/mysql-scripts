INSERT INTO t_almacen(
	nombre,
	encargado,
	estado
) VALUES('Almacen 1','Juan Carlos Diaz Morán','A');

INSERT INTO t_usuario(
	nusuario,
	password,
	nombres,
	apellidos,
	rol,
	estado
)
VALUES
('dmanani','2c21fcd2225dcb69b07387ef375b11a2deaafafc','Diego','Mamani Mamani','vendedor','A'),
('jgutierrez','40e65de0c810722a3cd63c087f268291a517d8cd','Jorge','Gutierrez Herrera','vendedor','A'),
('ltorres','e8cff48c47f96978602c893c2a5ff1ad0ec82a5d','Lucas Antonio','Torres Lopez','almacenero','A'),
('mflores','32136156e257d353f9d07be6ca0ca5a5218e00b1','María Jesus','Flores Turpo','vendedor','A');

INSERT INTO t_categoria(
	nombre,
	estado
)
VALUES
('Polo','A'),
('Blusa','A'),
('Camisa','A'),
('Casaca','A'),
('Chompa','A'),
('Poleron','A'),
('Jean','A'),
('Pantalon','A'),
('Short','A'),
('Falda','A'),
('Abrigo','A');

INSERT INTO t_marca(
	nombre,
	estado
)
VALUES
('Index','A'),
('Barbados','A'),
('Mossimo','A'),
('Mango','A'),
('Levis','A');

INSERT INTO t_articulo(
	tipo,
	codigo,
	nombre,
	descripcion,
	precio_venta,
	precio_compra,
	id_categoria,
	id_marca,
	estado
)
VALUES
('superior','10000001','Polo manga corta Star Wars','Gamuza',19.00,12.00,1,1,'A'),
('inferior','10000002','Polo básico manga larga Index','Algodón',20.00,15.00,1,1,'A'),
('inferior','10000003','Jean Semi pitillo azul','Denim',88.00,60.00,7,3,'A'),
('inferior','10000004','Pantalon negro pitillo','Algodón',120.00,90.00,8,3,'A'),
('superior','10000005','Casaca con cierre dorado','Poliester',75.00,60.00,4,2,'A'),
('inferior','10000006','Falda jean con líneas','Denim',69.00,55.00,10,4,'A'),
('superior','10000007','Abrigo de lana LuckyCat','Lana',99.00,89.00,11,5,'A');

INSERT INTO t_producto(
	id_articulo,
	variacion
)
VALUES
(1,'Talla S'),
(1,'Talla M'),
(1,'Talla L'),
(2,'Talla M'),
(2,'Talla L'),
(3,'Talla 36'),
(3,'Talla 38'),
(3,'Talla 40'),
(3,'Talla 42'),
(4,'Talla 36'),
(4,'Talla 38'),
(4,'Talla 40'),
(5,'Talla S'),
(5,'Talla M'),
(5,'Talla L'),
(6,'Talla 36'),
(6,'Talla 38'),
(6,'Talla 40'),
(6,'Talla 42'),
(7,'Talla S'),
(7,'Talla M');

/*DELETE FROM producto;

ALTER TABLE producto AUTO_INCREMENT = 1;*/

INSERT INTO t_proveedor(
	razon_social,
	tipo_documento,
	numero_documento,
	telefono,
	estado
)
VALUES
('Proveedor Index','ruc','48213878101','972823851','A'),
('Proveedor Pants','ruc','542395841','951354891','A'),
('Proveedor Ropa Mujer','ruc','98418219821','968742990','A');

INSERT INTO t_compra(
	fecha,
	tipo_comprobante,
	numero_comprobante,
	importe,
	id_usuario,
	id_proveedor,
	id_almacen
)
VALUES
('2020-04-15','Factura','1008010119',14640.0,1,1,1),
('2020-04-16','Factura','1008010119',25800.0,1,2,1),
('2020-04-16','Factura','1008010119',19480.0,1,3,1);

INSERT INTO t_compra_detalle(
	cantidad,
	precio_unid,
	id_producto,
	id_compra
)
VALUES
(90,12.00,1,1),
(90,12.00,2,1),
(90,12.00,3,1),
(80,15.00,4,1),
(80,15.00,5,1),

(40,60.00,6,2),
(40,60.00,7,2),
(40,60.00,8,2),
(40,60.00,9,2),
(60,90.00,10,2),
(60,90.00,11,2),
(60,90.00,12,2),

(50,60.00,13,1),
(50,60.00,14,1),
(50,60.00,15,1),

(40,55.00,16,3),
(40,55.00,17,3),
(40,55.00,18,3),
(40,55.00,19,3),
(60,89.00,20,3),
(60,89.00,21,3);

INSERT INTO t_cliente(
	nombres,
	genero
)
VALUES
('Josue Jimenez','M'),
('Raul Perez','M'),
('Valeria Ramos','F');

INSERT INTO t_promotor(
	codigo,
	nombres,
	apellidos,
	genero,
	estado
)
VALUES
('20198493','Caleb','Condor','M','A'),
('20198493','Ana','Guzman','F','A');

INSERT INTO t_venta(
	fecha,
	tipo_pago,
	monto_total,
	id_cliente,
	id_usuario,
	id_promotor
)
VALUES
('2020-05-12 09:12','Efectivo',38.0,1,2,1),
('2020-05-12 10:55','Debito',120.0,2,2,2),
('2020-05-13 14:33','Efectivo',158.1,3,2,2);

INSERT INTO t_promocion(
	id_promocion,
	nombre,
	estado
)
VALUES
(1,'Sin promoción','A'),
(null,'10% descuento en abrigos','A');

INSERT INTO t_venta_detalle(
	cantidad,
	precio_venta_unid,
	precio_compra_unid,
	descuento,
	id_producto,
	id_venta,
	id_promocion
)
VALUES
(2,19.0,12.00,0,1,1,1),
(1,120.0,90.00,0,11,2,1),
(1,69.0,55.00,0,16,3,1),
(1,99.0,89.00,9.9,21,3,2);

INSERT INTO t_sistema_conf(
	id_sistema_conf,
	titulo,
	departamento,
	distrito,
	provincia
)
VALUES(
	1,'Tienda Centro Comercial Juliaca','Puno','Juliaca','San Román'
);