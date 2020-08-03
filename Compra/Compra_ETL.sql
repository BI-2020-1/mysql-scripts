SET @@lc_time_names = 'es_ES';

/* DIMENSION PRODUCTO */
INSERT INTO DARTICULO (
	codigo_articulo,
	categoria_nombre,
    talla,
    marca,
    material
)
SELECT
	a.codigo,
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
    num_mes,
    trimestre,
    num_trimestre,
    num_anio
)
SELECT 
	date_format(v.fecha, '%Y-%m-%d') as Fecha,
	MONTHNAME(v.fecha) AS Mes,
	MONTH(v.fecha) AS Num_mes,
	CONCAT('Trimestre ', QUARTER(v.fecha)) AS Trimestre,
	QUARTER(v.fecha) AS Num_trimestre,
	YEAR(v.fecha) AS Num_Anio
FROM tienda_db.t_venta AS v
	GROUP BY date_format(v.fecha, '%Y-%m-%d'), Mes, Num_mes, Trimestre, Num_trimestre, Num_Anio
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
    compra_soles,
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
	        DATE(c.fecha) AS Fecha,
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
	inner join DTIEMPO AS DT ON G.Fecha=DT.fecha
	inner join DPROVEEDOR AS DPROV ON G.Prov_nombre = DPROV.proveedor_nombre
	GROUP BY DART.id_articulo, DT.id_tiempo, DPROV.id_proveedor
;
