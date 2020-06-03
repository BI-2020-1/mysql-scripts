SET @@lc_time_names = 'es_ES';
/* DIMENSION PRODUCTO */
INSERT INTO DPRODUCTO (
	codigo_producto,
    producto_nombre,
    precio_compra,
    precio_venta,
	categoria_nombre,
    talla,
    marca,
    material
)
SELECT  
	a.codigo,
    a.nombre, 
    a.precio_compra,
    a.precio_venta,
    c.nombre,
    prod.variacion,
	m.nombre,
	a.descripcion
FROM tienda_db.t_articulo as a
	inner join tienda_db.t_producto as prod on prod.id_articulo = a.id_articulo
    inner join tienda_db.t_categoria as c on c.id_categoria = a.id_categoria
    inner join tienda_db.t_marca as m on m.id_marca = a.id_marca;
    
/* DIMENSION TIEMPO */
INSERT INTO DTIEMPO (
	fecha,
    turno_dia,
    dia_semana,
    mes,
    estacion_anio,
    anio
)
SELECT 
	date_format(v.fecha, '%Y-%m-%d') as Fecha,
    CASE
		WHEN HOUR(v.fecha)<12 THEN 'Turno mañana'
		WHEN HOUR(v.fecha)<18 THEN 'Turno tarde'
		ELSE 'Turno noche'
	END AS Turno,
    DAYNAME(v.fecha) AS Dia_semana,
	MONTHNAME(v.fecha ) AS Mes,
    CASE
		WHEN MONTH(v.fecha) <= 3 THEN 'Verano'
		WHEN MONTH(v.fecha) <= 6 THEN 'Otoño'
        WHEN MONTH(v.fecha) <= 9 THEN 'Invierno'
		ELSE 'Primavera'
    END AS Estacion,
	YEAR(v.fecha) AS Anio
FROM tienda_db.t_venta as v WHERE v.fecha IS NOT NULL
	GROUP BY date_format(v.fecha, '%Y-%m-%d'), Turno, Dia_semana, Mes, Estacion, Anio
	ORDER BY Fecha;  

/* DIMENSION CLIENTE */
INSERT INTO DCLIENTE(
	genero_cliente
)
SELECT
	v.genero
FROM tienda_db.t_cliente as v GROUP BY v.genero;

/* DIMENSION ATENDEDOR */
INSERT INTO DATENDEDOR(
	atendedor_nombre,
    genero
)
SELECT
	p.nombres,
    p.genero
FROM tienda_db.t_promotor p;

/* DIMENSION TIENDA */
INSERT INTO DTIENDA(
	tienda_nombre,
    departamento,
    distrito,
    provincia
)
SELECT
	sc.titulo,
    sc.departamento,
    sc.distrito,
    sc.provincia
FROM tienda_db.t_sistema_conf sc;

/* DIMENSION PROMOCION */
INSERT INTO DPROMOCION(
	promocion_nombre
)SELECT
	p.nombre
FROM tienda_db.t_promocion p;


SELECT @@lc_time_names;
 

set collation_connection = latin1_spanish_ci;

INSERT INTO H_VENTA (
	id_producto,
    id_atendedor,
    id_cliente,
    id_promocion,
	id_tienda,
    id_tiempo,
    venta_monto,
    cantidad_unidades_vendidas,    
    descuento,
    compra_soles
)
SELECT
	DPROD.id_producto,
    DATEND.id_atendedor,
    DCLI.id_cliente,
    DPROM.id_promocion,
    /*DT.id_tienda,*/
    1,
    DT.id_tiempo,
    sum(G.Ventas) as VENTA,
    sum(G.Cantidad) as CANT_UNID,
    sum(G.Descuento) as DESCTO,
    sum(G.Costos) as COSTO
FROM
	 (
	SELECT  
		/*date_format(v.fecha, '%Y-%m-%d') AS Fecha,*/
        DATE(v.fecha) AS Fecha,
        CASE
			WHEN HOUR(v.fecha)<12 THEN 'Turno mañana'
			WHEN HOUR(v.fecha)<18 THEN 'Turno tarde'
			ELSE 'Turno noche'
		END AS Turno,
		a.codigo,
        vdet.cantidad as Cantidad,
        p.variacion as Talla,
        vdet.cantidad*vdet.precio_compra_unid as Costos,
        vdet.cantidad*(vdet.precio_venta_unid - vdet.descuento) as Ventas,
        vdet.cantidad*(vdet.descuento) as Descuento,
        cli.genero,
        pr.nombres as nombreAtend,
        prom.nombre as nombreProm
	FROM tienda_db.t_venta as v
		inner join tienda_db.t_venta_detalle as vdet on v.id_venta = vdet.id_venta
		inner join tienda_db.t_producto as p on vdet.id_producto = p.id_producto
        inner join tienda_db.t_articulo as a on p.id_articulo = a.id_articulo
        inner join tienda_db.t_cliente as cli on v.id_cliente = cli.id_cliente
        inner join tienda_db.t_promotor as pr on v.id_promotor = pr.id_promotor
        inner join tienda_db.t_promocion as prom on vdet.id_promocion = prom.id_promocion
	) AS G
    inner join DPRODUCTO AS DPROD ON G.codigo = DPROD.codigo_producto AND G.talla = DPROD.talla
    inner join DTIEMPO AS DT ON G.Fecha=DT.fecha AND G.Turno = DT.turno_dia
    inner join DCLIENTE AS DCLI ON G.genero = DCLI.genero_cliente
    inner join DATENDEDOR AS DATEND ON G.nombreAtend = DATEND.atendedor_nombre
    inner join DPROMOCION AS DPROM ON G.nombreProm = DPROM.promocion_nombre
	GROUP BY DPROD.id_producto, DT.id_tiempo, DCLI.id_cliente, DATEND.id_atendedor, DPROM.id_promocion
;

-- show variables like 'col%';
-- SHOW VARIABLES LIKE '%character_set%';