/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [codigo]
      ,[nombre]
      ,[Activo]
	  , null as analista
	  into InternationalBI.dbo.analistas
  FROM [Basico_InternationalLine_2018].[dbo].[Vendedores]
  -----------------------------------------------------------
  UPDATE InternationalBI.dbo.analistas
SET analista = 'Juana Meneses'
WHERE nombre like '%Andrea%'
AND activo = 'S'
---------------------------------------------

--cambiar imputacion = 1 para los cobros
SELECT concat(boleta.tipofactura, boleta.numero) as factura, boleta.tipofactura, boleta.numero, monedas.simbolo, boleta.total, 
asientos.monto as pagos, asientos.cambio, Asientos.fecha, boleta.vto, boleta.cliente, boleta.nrocliente, monedas.nombre, boleta.posicion, 
asientos.tipo, asientos.imputacion, analistas.nombre as vendedor, analistas.analista
into InternationalBI.dbo.pagos2

FROM Dataset_InternationalLine_2018.dbo.asientos
INNER JOIN Dataset_InternationalLine_2018.dbo.boleta ON (
	Dataset_InternationalLine_2018.dbo.boleta.fecha = Dataset_InternationalLine_2018.dbo.asientos.fecha 
	AND Dataset_InternationalLine_2018.dbo.asientos.documento = convert(varchar(10), Dataset_InternationalLine_2018.dbo.boleta.numero) 
	AND Dataset_InternationalLine_2018.dbo.asientos.cliente = Dataset_InternationalLine_2018.dbo.boleta.NROcliente)
INNER JOIN [Basico_InternationalLine_2018].[dbo].[Monedas] ON (
	[Basico_InternationalLine_2018].[dbo].[Monedas].codigo = asientos.Moneda)

INNER JOIN [Basico_InternationalLine_2018].[dbo].[clientes] ON (
	[Basico_InternationalLine_2018].[dbo].[clientes].codigo = boleta.nrocliente)
INNER JOIN [InternationalBI].[dbo].[analistas] ON ([InternationalBI].[dbo].[analistas].codigo = [Basico_InternationalLine_2018].[dbo].[clientes].vendedor)

WHERE Dataset_InternationalLine_2018.dbo.asientos.imputacion = 2
AND (Dataset_InternationalLine_2018.dbo.asientos.tipo = 'G' OR Dataset_InternationalLine_2018.dbo.asientos.tipo = 'P' OR Dataset_InternationalLine_2018.dbo.asientos.tipo = 'V' OR Dataset_InternationalLine_2018.dbo.asientos.tipo = 'Z')
AND asientos.cliente != 0


GROUP BY boleta.tipofactura, boleta.numero, monedas.simbolo, boleta.total, asientos.cambio, Asientos.fecha, boleta.vto, boleta.cliente, boleta.nrocliente, monedas.nombre, boleta.posicion, asientos.tipo
,asientos.imputacion, analistas.nombre, analistas.analista, asientos.monto

----------------------------------------------------------------------

SELECT c.factura, c.cobros, sum(p.pagos) as pagos, c.cambio as cambioCobro, p.cambio as cambioPagos, c.fecha as FechaFactura, max(p.fecha) as FechaPago,
/*
(CASE
	WHEN (c.posicion is not NULL OR c.posicion != 'S/I')
		THEN 
			(CASE
				WHEN impM.ETA is not null
					THEN impM.ETA
				WHEN impT.ETA is not null
					THEN impT.ETA
				WHEN impo.ETA is not NULL
					THEN impo.ETA
				WHEN expM.ETA is not NULL
					THEN expM.ETA
				WHEN expT.ETA is not NULL
					THEN expt.ETA
				WHEN expo.ETA is not NULL
					THEN expo.ETA
				ELSE
					NULL
				END)
				else
				NULL
	END) as ETA,
	*/
c.vto as FechaVencimiento, c.cliente, p.nombre as moneda, c.posicion, c.vendedor, c.analista

into finanzas

FROM [InternationalBI].[dbo].[pagos2] as p
LEFT JOIN [InternationalBI].[dbo].[cobros2] as c on (p.factura = c.factura)

/*
LEFT JOIN expmarit_2014.dbo.embarqueaereo as expM ON (expM.posicion = c.posicion)
LEFT JOIN export_2014.dbo.embarqueaereo as expo ON (expo.posicion = c.posicion)
LEFT JOIN expterra_2014.dbo.embarqueaereo as expT ON (expT.posicion = c.posicion)
LEFT JOIN impterra_2014.dbo.embarqueaereo as impT ON (impT.posicion = c.posicion)
LEFT JOIN impmarit_2014.dbo.embarqueaereo as impM ON (impM.posicion = c.posicion)
LEFT JOIN import_2014.dbo.embarqueaereo as impo ON (impo.posicion = c.posicion)
*/

--WHERE c.factura = 'E12314'

GROUP BY c.factura, c.cobros, c.cambio, p.cambio, c.fecha,

--impM.eta, impT.eta, impo.eta, expM.eta, expT.eta, expo.eta, 

c.vto, c.cliente, p.nombre, c.posicion, c.vendedor, c.analista

--factura E12314 problematica -> posicion = IM06-00556-2014, tanto en boleta como en impmarit_2014
