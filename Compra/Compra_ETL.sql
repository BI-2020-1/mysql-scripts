SET @@lc_time_names = 'es_ES';

/* DIMENSION PRODUCTO */
INSERT INTO DARTICULO (
	codigo_articulo,
    articulo_nombre,
	categoria_nombre,
    talla,
    marca,
    material
)
SELECT  
	a.codigo,
    a.nombre,
    c.nombre,
    a.talla,
	m.nombre,
	a.material
FROM tienda_db.t_articulo as a
    inner join tienda_db.t_categoria as c on c.id_categoria = a.id_categoria
    inner join tienda_db.t_marca as m on m.id_marca = a.id_marca;
    
/* DIMENSION TIEMPO */
INSERT INTO DTIEMPO (
	fecha,
    mes,
    estacion_anio,
    anio
)
SELECT 
	date_format(v.fecha, '%Y-%m-%d') as Fecha,
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

/* DIMENSION TIENDA */
INSERT INTO DTIENDA(
	id_tienda,
	tienda_nombre,
    departamento,    
    provincia,
    distrito
)
SELECT
	1 as id_tienda,
	sis.tienda_nombre,
    sis.departamento,
    sis.provincia,
    sis.distrito
FROM tienda_db.t_sistema sis;

/* DIMENSION PROVEEDOR */
INSERT INTO DPROVEEDOR(
	proveedor_nombre
)
SELECT
	pv.razon_social
FROM tienda_db.t_proveedor pv;

/* HECHO VENTA */
SET collation_connection = latin1_spanish_ci;

INSERT INTO H_COMPRA (
	id_articulo,
	id_tienda,
    id_proveedor,
    id_tiempo,
    compra_monto,
    cantidad_unidades_compradas
)
SELECT
	DART.id_articulo,
    /*DT.id_tienda,*/
    1,
    DPROV.id_proveedor,
    DT.id_tiempo,
    sum(G.Compras) as COMPRA,
    sum(G.Cantidad) as CANT_UNID
FROM
	(
		SELECT 
			/*date_format(v.fecha, '%Y-%m-%d') AS Fecha,*/
	        DATE(v.fecha) AS Fecha,
			a.codigo,
            prov.razon_social AS Prov_nombre,
	        cdet.cantidad AS Cantidad,
	        cdet.cantidad*cdet.precio_unid AS Compras
		FROM tienda_db.t_compra AS c
			inner join tienda_db.t_compra_detalle as cdet ON c.id_compra = cdet.id_compra
			inner join tienda_db.t_articulo as a ON cdet.id_articulo = a.id_articulo
            inner join tienda_db.t_proveedor as prov ON c.id_proveedor = prov.id_proveedor
	) AS G
	inner join DARTICULO AS DART ON G.codigo = DART.codigo_articulo
	inner join DTIEMPO AS DT ON G.Fecha=DT.fecha AND G.Turno = DT.turno_dia
	inner join DPROVEEDOR AS DPROV ON G.Prov_nombre = DPROV.proveedor_nombre
	GROUP BY DART.id_articulo, DT.id_tiempo, DPROV.id_proveedor
;
