
SELECT 
	DP.material,
	sum(venta_monto) AS TOTAL_VENTAS
	FROM H_VENTA AS HV
	inner join DARTICULO AS DA ON HV.id_articulo = DA.id_articulo
GROUP BY DP.material;

SELECT 
	DP.talla,
	sum(venta_monto) AS TOTAL_VENTAS
	FROM H_VENTA AS HV
	inner join DARTICULO AS DA ON HV.id_articulo = DA.id_articulo
GROUP BY DP.talla;

SELECT 
	DP.categoria_nombre,
	sum(venta_monto) AS TOTAL_VENTAS
	FROM H_VENTA AS HV
	inner join DARTICULO AS DP ON HV.id_articulo = DA.id_articulo
GROUP BY DP.categoria_nombre;
 
SELECT 
	sum(venta_monto) as Ventas
FROM venta_dm.H_VENTA as HP;

SELECT 
		DT.turno_dia,
		sum(venta_monto) as Ventas
FROM venta_dm.H_VENTA as HV
	inner join DTIEMPO AS DT ON HV.id_tiempo = DT.id_tiempo
GROUP BY DT.turno_dia;
    
SELECT 
	DT.dia_semana,
	sum(cantidad_unidades_vendidas) as cantidad
FROM venta_dm.H_VENTA as HV
	inner join DTIEMPO AS DT ON HV.id_tiempo = DT.id_tiempo
GROUP BY DT.dia_semana;
    