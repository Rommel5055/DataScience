SELECT boleta.tipofactura, boleta.numero, monedas.simbolo, boleta.total, boleta.MontoOriginal, asientos.cambio, boleta.fecha, boleta.vto, boleta.cliente, boleta.nrocliente, monedas.nombre, boleta.posicion
into InternationalBI.dbo.cobros

FROM Dataset_InternationalLine_2018.dbo.asientos
INNER JOIN Dataset_InternationalLine_2018.dbo.boleta ON (
	Dataset_InternationalLine_2018.dbo.boleta.fecha = Dataset_InternationalLine_2018.dbo.asientos.fecha 
	AND Dataset_InternationalLine_2018.dbo.asientos.documento = convert(varchar(10), Dataset_InternationalLine_2018.dbo.boleta.numero) 
	AND Dataset_InternationalLine_2018.dbo.asientos.cliente = Dataset_InternationalLine_2018.dbo.boleta.NROcliente)
INNER JOIN [Basico_InternationalLine_2018].[dbo].[Monedas] ON (
	[Basico_InternationalLine_2018].[dbo].[Monedas].codigo = boleta.Moneda)
WHERE Dataset_InternationalLine_2018.dbo.asientos.cuenta = 11401 AND Dataset_InternationalLine_2018.dbo.asientos.imputacion = 1

GROUP BY boleta.tipofactura, boleta.numero, monedas.simbolo, boleta.total, boleta.MontoOriginal, asientos.cambio, boleta.fecha, boleta.vto, boleta.cliente, boleta.nrocliente, monedas.nombre, boleta.posicion

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

SELECT REPLACE(movims.mdetalle, ';', '') as documento, monedas.simbolo, movims.mtotal, movims.mMontoOriginal, movims.mcambio, movims.mfechamov, movims.mvtomov, movims.mnombre, movims.mcliente, monedas.nombre, movims.mposicion
into InternationalBI.dbo.pagosTEMP
FROM Dataset_InternationalLine_2018.dbo.movims
INNER JOIN [Basico_InternationalLine_2018].[dbo].[Monedas] ON (
	[Basico_InternationalLine_2018].[dbo].[Monedas].codigo = movims.mMoneda)
WHERE [Dataset_InternationalLine_2018].[dbo].movims.mnombremov = 'COBRO' 
and (mdetalle like '1%' OR
  mdetalle like '2%' OR
  mdetalle like '3%' OR
  mdetalle like '4%' OR
  mdetalle like '5%' OR
  mdetalle like '6%' OR
  mdetalle like '7%' OR
  mdetalle like '8%' OR
  mdetalle like '9%' OR
  mdetalle like '0%')
  

AND LEN(movims.mdetalle) - LEN(REPLACE(movims.mdetalle, ';', '')) = 1
GROUP BY REPLACE(movims.mdetalle, ';', ''), monedas.simbolo, movims.mtotal, movims.mMontoOriginal, movims.mcambio, movims.mfechamov, movims.mvtomov, movims.mnombre, movims.mcliente, monedas.nombre, movims.mposicion



-----------------------------------
-----------------------------------

SELECT CONCAT(c.tipofactura, c.numero) as factura, 
c.cliente, 
c.nrocliente, 
c.total - p.mtotal as deudaDolares,
c.fecha as fechafactura, 
p.mfechamov as fechapago, 
c.vto as facturavencimiento, 
c.posicion,
c.total as PagarenDolares,
c.cambio as cambioPagar, p.mtotal as PagadoDolares, p.mcambio as cambioPagado

--into saldoTemp

FROM InternationalBI.dbo.cobros as c
LEFT JOIN InternationalBI.dbo.pagosTEMP as p ON (CONVERT(varchar(10), c.numero )= p.documento
	AND c.nrocliente = p.mcliente)

	GROUP BY 
	CONCAT(c.tipofactura, c.numero), 
c.cliente, 
c.nrocliente, 
c.total - p.mtotal,
c.fecha, 
p.mfechamov, 
c.vto, 
c.posicion,
c.total,
c.cambio, p.mtotal, p.mcambio
-------------------------------------------------------------------
