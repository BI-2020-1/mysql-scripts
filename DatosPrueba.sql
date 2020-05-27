INSERT INTO t_almacen VALUES(null,'Almacen 1','Juan Carlos Diaz Morán','A');

INSERT INTO t_usuario VALUES
(null,'dmanani','2c21fcd2225dcb69b07387ef375b11a2deaafafc','Diego','Mamani Mamani','vendedor','A'),
(null,'jgutierrez','40e65de0c810722a3cd63c087f268291a517d8cd','Jorge','Gutierrez Herrera','vendedor','A'),
(null,'ltorres','e8cff48c47f96978602c893c2a5ff1ad0ec82a5d','Lucas Antonio','Torres Lopez','almacenero','A'),
(null,'mflores','32136156e257d353f9d07be6ca0ca5a5218e00b1','María Jesus','Flores Turpo','vendedor','A');

INSERT INTO t_categoria VALUES
(null,'Polo','A'),
(null,'Blusa','A'),
(null,'Camisa','A'),
(null,'Casaca','A'),
(null,'Chompa','A'),
(null,'Poleron','A'),
(null,'Jean','A'),
(null,'Pantalon','A'),
(null,'Short','A'),
(null,'Falda','A'),
(null,'Abrigo','A');

INSERT INTO t_marca VALUES
(null,'Index','A'),
(null,'Barbados','A'),
(null,'Mossimo','A'),
(null,'Mango','A'),
(null,'Levis','A');

INSERT INTO t_articulo(tipo,codigo,nombre,descripcion,precio_venta,precio_compra,id_categoria,id_marca,estado)
VALUES
('superior','10000001','Polo manga corta Star Wars','Gamuza',19.00,12.00,1,1,'A'),
('inferior','10000002','Polo básico manga larga Index','Algodón',20.00,15.00,1,1,'A'),
('inferior','10000003','Jean Semi pitillo azul','Denim',88.00,60.00,7,3,'A'),
('inferior','10000004','Pantalon negro pitillo','Algodón',120.00,90.00,8,3,'A'),
('superior','10000005','Casaca con cierre dorado','Poliester',75.00,60.00,4,2,'A'),
('inferior','10000006','Falda jean con líneas','Denim',69.00,55.00,10,4,'A'),
('superior','10000007','Abrigo de lana LuckyCat','Lana',99.00,89.00,11,5,'A');

INSERT INTO t_producto VALUES
(null,1,'Talla S'),
(null,1,'Talla M'),
(null,1,'Talla L'),
(null,2,'Talla M'),
(null,2,'Talla L'),
(null,3,'Talla 36'),
(null,3,'Talla 38'),
(null,3,'Talla 40'),
(null,3,'Talla 42'),
(null,4,'Talla 36'),
(null,4,'Talla 38'),
(null,4,'Talla 40'),
(null,5,'Talla S'),
(null,5,'Talla M'),
(null,5,'Talla L'),
(null,6,'Talla 36'),
(null,6,'Talla 38'),
(null,6,'Talla 40'),
(null,6,'Talla 42'),
(null,7,'Talla S'),
(null,7,'Talla M');

/*DELETE FROM producto;

ALTER TABLE producto AUTO_INCREMENT = 1;*/

INSERT INTO t_proveedor VALUES
(null,'Proveedor Index','ruc','48213878101','972823851','A'),
(null,'Proveedor Pants','ruc','542395841','951354891','A'),
(null,'Proveedor Ropa Mujer','ruc','98418219821','968742990','A');

INSERT INTO t_compra VALUES
(null,'2020-04-15','Factura','1008010119',14640.0,1,1,1),
(null,'2020-04-16','Factura','1008010119',25800.0,1,2,1),
(null,'2020-04-16','Factura','1008010119',19480.0,1,3,1);

INSERT INTO t_compra_detalle VALUES
(null,90,12.00,1,1),
(null,90,12.00,2,1),
(null,90,12.00,3,1),
(null,80,15.00,4,1),
(null,80,15.00,5,1),

(null,40,60.00,6,2),
(null,40,60.00,7,2),
(null,40,60.00,8,2),
(null,40,60.00,9,2),
(null,60,90.00,10,2),
(null,60,90.00,11,2),
(null,60,90.00,12,2),

(null,50,60.00,13,1),
(null,50,60.00,14,1),
(null,50,60.00,15,1),

(null,40,55.00,16,3),
(null,40,55.00,17,3),
(null,40,55.00,18,3),
(null,40,55.00,19,3),
(null,60,89.00,20,3),
(null,60,89.00,21,3);

INSERT INTO t_cliente VALUES
(null,'Josue Jimenez','M'),
(null,'Raul Perez','M'),
(null,'Valeria Ramos','F');

INSERT INTO t_promotor VALUES
(null,'20198493','Caleb','Condor','M','A'),
(null,'20198493','Ana','Guzman','F','A');

INSERT INTO t_venta VALUES
(null,'2020-05-12 09:12','Efectivo',38.0,1,2,1),
(null,'2020-05-12 10:55','Debito',120.0,2,2,2),
(null,'2020-05-13 14:33','Efectivo',158.1,3,2,2);

INSERT INTO t_promocion VALUES
(null,'10% descuento en abrigos','A');

INSERT INTO t_venta_detalle VALUES
(null,2,19.0,12.00,0,1,1,null),
(null,1,120.0,90.00,0,11,2,null),
(null,1,69.0,55.00,0,16,3,null),
(null,1,99.0,89.00,9.9,21,3,1);

INSERT INTO tienda_db.t_sistema_conf VALUES(
	1,'Tienda Centro Comercial Juliaca','Puno','Juliaca','San Román'
);